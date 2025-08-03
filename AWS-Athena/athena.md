# Athena table setup and Queries:

## IAM Policy for Athena Read only access

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AthenaReadOnly",
      "Effect": "Allow",
      "Action": [
        "athena:StartQueryExecution",
        "athena:GetQueryResults",
        "s3:ListMultipartUploadParts",
        "athena:GetWorkGroup",
        "s3:PutObject",
        "s3:GetObject",
        "s3:AbortMultipartUpload",
        "athena:StopQueryExecution",
        "athena:GetQueryExecution",
        "s3:GetBucketLocation"
      ],
      "Resource": [
        "arn:aws:athena:*:*:workgroup/primary",
        "arn:aws:s3:::test-athena-1010/*"
      ]
    },
    {
      "Sid": "AthenaListWorkGroups",
      "Effect": "Allow",
      "Action": "athena:ListWorkGroups",
      "Resource": "*"
    }
  ]
}
```

## Setup S3 Data lake

On your cloud watch logs, export your logs to the required S3 bucket (Example - **athena-cloudwatch-logs**). The export of the logs can be scheduled to run every day. The logs will be organized per day basis.

## Athena table setup for ALB access logs.

### Athena table creation

The application load balancer access logs logs have structured data. Meaning the columns are fixed.

```
CREATE EXTERNAL TABLE IF NOT EXISTS alb_access_logs (
            type string,
            time string,
            elb string,
            client_ip string,
            client_port int,
            target_ip string,
            target_port int,
            request_processing_time double,
            target_processing_time double,
            response_processing_time double,
            elb_status_code int,
            target_status_code string,
            received_bytes bigint,
            sent_bytes bigint,
            request_verb string,
            request_url string,
            request_proto string,
            user_agent string,
            ssl_cipher string,
            ssl_protocol string,
            target_group_arn string,
            trace_id string,
            domain_name string,
            chosen_cert_arn string,
            matched_rule_priority string,
            request_creation_time string,
            actions_executed string,
            redirect_url string,
            lambda_error_reason string,
            target_port_list string,
            target_status_code_list string,
            classification string,
            classification_reason string,
            conn_trace_id string
            )
            ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
            WITH SERDEPROPERTIES (
            'serialization.format' = '1',
            'input.regex' = 
        '([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \"([^ ]*) (.*) (- |[^ ]*)\" \"([^\"]*)\" ([A-Z0-9-_]+) ([A-Za-z0-9.-]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" ([-.0-9]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^ ]*)\" \"([^\\s]+?)\" \"([^\\s]+)\" \"([^ ]*)\" \"([^ ]*)\" ?([^ ]*)?'
            )
            LOCATION 's3://amzn-s3-demo-bucket/access-log-folder-path/'

```

### Sample queries

- Get recent ALB access log entries

```
SELECT *
FROM alb_access_logs
ORDER BY time DESC
LIMIT 10;
```

- Count of requests per client IP

```
SELECT client_ip, COUNT(*) AS request_count
FROM alb_access_logs
GROUP BY client_ip
ORDER BY request_count DESC
LIMIT 10;
```

- Top 10 most accessed URLs

```
SELECT request_url, COUNT(*) AS hits
FROM alb_access_logs
GROUP BY request_url
ORDER BY hits DESC
LIMIT 10;
```

- Count of requests by HTTP method

```
SELECT request_verb, COUNT(*) AS total
FROM alb_access_logs
GROUP BY request_verb;
```

- Requests grouped by hour

```
SELECT date_format(parse_datetime(time, 'yyyy-MM-dd\'T\'HH:mm:ss.SSSSSS\'Z\'), '%Y-%m-%d %H:00:00') AS hour,
       COUNT(*) AS total_requests
FROM alb_access_logs
GROUP BY hour
ORDER BY hour;
```

- Requests with non-200 status codes

```
SELECT time, client_ip, request_verb, request_url, elb_status_code
FROM alb_access_logs
WHERE elb_status_code != 200
ORDER BY time DESC
LIMIT 20;
```

- Top slowest requests by target processing time

```
SELECT time, request_verb, request_url, target_processing_time
FROM alb_access_logs
ORDER BY target_processing_time DESC
LIMIT 10;
```

- Requests resulting in redirect (HTTP 301 or 302)

```
SELECT time, request_url, elb_status_code, redirect_url
FROM alb_access_logs
WHERE elb_status_code IN (301, 302);
```

- Total bytes sent and received per IP

```
SELECT client_ip,
       SUM(sent_bytes) AS total_sent,
       SUM(received_bytes) AS total_received
FROM alb_access_logs
GROUP BY client_ip
ORDER BY total_sent DESC;

```

- Count requests by domain name

```
SELECT domain_name, COUNT(*) AS request_count
FROM alb_access_logs
GROUP BY domain_name
ORDER BY request_count DESC;
```

## Athena table setup for application logs

If the application deployed on **Elastic beanstalk** or **VM** these does not have a structured logs. Meaning the columns are not predifined unlike load balancer logs. Based on the logs format we need to structure them to query.

**Need for Athena table and queries**<br/>
Here the use case is to query for the logs with the **identity (name of the company)** along with the **http status code**. The identity and status are not available in the single log. They are available in two different lines of log, but these two logs are having the same **UUID** number.

```
CREATE EXTERNAL TABLE IF NOT EXISTS p2 (
  timestamp1 string,
  timestamp2 string,
  host string,
  scp string,
  http2server string,
  uuid1 string,
  uuid2 string,
  uuid3 string,
  filename string,
  app_logs string
)
ROW FORMAT SERDE 'com.amazonaws.glue.serde.GrokSerDe'
WITH SERDEPROPERTIES (
  'input.format' = '%{TIMESTAMP_ISO8601:timestamp1} %{SYSLOGTIMESTAMP:timestamp} %{USER:host} %{NOTSPACE:scp} %{NOTSPACE:http2server}\\|%{UUID:uuid1}\\|%{UUID:uuid2}\\|%{UUID:uuid3}\\|%{NOTSPACE:some_string}\\|%{GREEDYDATA:kernel_logs}'
)
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://athena-cloudwatch-logs/'
TBLPROPERTIES (
  "projection.enabled" = "true",
  "projection.day.type" = "date",
  "projection.day.range" = "2022/01/01,NOW",
  "projection.day.format" = "yyyy/MM/dd",
  "projection.day.interval" = "1",
  "projection.day.interval.unit" = "DAYS",
  "storage.location.template" = "s3://athena-cloudwatch-logs/${day}"
);

```

## Create Views (If required) on the Athena table

Create views only the Athena table to get the status code and identity

status_view
```
CREATE or replace VIEW status_view AS 
SELECT timestamp1, uuid1, app_logs
FROM p2
WHERE app_logs like '%http status code%';
```

identity_view
```
CREATE or replace VIEW identity_view AS 
SELECT  timestamp1, uuid1, app_logs
FROM p2
WHERE app_logs like '%identity%';
```

Now query by joining the views

```
SELECT b.uuid1
, b.timestamp1
, regexp_replace(b.app_logs, '.*:.*:', ' ') identity
, regexp_extract(a.app_logs, '\d\d\d') http_status_code
FROM status_view a, identity_view b
WHERE a.uuid1=b.uuid1
order by http_status_code desc, identity;
```

**Sample Output** All status 200 transaction with identity in the selected log file
```
#  uuid1  timestamp1  identity  http_status_code
1  ********-****-****-****-************  2023-11-16T02:39:10.945Z  example.com 200
2  ********-****-****-****-************  2023-11-16T01:30:58.467Z  example.com 200
3  ********-****-****-****-************  2023-11-16T02:39:10.945Z  example.com 200
4  ********-****-****-****-************  2023-11-16T02:05:18.693Z  example.com 200
5  ********-****-****-****-************  2023-11-16T02:39:12.946Z  example.com 200
6  ********-****-****-****-************  2023-11-16T02:05:29.699Z  example.com 200
7  ********-****-****-****-************  2023-11-16T02:39:30.957Z  example.com 200
8  ********-****-****-****-************  2023-11-16T02:05:30.700Z  example.com 200
9  ********-****-****-****-************  2023-11-16T02:39:30.957Z  example.com 200
10  ********-****-****-****-************  2023-11-16T02:06:09.723Z  example.com 200

```

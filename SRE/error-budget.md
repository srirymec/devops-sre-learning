# Error budget

In a nutshell, an **error budget** is the amount of error that your service can accumulate over a certain period of time before your users start being unhappy. You can think of it as the pain tolerance for your users, but applied to a certain dimension of your ***service: availability, latency, and so forth.***

SLI equation as per [Google SRE](https://sre.google/resources/practices-and-processes/art-of-slos/),

![sli](https://github.com/srirymec/devops-sre-learning/blob/main/SRE/images/sli.jpg)

Your SLI is then expressed as a percentage, and once you define an objective for each of those SLIs - that is, your service-level objective (SLO), ***the error budget is the remainder, up to 100.***

Here’s an example. 
---

Imagine that you’re measuring the availability of your home page. The availability **(SLI)** is measured by the amount of requests responded with an error, divided by all the valid requests the home page receives, expressed as a percentage. If you decide that the objective **(SLO)** of that availability is 99.9%, the error budget is 0.1%. You can serve up to 0.1% of errors (preferably a bit less than 0.1%), and users will happily continue using the service.

``` Error budget = ```

class nginx($port){
  package{"nginx":
   ensure=> installed,
 }

 file{"nginx.conf":
  path=>"/etc/nginx/nginx.conf",
  content=>template("nginx/nginx.erb"),
  notify=>Service["nginx"],
 }

 service{"nginx":
  ensure=> running,
  enable=> true,
 }

 Package["nginx"]->File["nginx.conf"]->Service["nginx"]
}

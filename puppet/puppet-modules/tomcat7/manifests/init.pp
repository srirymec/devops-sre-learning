class tomcat7{
  #exec { "apt-update":
  # path => [ '/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
  #  command => "yum update -y",
  #}
  package{'tomcat7':
    ensure => installed,
  }
  package{'tomcat7-admin-webapps':
    ensure => installed,
  }  
  package{'tomcat7-docs-webapp':
    ensure => installed,
  }
  
  Package['tomcat7'] ->  Package['tomcat7-admin-webapps'] ->Package['tomcat7-docs-webapp']

 #tomcat7-docs-webapp.noarch             7.0.37-1.24.amzn1            amzn-main
 #tomcat7-javadoc.noarch
}

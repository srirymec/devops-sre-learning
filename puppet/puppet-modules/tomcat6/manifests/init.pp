class tomcat6{
  #exec { 'yum-update':
   # path => [ '/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'],
   # command => 'yum update -y',
  #}
  package{'tomcat6':
    ensure => installed,
  }
 package{'tomcat6-webapps':
   ensure => installed,
}
 
  package{'tomcat6-admin-webapps':
    ensure => installed,
  }
  package{'tomcat6-docs-webapp':
    ensure => installed,
  }
 file{"tomcatUsersXml":
  path=> "/usr/share/tomcat6/tomcat-users.xml",
 ensure=> file,
 source=> "puppet:///modules/tomcat6/tomcat-users.xml"
 }
  
 Package['tomcat6'] -> Package['tomcat6-admin-webapps'] -> Package['tomcat6-admin-webapps'] -> Package['tomcat6-docs-webapp']-> File['tomcatUsersXml']
}

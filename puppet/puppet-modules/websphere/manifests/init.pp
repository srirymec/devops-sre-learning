class websphere($serverName="websphere",$rdsEndPoint){

   file{'websphere-rpm':
    path => "/opt/websphere-mindtree-0.1-1.amzn1.i686.rpm",
    ensure => file,
    source => 'puppet:///modules/websphere/websphere-mindtree-0.1-1.amzn1.i686.rpm', 
   }
   
   exec{"installWasRpm":
    command =>"/usr/bin/yum -y install /opt/websphere-mindtree-0.1-1.amzn1.i686.rpm",
    creates=>"/opt/websphere",
   } 
   
  
   exec {"createWasServer":
   command =>"/opt/websphere/bin/server create ${serverName}",
   creates=>"/opt/websphere/usr/servers/${serverName}",
   }

   file{'mysqlLibs-dir':
    path => "/opt/websphere/usr/shared/resources/mysqlLibs",
    ensure => "directory",
   }

   file{'mysql-connector':
    path => "/opt/websphere/usr/shared/resources/mysqlLibs/mysql-connector-java-5.1.24.jar",
    ensure => file,
    source => 'puppet:///modules/websphere/mysql-connector-java-5.1.24.jar',
   }

    file{'server.xml':
    path => "/opt/websphere/usr/servers/${serverName}/server.xml",
    ensure => file,
    #source => 'puppet:///modules/websphere/server.xml',
    content=>template("websphere/server.erb"),
    notify => Service["websphere"],
   }

   file{'websphere-service':
    path => "/etc/init.d/websphere",
    ensure => file,
    #source => 'puppet:///modules/websphere/websphere',
    content=>template("websphere/websphere.erb"),
    mode=>755,
   }

   exec{"chkConfig-add":
   command=>"/sbin/chkconfig --add /etc/init.d/websphere",
   }

   exec{"chkConfig-level":
   command=>"/sbin/chkconfig --level 234 websphere on ",
   }


   file{'application-war':
    path => "/opt/websphere/usr/servers/${serverName}/dropins/Employee.war",
    ensure => file,
    source => 'puppet:///modules/websphere/Employee.war',
    notify => Service["websphere"],
   }

   
   service{"websphere":
     ensure=> running,
   }

   File["websphere-rpm"]->Exec["installWasRpm"]->Exec["createWasServer"]->File['websphere-service']-> 
   Exec["chkConfig-add"]-> Exec["chkConfig-level"]-> File["mysqlLibs-dir"]->File["mysql-connector"]-> 
   File['application-war']-> File['server.xml'] -> Service["websphere"]

}


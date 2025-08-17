class vehiclerentalbusiness($username,
    $password,
    $rdsEndPoint,
    $port='3306',
    $database='UNSET',
    $tomcatv="tomcat6"){

  include "${tomcatv}"

  service{"${tomcatv}":
    ensure => running,
    enable => true,
  }
  file{"tomcatContext":
    path => "/usr/share/${tomcatv}/conf/context.xml",
    ensure => file,
    #source => "puppet:///modules/vehiclerentalbusiness/context.xml",
    content => template("vehiclerentalbusiness/context.erb"),
    notify => Service["${tomcatv}"],
  }
  file{"mysql-connector":
    path => "/usr/share/${tomcatv}/lib/mysql-connector-java-5.1.24.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalbusiness/mysql-connector-java-5.1.24.jar",
  }
  file{"dbcp-jar":
    path => "/usr/share/${tomcatv}/lib/dbcp-6.0.36.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalbusiness/dbcp-6.0.36.jar",
  }
  file{'application-war':
    path => "/usr/share/${tomcatv}/webapps/VehicleBusiness.war",
    ensure => file,
    source => "puppet:///modules/vehiclerentalbusiness/VehicleBusiness.war",
  }
  Package["${tomcatv}"] -> File["mysql-connector"] -> File["dbcp-jar"] -> File["tomcatContext"] -> File["application-war"] -> Service["${tomcatv}"]
}

class vehiclerentalpresentation($busiElb, $tomcatv="tomcat6",$memIp, $cfEndPoint){

  include "${tomcatv}"

  service{"${tomcatv}":
    ensure => running,
    enable => true,
  }

  file{"application-war":
    path => "/usr/share/${tomcatv}/webapps/VehiclePresentation.war",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/VehiclePresentation.war",
    notify => Service["${tomcatv}"],
  }
  file{"presContext":
   path => "/usr/share/${tomcatv}/conf/context.xml",
   ensure => file,
   #source => "puppet:///modules/vehiclerentalpresentation/context.xml",
   content => template("vehiclerentalpresentation/context.erb"),
   notify => Service["${tomcatv}"],
  }

  file{"asm-3.2.jar":
    path=>"/usr/share/java/${tomcatv}/asm-3.2.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/asm-3.2.jar",    
  }


  file{"kryo-1.04.jar":
    path=>"/usr/share/java/${tomcatv}/kryo-1.04.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/kryo-1.04.jar",
  }

  file{"kryo-serializers-0.9.jar":
    path=>"/usr/share/java/${tomcatv}/kryo-serializers-0.9.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/kryo-serializers-0.9.jar",
  }
  file{"memcached-session-manager-1.6.0.jar":
    path=>"/usr/share/java/${tomcatv}/memcached-session-manager-1.6.0.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/memcached-session-manager-1.6.0.jar",
  }

  file{"memcached-session-manager-tc6-1.6.0.jar":
    path=>"/usr/share/java/tomcat6/memcached-session-manager-tc6-1.6.0.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/memcached-session-manager-tc6-1.6.0.jar",
  }

  file{"minlog-1.2.jar":
    path=>"/usr/share/java/${tomcatv}/minlog-1.2.jar",
    ensure =>file,
    source => "puppet:///modules/vehiclerentalpresentation/minlog-1.2.jar",
  }

  file{"msm-kryo-serializer-1.6.0.jar":
    path=>"/usr/share/java/${tomcatv}/msm-kryo-serializer-1.6.0.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/msm-kryo-serializer-1.6.0.jar",    
  }

  file{"reflectasm-1.01.jar":
    path=>"/usr/share/java/${tomcatv}/reflectasm-1.01.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/reflectasm-1.01.jar",    
  }
  file{"spymemcached-2.7.3.jar":
    path=>"/usr/share/java/${tomcatv}/spymemcached-2.7.3.jar",
    ensure => file,
    source => "puppet:///modules/vehiclerentalpresentation/spymemcached-2.7.3.jar",
  }

  Package["${tomcatv}"] -> File["application-war"] -> File["presContext"]-> File["asm-3.2.jar"]-> File["kryo-1.04.jar"]-> File["kryo-serializers-0.9.jar"] ->  File["memcached-session-manager-1.6.0.jar"] ->  File["memcached-session-manager-tc6-1.6.0.jar"] ->  File["minlog-1.2.jar"]-> File["msm-kryo-serializer-1.6.0.jar"]->File["spymemcached-2.7.3.jar"]-> File["reflectasm-1.01.jar"] -> Service["${tomcatv}"]
}

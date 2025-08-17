class mcoll {

  $mcollpackages=["mcollective", "mcollective-common", "mcollective-facter-facts", "mcollective-filemgr-agent", "mcollective-filemgr-common", "mcollective-iptables-agent", "mcollective-iptables-common", "mcollective-logstash-audit", "mcollective-nettest-agent", "mcollective-nettest-common", "mcollective-nrpe-agent", "mcollective-nrpe-common", "mcollective-package-agent", "mcollective-package-common", "mcollective-puppet-agent", "mcollective-puppet-common", "mcollective-service-agent", "mcollective-service-common", "mcollective-sysctl-data"]
  file{"/etc/mcollective/facts.yaml":
   owner    => root,
   group    => root,
   mode     => 400,
   loglevel => debug,  # this is needed to avoid it being logged and reported on every run
   # avoid including highly-dynamic facts as they will cause unnecessary template writes
   content  => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.to_yaml %>"),
  }

   file{'/etc/mcollective/server.cfg':
    source => 'puppet:///modules/mcoll/server.cfg',
  #  require => Package[$mcollpack],
  #  notify => Service['mcollective'],
  }

  exec{"puppet_repo":
    command => "rpm -ivh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm",
    path => "/bin",
    creates=>"/etc/mcollective/server.cfg"
  }
  service{'mcollective':
    ensure => running,
    enable => true,
    subscribe=>File['/etc/mcollective/server.cfg'],
  }

  package{$mcollpackages:
    ensure => installed,
  }
#  file{'/etc/mcollective/server.cfg':
 #   source => 'puppet:///modules/clients/server.cfg',
  #  require => Package[$mcollpack],
 #   notify => Service['mcollective'],
 # }
  
Exec["puppet_repo"] -> Package[$mcollpackages]->File["/etc/mcollective/server.cfg"]->Service["mcollective"] -> File["/etc/mcollective/facts.yaml"]
}


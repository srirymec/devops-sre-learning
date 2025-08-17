class printdateandtime{
  file{"/etc/demo.sh":
    mode=> 755,
    owner=> puppet,
    source=> "puppet:///modules/printdateandtime/demo.sh"
   }

   exec { "Print_date_time":
    command => "/etc/demo.sh",
    path    => [ "/usr/local/bin/", "/bin/" ],  # alternative syntax
   }

    File["/etc/demo.sh"] -> Exec["Print_date_time"]
 
}

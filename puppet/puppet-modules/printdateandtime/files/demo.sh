#!/bin/sh
#ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' > demo.txt
#HOST=$(hostname)
#TODAY=$(date)
echo "Hello From :"  $(hostname) > /etc/demo.txt
  
echo "Today is :" $(date) >> /etc/demo.txt




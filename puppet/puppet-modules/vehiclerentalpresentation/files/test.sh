#! /bin/bash
key=$1
value=$2
file=$3
`perl -pi -e 's/"\$key"/"\$value"/g' "\$file"`
exit 0

#!/bin/bash
yum update -y
yum install httpd -y
echo "<h2> Deployed via Terraform wih ELB </h2>" >/var/www/html/index.html
chkconfig httpd on
service httpd start


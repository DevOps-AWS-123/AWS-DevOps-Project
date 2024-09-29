#!/bin/bash

sudo apt update -y
sudo apt install apache2 -y
systemctl start apache2
systemctl enable apache2
EC2ID=$(curl -s http://ipaddress/latest/meta-data/instance_id)
echo "<center><h1>The instance id of ubuntu : EC2ID</h1></center>" > /var/www/html/index.txt
sed "s/EC2ID/$EC2ID/" /var/www/html/index.txt > /var/www/html/index.html
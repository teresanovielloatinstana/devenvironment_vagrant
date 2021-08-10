#!/usr/bin/env bash

sudo dnf install httpd.x86_64 -y
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
sudo dnf install lynx.x86_64 -y

sudo chown --recursive apache.users /var/www
if ! [ -e /var/www/html ]; then
  sudo mkdir /var/www/html
fi
sudo cp -rp /vagrant/html/* /var/www/html
sudo chown --recursive apache.users /var/www

#to check the index is accessible:
#wget -qO- http://localhost/index.html
#or lynx http://localhost/index.html
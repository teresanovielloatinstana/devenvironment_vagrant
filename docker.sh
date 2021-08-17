#!/usr/bin/env bash  
echo "Installing Docker"
dnf -y install dnf-plugins-core
dnf -y install docker-compose.noarch docker-distribution.x86_64
 ## Docker repo
cp /vagrant/repos/docker-ce.repo /etc/yum.repos.d/docker-ce.repo ;
chown root.root /etc/yum.repos.d/docker-ce.repo
dnf makecache ;
dnf -y install docker-ce docker-ce-cli containerd.io emacs-dockerfile-mode.noarch
systemctl enable --now docker 

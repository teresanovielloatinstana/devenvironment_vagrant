#!/usr/bin/env bash  
USER=teresalili
rpm -qa|egrep -i minikube >> /dev/null 2>&1 ;
if [ ! "$?" -eq "0" ]; then
	echo "Installing Minikube" ;
	 cd /home/$USER/ ;
	 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm ;
	 chown $USER.$USER minikube-latest.x86_64.rpm ;
	 rpm -ivh minikube-latest.x86_64.rpm ; cd ;
else
	echo "Not Installing Minikube: already installed :-) " ;
fi

# https://minikube.sigs.k8s.io/docs/drivers/podman/
rpm -qa|egrep -i podman >> /dev/null 2>&1 ;
if [ ! "$?" -eq "0" ]; then
	echo "Installing Podman driver" ; 
	dnf -y install podman ; cd ; 
else
	echo "Not Installing podman: already installed :-) " ;
fi


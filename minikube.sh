#!/usr/bin/env bash  
USER=teresalili

# https://minikube.sigs.k8s.io/docs/start
rpm -qa|egrep -i minikube >> /dev/null 2>&1 ;
if [ ! "$?" -eq "0" ]; then
	echo "Installing Minikube" ;
	 cd /home/$USER/ ;
	 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm ;
	 chown $USER.$USER minikube-latest.x86_64.rpm ;
	 rpm -Uvh minikube-latest.x86_64.rpm ; cd ;
	if [ ! "$?" -eq "0" ]; then
		echo "Installed Minikube" ;
		rm -rf minikube-latest.x86_64.rpm ;
	else
		echo "It was not possible to Install Minikube" ;
	fi
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


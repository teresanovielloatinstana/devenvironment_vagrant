#!/usr/bin/env bash  
USER=teresalili

# https://minikube.sigs.k8s.io/docs/start
rpm -qa|egrep -i minikube >> /dev/null 2>&1 ;
if [ ! "$?" -eq "0" ]; then
	echo "Installing Minikube" ;

	echo "Installing Minikube/Preliminary steps..." ;
	dnf install -y binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms qt5-qtx11extras SDL
	kernel_version=$(uname -r);
	dnf -y install "kernel-devel-"${kernel_version}
	#installing docker driver for minikube
	dnf -Y install @virtualization
	systemctl start libvirtd

	 cd /home/$USER/ ;
	 curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm ;
	 chown $USER.$USER minikube-latest.x86_64.rpm ;
	 rpm -Uvh minikube-latest.x86_64.rpm ; 
	if [ ! "$?" -eq "0" ]; then
		echo "Installed Minikube: start it with \"minikube start --driver=docker\"" ;
		rm -rf minikube-latest.x86_64.rpm ;

		echo "Installing Kubectl" ;
		curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/Kubectl"
		chown $USER.$USER Kubectl ;
		install -o root -g root -m 0755 Kubectl /usr/local/bin/Kubectl
		if [ ! "$?" -eq "0" ]; then
			echo "Installed Kubectl"
			rm -rf Kubectl ;
		else
			echo "It was not possible to Install Kubectl" ;
		fi

		echo "Installing HELM" ;
		curl -LO "https://get.helm.sh/helm-v3.6.3-linux-amd64.tar.gz"
		chown $USER.$USER helm*;
		tar xvzf helm-v3.6.3-linux-amd64.tar.gz >> /dev/null 2>&1 ;
		if [ ! "$?" -eq "0" ]; then
			rm -rf helm-v3.6.3-linux-amd64.tar.gz;
			chown --recursive $USER.$USER linux-amd64/  ;
			cd linux-amd64 ;
			install -o root -g root -m 0755 helm /usr/local/bin/helm
			if [ ! "$?" -eq "0" ]; then
				echo "Installed HELM" ;
			else
				echo "It was not possible to Install HELM " ;
			fi
		else
			echo "It was not possible to Install HELM - the tar was corrupted?" ;
		fi

		cd ;
	else
		echo "It was not possible to Install Minikube" ;
	fi
else
	echo "Not Installing Minikube: already installed :-) " ;
fi

# Uncomment if you do need podman
# https://minikube.sigs.k8s.io/docs/drivers/podman/
#rpm -qa|egrep -i podman >> /dev/null 2>&1 ;
#if [ ! "$?" -eq "0" ]; then
#	echo "Installing Podman driver" ; 
#	dnf -y install podman ; cd ; 
#else
#	echo "Not Installing podman: already installed :-) " ;
#fi


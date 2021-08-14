#!/usr/bin/env bash  
echo "Java Script, run by: "$(whoami)

# Maven
echo "Installing MAVEN"; 
dnf -y install maven.noarch ;

# JAVA
echo "Installing JAVA"; 
dnf -y install java-1.8.0-openjdk.x86_64 ;

# ANT
ANT_PATH=/home/teresalili/apache-ant

if [ ! -d "$ANT_PATH" ]; then

	echo "Installing ANT";
	cd /home/teresalili ; 
	curl -L -o apache-ant-1.10.11-bin.zip https://downloads.apache.org//ant/binaries/apache-ant-1.10.11-bin.zip ;
	unzip apache-ant-1.10.11-bin.zip >> /dev/null 2>&1 ; 
	
	if [ "$?" -eq "0" ]; then 
		rm -rf apache-ant-1.10.11-bin.zip ;
		mv apache-ant-1.10.11 apache-ant ;
		ln -fs apache-ant apache-ant-1.10.11 ;
		chown --recursive teresalili.teresalili apache-ant apache-ant-1.10.11 ;
	else
		echo "Apache ANT was not correctly installed: please, rerun the script with debug enabled and check the logs"
	fi; 

else
	echo "NOT Installing ANT: ANT is already installed :-) ";
fi

cd ;

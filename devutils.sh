#!/usr/bin/env bash  
USER=teresalili
BFG_PATH=/home/$USER/Software/bfg-1.14.0.jar
if [ ! -f "$BFG_PATH" ]; then
	echo "Installing BFG Repo-Cleaner for user $USER";
	cd  /home/$USER/ ; 
	mkdir -p Software ; 
	chown $USER.$USER Software ; cd Software ;
	curl -LO https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar ;
	chown $USER.$USER bfg-1.14.0.jar ;
	cd ;
else
	echo "Not Installing BFG Repo-Cleaner for user $USER: it already exists :-)";
fi

# FLY
# https://fly.io/docs/hands-on/installing/
# su - $USER -c "curl -L https://fly.io/install.sh | sh" ; 
echo Installing FLY;
cd  /home/$USER/ ;
mkdir ~/.newfly ;
# https://concourse-ci.org/quick-start.html
su - $USER -c "curl 'http://localhost:8080/api/v1/cli?arch=amd64&platform=linux' -o ~/.newfly/fly" ;
chmod +x ~/.newfly/fly
cp ~/.newfly/fly /usr/local/bin/
cd ;

# Concourse
mkdir -p /home/$USER/bin/concourse ; cd /home/$USER/bin/concourse
curl -O https://concourse-ci.org/docker-compose.yml
chown --recursive $USER.$USER /home/$USER/bin
cd ;

# GOlang
echo Installing GOlang;
dnf -y install golang.x86_64 ;

# telnet
echo Installing telnet;
dnf install -y telnet.x86_64 ;

# cron
echo Installing cron;
dnf install -y cronie.x86_64

# Since this script is executed with priviled permissions, re-establish all the USER permissions
chown --recursive $USER.$USER /home/$USER/

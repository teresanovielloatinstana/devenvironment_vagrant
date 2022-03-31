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
mkdir -p .newfly ;
# https://concourse-ci.org/quick-start.html
# su - $USER -c "curl 'http://localhost:8080/api/v1/cli?arch=amd64&platform=linux' -o ~/.newfly/fly" ;
cp host_backups/software/fly-7.4.0-linux-amd64.tgz ~/.newfly
cd .newfly;
tar xvzf fly-7.4.0-linux-amd64.tgz
chmod +x ~/.newfly/fly
cp ~/.newfly/fly /usr/local/bin/
chown --recursive $USER.$USER /home/$USER/.newfly
cd ;

# Concourse
mkdir -p /home/$USER/bin/concourse ; cd /home/$USER/bin/concourse
curl -O https://concourse-ci.org/docker-compose.yml
chown --recursive $USER.$USER /home/$USER/bin
cd ;

# YTT
cd /home/$USER/bin ;
wget https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.39.0/ytt-linux-amd64
chmod +x ./ytt-linux-amd64
ln -fs ytt-linux-amd64 ytt
chown --recursive $USER.$USER /home/$USER/bin
cd ;

# GOlang
echo Installing GOlang;
dnf -y install golang.x86_64 ;

# telnet
echo Installing telnet;
dnf install -y telnet.x86_64 ;

# cron
echo Installing cron ;
dnf install -y cronie.x86_64;

# meld
echo "Installing meld";
dnf -y install meld.noarch ;

# Install atom
#cd ;
#mkdir -p /home/$USER/atom ;
#cd /home/$USER/atom ;
#wget https://atom.io/download/rpm ;

# indent
echo "Installing indent";
dnf install -y indent.x86_64;

# gitK
echo "Installing gitk";
sudo dnf -y install gitk.noarch;

# Since this script is executed with priviled permissions, re-establish all the USER permissions
chown --recursive $USER.$USER /home/$USER/

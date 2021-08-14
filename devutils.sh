#!/usr/bin/env bash  
USER=teresalili
BFG_PATH=/home/$USER/Software/bfg-1.14.0.jar
if [ ! -f "$PHP_COMPOSER_PATH" ]; then
	echo "Installing BFG Repo-Cleaner for user $USER";
	cd  /home/$USER/ ; 
	mkdir -p Software ; 
	chown teresalili.teresalili Software ; cd Software ;
	curl -LO https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar ;
	chown teresalili.teresalili bfg-1.14.0.jar ;
	cd ;
else
	echo "Not Installing BFG Repo-Cleaner for user $USER: it already exists :-)";
fi

# FLY
# https://fly.io/docs/hands-on/installing/
echo Installing FLY;
cd  /home/$USER/ ;
su - $USER -c "curl -L https://fly.io/install.sh | sh" ; 
cd ;


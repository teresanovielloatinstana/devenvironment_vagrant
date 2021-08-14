#!/usr/bin/env bash
# URL: https://brew.sh/

echo "Brew Script, run by: "$(whoami)

BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
sudo ls "$BREW_PATH" >> /dev/null 2>&1

if [ ! "$?" -eq "0" ]; then

	echo "Installing Brew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 
	if [ ! -f "$BREW_PATH" ]; then
		echo "There was a problem installing brew, please re-run with debug and check the logs"
	else
		echo "Brew Script, changing user for brew "
		sudo chown --recursive teresalili.teresalili /home/linuxbrew/.linuxbrew/
		echo "Brew Script, changed user for brew "
		echo "Installing Gomplate" ;
        	sudo su - teresalili -c "/home/linuxbrew/.linuxbrew/bin/brew install gomplate" ; 
	fi
	
else

	echo "Brew is already installed, not provisioning Brew."
fi

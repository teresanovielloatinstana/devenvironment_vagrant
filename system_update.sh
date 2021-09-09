#!/usr/bin/env bash  

# update the system, install virtualbox-guest-additions
dnf -y upgrade
dnf -y install xfsprogs-devel.x86_64
dnf install -y virtualbox-guest-additions.x86_64

# Set the hostname
HOSTNAME="blackmamba"
hostname $HOSTNAME

# Permit anyone to start the GUI
if [ -f /etc/X11/Xwrapper.config ]; then 
	sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config; 
else 
	cp /vagrant/Xwrapper.config /etc/X11/Xwrapper.config; 
fi; 

chown root.root /etc/X11/Xwrapper.config

# Add user
USER="teresalili"
id -u "$USER" >> /dev/null 2>&1
if [ ! $? -eq "0" ]; then
	echo "Adding user: " $USER
	adduser "$USER"
else
	echo "Not Adding user "$USER": it already exists :-)"
fi

# Development tools
# Groups
dnf -y groupinstall "Development Tools" "Development Libraries" ;
# Kernel
dnf -y install kernel-modules-extra.x86_64 ;
# Compilers
dnf -y install gcc-c++.x86_64 gcc-gdb-plugin.x86_64 cmake-filesystem.x86_64 ;
# VIM
dnf -y install vim-command-t.x86_64 vim-common.x86_64 vim-enhanced.x86_64 vim-filesystem.noarch

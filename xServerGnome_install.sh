#!/usr/bin/env bash
# Refernce: https://stackoverflow.com/questions/18878117/using-vagrant-to-run-virtual-machines-with-desktop-environment

sudo cp /vagrant/Xwrapper.config /etc/X11/Xwrapper.config
sudo chown root.root /etc/X11/Xwrapper.config

sudo dnf install virtualbox-guest-additions-6.1.18-2.fc34.x86_64 -y

sudo dnf -y group install "Basic Desktop"
sudo dnf install xrdb.x86_64
sudo dnf install xmodmap.x86_64

sudo VBoxClient-all
#sudo systemctl start gdm.service
#sudo systemctl enable gdm.service


sudo dnf groupinstall -y "Xfce Desktop"
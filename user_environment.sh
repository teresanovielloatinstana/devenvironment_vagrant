#!/usr/bin/env bash  
USER=teresalili
echo "Add user to docker,wheel group";
 usermod -a -G docker,wheel teresalili
# Add user's own aliases and environment variables
echo "Modify User Environment";
cp -r /vagrant/.bashrc.d/ /home/teresalili/;  
chmod --recursive 775 /home/teresalili/.bashrc.d/;
chown --recursive teresalili.teresalili /home/teresalili/.bashrc.d/;

cp /vagrant/.bashrc /home/teresalili/.bashrc ;  
cd /home/teresalili;  
dos2unix /home/teresalili/.bashrc ;  
chown teresalili.teresalili /home/teresalili/.bashrc ; 
cd;
mkdir -p /home/teresalili/DEV ;  
mkdir -p /home/teresalili/DEV/git ;
cd /home/teresalili/DEV ; 
ln -fs /learning learning ; 
cd ;
chown --recursive teresalili.teresalili /home/teresalili/DEV ; cd ;
mkdir -p /home/teresalili/AGENT_INSTALL ;  chown --recursive teresalili.teresalili /home/teresalili/AGENT_INSTALL ; cd ;
cp -r /vagrant/.config /home/teresalili/ ;  chown --recursive teresalili.teresalili /home/teresalili/.config ; cd ;

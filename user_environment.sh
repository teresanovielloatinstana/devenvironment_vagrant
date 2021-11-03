#!/usr/bin/env bash  
USER=teresalili
echo "Add user to docker,wheel group";
usermod -a -G docker,wheel $USER
# Add user's own aliases and environment variables
echo "Modify User Environment";
mv /home/$USER/.bashrc.d /home/$USER/bashrc.d.bkp
cp -r /vagrant/.bashrc.d/ /home/$USER/;  
cd /home/$USER/.bashrc.d/;
dos2unix ./env;
dos2unix ./alias;
cd /home/$USER;
chmod --recursive 775 /home/$USER/.bashrc.d/;
chown --recursive $USER.$USER /home/$USER/.bashrc.d/;

cp /vagrant/.bashrc /home/$USER/.bashrc ;  
cd /home/$USER;  
dos2unix /home/$USER/.bashrc ;  
chown $USER.$USER /home/$USER/.bashrc ; 

cd;
cp /vagrant/.vimrc /home/$USER/ ; chown --recursive $USER.$USER /home/$USER/.vimrc ;

cd;
mkdir -p /home/$USER/DEV ;  
mkdir -p /home/$USER/DEV/git ;
cd /home/$USER/DEV ; 
ln -fs /learning learning ; 
cd ;
chown --recursive $USER.$USER /home/$USER/DEV ; cd ;
mkdir -p /home/$USER/instana_scriptsL ;  chown --recursive $USER.$USER /home/$USER/instana_scriptsL ; cd ;
mv /home/$USER/.config /home/$USER/config.bkp ;
cp -r /vagrant/.config /home/$USER/ ;  chown --recursive $USER.$USER /home/$USER/.config ; cd ;

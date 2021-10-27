# fedora_devenvironment_vagrant
The repository contains vagrant files for development environments

Creation of the VM


To ssh to the virtual machine 
After 'vagrant up' command, run:  
vagrant ssh
or
ssh vagrant@192.168.0.191
'vagrant' user password: vagrant
Note: be careful about rm -rf /, since Vagrant shares a directory at /vagrant with the directory on the host containing your Vagrantfile, and this can delete all those files.

First steps after the first machine boot: (USER=<your username>)
1. vagrant ssh
2. sudo passwd $USER
3. login as $USER
4. [only for the very first time] Resize the root partition /dev/sda1, follow the tutorial https://linuxhint.com/gnome_disk_utility/
5. [optional] To add and format a partition into /dev/sda, follow the tutorial https://linuxhint.com/gnome_disk_utility/
6. [setting root password] exit; sudo passwd root
7. su - root
8. export VISUAL="vi";export EDITOR="$VISUAL";cp /etc/sudoers /root/sudoers.bak;visudo
9. As root, run 'visudo'
Add the following line(s) at the ent of /etc/sudoers:
$USER ALL = NOPASSWD: /usr/bin/systemctl, /usr/bin/kill
$USER ALL=(ALL) NOPASSWD: ALL
10. save and close the file
11. As root, write in /etc/hostname the $HOSTNAME string, or the hostname will be lost at startup
12. [optional] Install the latest VirtualBox Guest Additions: [Ref: https://stackoverflow.com/questions/43492322/vagrant-was-unable-to-mount-virtualbox-shared-folders]
  12.1 cd /c/Program Files/Oracle/VirtualBox;
  12.2 scp -rp VBoxGuestAdditions.iso $USER@$HOST_IP:./
  12.3 ssh $USER@$HOST_IP
  12.4 sudo mkdir /media/iso
  12.5 sudo mount -o loop /home/teresalili/VBoxGuestAdditions.iso /media/iso
  12.6 sudo sh /media/iso/VBoxLinuxAdditions.run
13. Setting up ssh-agent
As $USER: 
  13.1 eval $(ssh-agent)
  13.2  mkdir $HOME/.ssh ; sudo chmod 700 $HOME/.ssh
  13.3 On guest host: 1. tar xvzf info_for_external_vm.tar.gz 2.scp info_for_external_vm/sshbkp/*id_ed25519* $USER@$HOST_IP:./.ssh
  13.4 sudo chmod 600 .ssh/id_ed25519
  13.5 add keys with the command ssh-add ~/.ssh/id_ed25519
14. Network
14.1 Obtain new host ip
ifconfig|egrep 192
export BLACKMAMBA_IP=192.168.0.78
14.2 
eth1->settings->IPv4
changed IPv4 method from 'Automatic (DHCP)' to 'Manual'
set static ip with correct netmask and gateway
reload eth1 settings (switch off/switch on the eth1)
15. Recover environment [To do before the installation of GCloud SDK at step 16].
login as $USER
cp -rp /vagrant/host_backups/HOME/USER/.bashrc .
cp -rp /vagrant/host_backups/HOME/USER/.bashrc.d/ . 
16. Install gcloud SDK and configure it
visit https://cloud.google.com/sdk/docs/install
cd Downloads
tar xvzf google-cloud-sdk-361.0.0-linux-x86_64.tar.gz
mv google-cloud-sdk ~/
rm -rf google-cloud-sdk-361.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh

After the first installaiton of gcloud sdk, you need to do gcloud init.
gcloud init
if it is too slow, you can do:
gcloud init --skip-diagnostics
Set a project, here.
You can change this configuration afterwards.
If you are already logged-in, you can use the convenient
gcloud config set project <new_project>

gcloud auth login
gcloud auth configure-docker

17. [optional] To change the runlevel to multiuser:
sudo systemctl set-default multi-user.target
18. [optional] Configure git
git config --global user.email "XXX@YYY.ZZZ"
git config --global user.name "Abc Dfg"
git config --global core.autocrlf input

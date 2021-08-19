# devenvironment_vagrant
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

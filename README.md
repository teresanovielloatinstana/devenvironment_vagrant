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

First steps after the first machine boot
1. vagrant ssh
2. sudo passwd $USER
3. login as $USER
4. [optional] To add and format a partition into /dev/sda, follow the tutorial https://linuxhint.com/gnome_disk_utility/

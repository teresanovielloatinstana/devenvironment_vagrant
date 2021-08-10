# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "mansat123/Fedora-Desktop"
  config.vm.box_version = "34.1.2"
  
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = true
  
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"
  # Port forwarding setup
  # Forwarding vm port 80 to local host port 4567
  config.vm.network :forwarded_port, guest: 80, host: 4567

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "../Blackmamba", "/BlackmambaMS"
  config.vm.synced_folder ".", "/vagrant", disabled: false
  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  vb.memory = "16384"
  #   # Customize the number of cpus in the vm: this should be half of the available CPUs in the local host
  vb.cpus = 2
  #   # Customize the graphic ram and graphics controller:
  vb.customize ["modifyvm", :id, "--vram", "128"]
  vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
  #   # Customize vm name
  vb.name = "blackmamba"
  end
  
  # Updates, virtualbox additions
  config.vm.provision "shell", inline: "sudo dnf -y upgrade"
  config.vm.provision "shell", inline: "sudo dnf install -y virtualbox-guest-additions.x86_64"
  # Set the hostname
  config.vm.provision "shell", inline: "sudo hostname blackmamba"
  # Permit anyone to start the GUI
  config.vm.provision "shell", inline: "if [ -f /etc/X11/Xwrapper.config ]; then sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config; else sudo cp /vagrant/Xwrapper.config /etc/X11/Xwrapper.config; fi; sudo chown root.root /etc/X11/Xwrapper.config"
  # Add user
  config.vm.provision "shell", inline: "sudo adduser teresalili"
  # Development tools
  # Groups
  config.vm.provision "shell", inline: "sudo dnf -y groupinstall \"Development Tools\" \"Development Libraries\" "
  # kernel
  config.vm.provision "shell", inline: "sudo dnf -y install kernel-modules-extra.x86_64"
  # compilers
  config.vm.provision "shell", inline: "sudo dnf -y install gcc-c++.x86_64 gcc-gdb-plugin.x86_64 cmake-filesystem.x86_64"
  # Docker
  config.vm.provision "shell", inline: "sudo dnf -y install dnf-plugins-core"
  config.vm.provision "shell", inline: "sudo dnf -y install docker-compose.noarch docker-distribution.x86_64"
  config.vm.provision "shell", inline: "cp /vagrant/docker-ce.repo /etc/yum.repos.d/docker-ce.repo ; sudo chown root.root /etc/yum.repos.d/docker-ce.repo"
  config.vm.provision "shell", inline: "sudo dnf makecache ; sudo dnf -y install docker-ce docker-ce-cli containerd.io emacs-dockerfile-mode.noarch"
  config.vm.provision "shell", inline: "sudo systemctl enable --now docker" 
  # Maven
  config.vm.provision "shell", inline: "sudo dnf -y install maven.noarch"    
  # Gcloud
  config.vm.provision "shell", inline: "sudo cp -r /vagrant/google-cloud-sdk/ /home/teresalili/; sudo chmod +x /home/teresalili/google-cloud-sdk/install.sh ; sudo chown --recursive teresalili.teresalili /home/teresalili/google-cloud-sdk"
  # Java
  config.vm.provision "shell", inline: "sudo dnf -y install java-1.8.0-openjdk.x86_64"
  # Ant
  config.vm.provision "shell", inline: "cd /home/teresalili ; curl -L -o apache-ant-1.10.11-bin.zip https://downloads.apache.org//ant/binaries/apache-ant-1.10.11-bin.zip ; unzip apache-ant-1.10.11-bin.zip >> /dev/null 2>&1 ; if [ \"$?\" -eq \"0\" ]; then sudo rm -rf apache-ant-1.10.11-bin.zip ; sudo chown --recursive teresalili.teresalili apache-ant-1.10.11 ; fi; cd ; "
  # PHP
  # https://computingforgeeks.com/how-to-install-php-74-on-fedora/
  # config.vm.provision "shell", inline: "sudo dnf -y install https://rpms.remirepo.net/fedora/remi-release-34.rpm ; sudo dnf -y config-manager --set-enabled remi ; sudo dnf -y module reset php ; dnf -y search"
  # config.vm.provision "shell", inline: "cd /home/teresalili ; curl -L -o https://fedora.pkgs.org/34/fedora-x86_64/php-7.4.16-1.fc34.x86_64.rpm.html
  # https://www.zend.com/setting-up-your-php-build-environment
  config.vm.provision "shell", inline: "sudo dnf -y install gcc gcc-c++ binutils glibc-devel autoconf automake bison flex re2c gdb libtool make pkgconf valgrind git libxml2-devel libsqlite3x-devel"
  config.vm.provision "shell", inline: "cd /home/teresalili ; git clone https://github.com/php/php-src.git ; sudo chown --recursive teresalili.teresalili php-src ; " 
  # HTTPD2
  config.vm.provision :shell, path: "apache_bootstrap.sh"
  
  # Refine user's environment
  # Add user to docker group
  config.vm.provision "shell", inline: "sudo usermod -a -G docker,wheel teresalili"
  # Add user's own aliases and environment variables
  config.vm.provision "shell", inline: "sudo cp -r /vagrant/.bashrc.d/ /home/teresalili/.bashrc.d/ ; sudo chmod --recursive 775 /home/teresalili/.bashrc.d/; sudo chown --recursive teresalili.teresalili /home/teresalili/.bashrc.d/"
  config.vm.provision "shell", inline: "sudo sed -i 's/export ANT_HOME=.*$/export ANT_HOME=/' /home/teresalili/.bashrc.d/env ; sudo chown --recursive teresalili.teresalili /home/teresalili/.bashrc.d/ ;"
  config.vm.provision "shell", inline: "sudo cat /vagrant/.bashrc >> /home/teresalili/.bashrc ; sudo chown teresalili.teresalili /home/teresalili/.bashrc "
  config.vm.provision "shell", inline: "sudo mkdir /home/teresalili/DEV ; sudo mkdir /home/teresalili/DEV/git ; sudo mkdir /home/teresalili/DEV/learning "
  
end
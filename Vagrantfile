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
  # Kernel
  config.vm.provision "shell", inline: "sudo dnf -y install kernel-modules-extra.x86_64"
  # Compilers
  config.vm.provision "shell", inline: "sudo dnf -y install gcc-c++.x86_64 gcc-gdb-plugin.x86_64 cmake-filesystem.x86_64"
  # Docker
  config.vm.provision "shell", inline: "sudo dnf -y install dnf-plugins-core"
  config.vm.provision "shell", inline: "sudo dnf -y install docker-compose.noarch docker-distribution.x86_64"
  ## Docker repo
  config.vm.provision "shell", inline: "cp /vagrant/repos/docker-ce.repo /etc/yum.repos.d/docker-ce.repo ; sudo chown root.root /etc/yum.repos.d/docker-ce.repo"
  config.vm.provision "shell", inline: "sudo dnf makecache ; sudo dnf -y install docker-ce docker-ce-cli containerd.io emacs-dockerfile-mode.noarch"
  config.vm.provision "shell", inline: "sudo systemctl enable --now docker" 
  # Maven
  config.vm.provision "shell", inline: "sudo dnf -y install maven.noarch"    
  # Gcloud
  config.vm.provision "shell", inline: "cd /home/teresalili/ ; sudo mkdir google-cloud-sdk ; sudo chown --recursive teresalili.teresalili google-cloud-sdk ; cd google-cloud-sdk ; /
					curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-352.0.0-linux-x86_64.tar.gz /
					tar xvzf google-cloud-sdk-352.0.0-linux-x86_64.tar.gz /
					rm -rf google-cloud-sdk-352.0.0-linux-x86_64.tar.gz /
					cd /home/teresalili/ ; sudo chown --recursive teresalili.teresalili google-cloud-sdk ; /
					cd ; "
  # JAVA
  config.vm.provision "shell", inline: "echo \"Installing JAVA\"; sudo dnf -y install java-1.8.0-openjdk.x86_64"
  # ANT
  config.vm.provision "shell", inline: "echo \"Installing ANT\"; /
										cd /home/teresalili ; curl -L -o apache-ant-1.10.11-bin.zip https://downloads.apache.org//ant/binaries/apache-ant-1.10.11-bin.zip ; /
										unzip apache-ant-1.10.11-bin.zip >> /dev/null 2>&1 ; if [ \"$?\" -eq \"0\" ]; then /
                                        sudo rm -rf apache-ant-1.10.11-bin.zip ; /									
										sudo apache-ant-1.10.11 apache-ant ; sudo mv apache-ant-1.10.11 apache-ant ; sudo ln -fs apache-ant apache-ant-1.10.11 ; /
										sudo chown --recursive teresalili.teresalili apache-ant apache-ant-1.10.11 ; /
										fi; cd ; "
  # PHP
  ## PHP remi repo
  ## https://computingforgeeks.com/how-to-install-php-74-on-fedora/
  config.vm.provision "shell", inline: "echo \"Installing PHP\"; "
  config.vm.provision "shell", inline: "echo \"Installing PHP REMI Repo\"; "
  config.vm.provision "shell", inline: "sudo dnf -y install https://rpms.remirepo.net/fedora/remi-release-34.rpm ; sudo dnf -y config-manager --set-enabled remi ; sudo dnf -y module reset php ;"
  config.vm.provision "shell", inline: "sudo dnf -y install php-json.x86_64 php-cli.x86_64 php-mbstring.x86_64 php-devel.x86_64 php.x86_64 php-opcache.x86_64 php-pdo.x86_64 php-sodium.x86_64 php-xml.x86_64 php-fpm.x86_64"
  ## PHP zend repo
  config.vm.provision "shell", inline: "echo \"Installing PHP Zend Repo\"; "
  config.vm.provision "shell", inline: "sudo cp /vagrant/repos/zend.repo /etc/yum.repos.d/zend.repo ; sudo chown root.root /etc/yum.repos.d/zend.repo; sudo dnf makecache; "
  config.vm.provision "shell", inline: "sudo dnf -y install php-5.3-bin-zend-server.x86_64 php-5.3-dev-zend-server.x86_64 ;"
  ## Cloning PHP src
  ## https://www.zend.com/setting-up-your-php-build-environment
  config.vm.provision "shell", inline: "echo \"Installing Cloning php-src\"; "
  config.vm.provision "shell", inline: "cd /home/teresalili/ ; git clone https://github.com/php/php-src.git ; sudo chown --recursive teresalili.teresalili php-src ; cd "
  ## PHP-Composer
  config.vm.provision "shell", inline: "echo \"Installing PHP-composer\"; "
  config.vm.provision "shell", inline: "cd /home/teresalili/ ; sudo mkdir php-composer ; cd php-composer ; sudo php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\"; /
										cd /home/teresalili/ ; sudo chown --recursive teresalili.teresalili php-composer ; cd php-composer ; /
										sudo php -r \"if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;\" /
										sudo php composer-setup.php --install-dir=/usr/local/bin /
										cd /usr/local/bin/ ; sudo ln -fs composer.phar composer /
										cd /home/teresalili/ ; sudo chown --recursive teresalili.teresalili php-composer ; /
										cd ; "
  # SYMFONY
  # https://symfony.com/download
  config.vm.provision "shell", inline: "echo \"Installing Symfony\"; "
  config.vm.provision "shell", inline: "sudo su - teresalili -c \"wget https://get.symfony.com/cli/installer -O - | bash \" " 
  
  # FLY
  # https://fly.io/docs/hands-on/installing/
  config.vm.provision "shell", inline: "echo \"Installing FLY\"; "
  config.vm.provision "shell", inline: "cd  /home/teresalili/ ; \
					sudo curl -L https://fly.io/install.sh | sh ; cd ;"
  
  # HTTPD2
  config.vm.provision :shell, path: "apache_bootstrap.sh"
  
  # Minikube
  config.vm.provision "shell", inline: "echo \"Installing Minikube\"; "
  config.vm.provision "shell", inline: "cd  /home/teresalili/ ; \
					sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm ; \
					sudo chown teresalili.teresalili minikube-latest.x86_64.rpm ; \
					sudo rpm -ivh minikube-latest.x86_64.rpm ; cd ; "
  # https://minikube.sigs.k8s.io/docs/drivers/podman/
  config.vm.provision "shell", inline: "echo \"Installing Podman driver\"; "
  config.vm.provision "shell", inline: "sudo dnf -y install podman ; cd ; "
  
  # BREW
  # https://brew.sh/
  config.vm.provision "shell", inline: "echo \"Installing BREW\"; "
  config.vm.provision "shell", inline: "sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh ; /
										sudo chown --recursive teresalili.teresalili /home/linuxbrew/.linuxbrew ; /
										cd ;"
  
  # GOMPLATE
  # https://docs.gomplate.ca/installing/
  config.vm.provision "shell", inline: "echo \"Installing Gomplate\"; "
  config.vm.provision "shell", inline: "sudo su - teresalili -c \"/home/linuxbrew/.linuxbrew/bin/brew install gomplate\" ; "

  # BFG Repo-Cleaner
  #
  config.vm.provision "shell", inline: "echo \"Installing BFG Repo-Cleaner\"; "
  config.vm.provision "shell", inline: "cd  /home/teresalili/ ; \ mkdir Software ; sudo chown teresalili.teresalili Software ; cd Software ; \
					curl -LO https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar ; \
					sudo chown teresalili.teresalili bfg-1.14.0.jar ; \
					cd ; "
  
  # Refine user's environment
  # Add user to docker,wheel group
  config.vm.provision "shell", inline: "echo \"Add user to docker,wheel group\"; "
  config.vm.provision "shell", inline: "sudo usermod -a -G docker,wheel teresalili"
  # Add user's own aliases and environment variables
  config.vm.provision "shell", inline: "echo \"User Environment\"; "
  config.vm.provision "shell", inline: "sudo cp -r /vagrant/.bashrc.d/ /home/teresalili/.bashrc.d/ ; sudo chmod --recursive 775 /home/teresalili/.bashrc.d/; sudo chown --recursive teresalili.teresalili /home/teresalili/.bashrc.d/"
  config.vm.provision "shell", inline: "sudo cat /vagrant/.bashrc >> /home/teresalili/.bashrc ; sudo cd /home/teresalili; sudo dos2unix /home/teresalili/.bashrc ; sudo chown teresalili.teresalili /home/teresalili/.bashrc ; cd "
  config.vm.provision "shell", inline: "sudo mkdir /home/teresalili/DEV ; sudo mkdir /home/teresalili/DEV/git ; sudo mkdir /home/teresalili/DEV/learning ; sudo chown --recursive teresalili.teresalili /home/teresalili/DEV ; cd ;"
  config.vm.provision "shell", inline: "sudo mkdir /home/teresalili/AGENT_INSTALL ; sudo chown --recursive teresalili.teresalili /home/teresalili/AGENT_INSTALL ; cd ; "
  config.vm.provision "shell", inline: "sudo cp /vagrant/.config /home/teresalili/.config ; sudo chown --recursive teresalili.teresalili /home/teresalili/.config ; cd ;"

  # INSTANA AGENT
  ## dependency on chkconfig
  config.vm.provision "shell", inline: "sudo dnf install chkconfig -y "
  
end

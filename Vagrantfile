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
  
  # Initial size of the primary disk
  config.vm.disk :disk, size: "128GB", primary: true
  # URL: https://stackoverflow.com/questions/49822594/vagrant-how-to-specify-the-disk-size
  # vagrant plugin install vagrant-disksize
  config.disksize.size = '128GB'
  
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # The following is setting a NAT as first interface, it can be changed only in VirtualBox, say, if you absolutely do not want eth0 to be NAT
  # config.vm.network "public_network", ip: "192.168.1.191"
  # config.vm.network "public_network", ip: "192.168.0.191"
  # It is better to not have an explicit IP, so you can chane network often and without any problem
  # Important: follow README to set static IP in the vm once it is running: it will prevent proxy-behaviour and gcloud slow connection
  config.vm.network "public_network"
  # The following is evil, do not use it
  # config.vm.network "private_network", ip: "192.168.50.4"
  # Port forwarding setup
  # Forwarding vm port 80 to local host port 4567
  config.vm.network :forwarded_port, guest: 80, host: 4567

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", disabled: false
  config.vm.boot_timeout = 1800
  # Link a shared folder only if it does exist on host 
  # URL: https://stackoverflow.com/questions/27901324/can-i-configure-vagrant-to-setup-a-synced-folder-only-if-it-exists-on-the-host/27915406
  if File.directory?(File.expand_path("../blackmamba_personalnotes_new"))
    config.vm.synced_folder "../blackmamba_personalnotes_new", "/learning"
  end
  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  # Make sure that your VM has the Cable Connected setting checked.
  vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  #   # Display the VirtualBox GUI when booting the machine
  vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  vb.memory = "16384"
  #   # Customize the number of cpus in the vm: this should be half of the available CPUs in the local host
  vb.cpus = 4
  #   # Customize the graphic ram and graphics controller:
  vb.customize ["modifyvm", :id, "--vram", "128"]
  vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
  vb.customize ["setextradata", :id, "VBoxInternal/CPUM/IsaExts/AVX2", "1"]
  # Ref: https://github.com/hashicorp/vagrant/issues/11777
  # Ref2: also mentioned into https://github.com/hashicorp/vagrant/issues/11890
  vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
  vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
  #   # Create, only if it doesn't exist, a second disk. Attach the second storage
  #   # URL: https://gist.github.com/leifg/4713995 
  #   Later on, to partition and format the second disk, follow the tutorial https://linuxhint.com/gnome_disk_utility/
  VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))
#  file_to_disk = File.join(VAGRANT_ROOT, 'secondDisk.vdi')
#  
#  unless File.exist?(file_to_disk)
#    vb.customize ['createhd', '--filename', file_to_disk, '--size', 50 * 1024]
#  end
#  vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
#  
  #   # Customize vm name
  vb.name = "blackmamba"
  end
  
  ##### PROVISION: START #####
  # Updates, virtualbox additions
  config.vm.provision :shell, path: "system_update.sh", privileged: true

  # Docker
  config.vm.provision :shell, path: "docker.sh", privileged: true
  
  # BREW
  # URL: https://brew.sh/
  # URL: https://stackoverflow.com/questions/35176614/vagrant-provision-shell-auto-install-linuxbrew-with-command
  config.vm.provision :shell, path: "brew.sh", privileged: false
  
  # MAVEN, JAVA, ANT
  config.vm.provision :shell, path: "java_environment.sh", privileged: true
  					
  # PHP Environment
  config.vm.provision :shell, path: "php_environment.sh", privileged: true
  
  # HTTPD2
  config.vm.provision :shell, path: "apache_bootstrap.sh"
  
  # Minikube
  config.vm.provision :shell, path: "minikube.sh", privileged: true
  
  # DevUtils: BFG Repo-Cleaner, fly, Concourse, GOlang, telnet, cron
  config.vm.provision :shell, path: "devutils.sh", privileged: true
  
  # Refine user's environment
  # Add user to docker,wheel group
  config.vm.provision :shell, path: "user_environment.sh", privileged: true

  # INSTANA AGENT
  ## dependency on chkconfig
  config.vm.provision "shell", inline: "sudo dnf install chkconfig -y "
  
end

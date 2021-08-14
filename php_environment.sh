#!/usr/bin/env bash  
USER=teresalili
# PHP

## PHP remi repo
## https://computingforgeeks.com/how-to-install-php-74-on-fedora/
echo "Installing PHP";
echo "Installing PHP REMI Repo";
dnf -y module reset php ;
dnf -y install php-json.x86_64 php-cli.x86_64 php-mbstring.x86_64 php-devel.x86_64 php.x86_64 php-opcache.x86_64 php-pdo.x86_64 php-sodium.x86_64 php-xml.x86_64 php-fpm.x86_64

## PHP zend repo
echo "Installing PHP Zend Repo";
cp /vagrant/repos/zend.repo /etc/yum.repos.d/zend.repo ; 
chown root.root /etc/yum.repos.d/zend.repo; dnf makecache;
dnf -y install php-5.3-bin-zend-server.x86_64 php-5.3-dev-zend-server.x86_64 ;

## Cloning PHP src
## https://www.zend.com/setting-up-your-php-build-environment
PHP_SRC_PATH="/home/$USER/php-src/"
if [ ! -d "$PHP_SRC_PATH" ]; then
  echo "Cloning php-src for user $USER";
  cd /home/$USER/ ; 
  git clone https://github.com/php/php-src.git ; 
  chown --recursive $USER.$USER php-src ; 
  cd ;
else
	echo "Not Cloning php-src for user $USER: it already exists :-)";
fi

## PHP-Composer
PHP_COMPOSER_PATH=/usr/local/bin/composer.phar
if [ ! -f "$PHP_COMPOSER_PATH" ]; then
	echo "Installing PHP-composer for user $USER";
	cd /home/$USER/ ; 
	mkdir -p php-composer ; 
	cd php-composer ; 
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; 
	cd /home/$USER/ ; chown --recursive $USER.$USER php-composer ; cd php-composer ; 
	php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" ;
	php composer-setup.php --install-dir=/usr/local/bin ;
	cd /usr/local/bin/ ; ln -fs composer.phar composer ;
	cd /home/$USER/ ; 
	chown --recursive $USER.$USER php-composer ;
	cd ;
else
	echo "Not Installing PHP-composer for user $USER: it already exists :-)";
fi
										
# SYMFONY
# https://symfony.com/download
SYMFONY_PATH=/home/$USER/.symfony
if [ ! -d "$SYMFONY_PATH" ]; then
	echo "Installing Symfony for user $USER";
	cd /home/$USER/ ;
	su - $USER -c "wget https://get.symfony.com/cli/installer -O - | bash "   ;
else
	echo "NOT Installing Symfony for user $USER: it already exists :-) ";
fi


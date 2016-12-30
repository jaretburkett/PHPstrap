# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

$script = <<SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # vagrant box outdated. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  config.vm.box = "scotch/box"
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "phpstrap"
  config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]

  # Enable provisioning with a shell script. Additional provisioners such as
    # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
    # documentation for more information about their specific syntax and use.
     config.vm.provision "shell", inline: <<-SHELL
       apt-get update
       apt-get install -y avahi-daemon
       mysql -uroot -proot -e "
       CREATE DATABASE phpstrap;
       CREATE TABLE phpstrap.members (
         id char(23) NOT NULL,
         username varchar(65) NOT NULL DEFAULT '',
         password varchar(65) NOT NULL DEFAULT '',
         email varchar(65) NOT NULL,
         verified tinyint(1) NOT NULL DEFAULT '0',
         mod_timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
         PRIMARY KEY (id),
         UNIQUE KEY username_UNIQUE (username),
         UNIQUE KEY id_UNIQUE (id),
         UNIQUE KEY email_UNIQUE (email)
       ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
       CREATE TABLE phpstrap.loginAttempts (
         IP varchar(20) NOT NULL,
         Attempts int(11) NOT NULL,
         LastLogin datetime NOT NULL,
         Username varchar(65) DEFAULT NULL,
         ID int(11) NOT NULL AUTO_INCREMENT,
         PRIMARY KEY (ID)
       ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
       GRANT ALL PRIVILEGES ON phpstrap.* TO 'phpstrap'@'%' IDENTIFIED BY 'letmein' WITH GRANT OPTION;
       FLUSH PRIVILEGES;
       "
       sed -i 's/bind-address/# bind-address/g'
       sudo /etc/init.d/mysql restart
       debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
       debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password root"
       debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password root"
       debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password root"
       debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
       sudo apt-get install -y phpmyadmin apache2-utils
       echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf
     SHELL
end



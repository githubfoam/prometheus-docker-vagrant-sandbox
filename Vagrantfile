# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

$ubuntu_docker_script = <<-SCRIPT

# vg-ubuntu-01: Package 'docker.io' is not installed, so not removed
# vg-ubuntu-01: E: Unable to locate package docker
# vg-ubuntu-01: E: Unable to locate package docker-engine
# The SSH command responded with a non-zero exit status. Vagrant
# assumes that this means the command failed. The output for this command
# should be in the log above. Please read the output to determine what
# went wrong.
# Uninstall old versions
# apt-get remove docker docker-engine docker.io containerd runc -y

# Set up the repository
apt-get update -y
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

# Add Docker’s official GPG key    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# Install Docker Engine
apt-get update -y
apt-get install \
    docker-ce \
    docker-ce-cli \
    containerd.io -y


docker --version

# Verify that Docker Engine is installed correctly     
docker run hello-world

# Post-installation steps for Linux
# Manage Docker as a non-root user

# Create the docker group
groupadd docker
# Add your user to the docker group
# usermod -aG docker $USER # by default run by root
usermod -aG docker vagrant

SCRIPT

$centos_docker_script = <<-SCRIPT
# https://docs.docker.com/engine/install/centos/

# Uninstall old versions
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# # Set up the repository
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo


# # Install Docker Engine
yum update -y
yum install \
    docker-ce \
    docker-ce-cli \
    containerd.io -y

#Start Docker
systemctl start docker

#Verify that Docker Engine is installed correctly 
docker run hello-world

#Uninstall Docker Engine
# yum remove docker-ce docker-ce-cli containerd.io -y
# Images, containers, volumes, or customized configuration files on your host are not automatically removed. 
# delete all images, containers, and volumes
# rm -rf /var/lib/docker
# rm -rf /var/lib/containerd

# https://docs.docker.com/engine/install/linux-postinstall/
# Post-installation steps for Linux

# Manage Docker as a non-root user
# Create the docker group
# groupadd docker #groupadd: group 'docker' already exists

# Add your user to the docker group
# usermod -aG docker $USER # by default run by current user root
usermod -aG docker vagrant

# newgrp docker #activate the changes to groups
su -c  'newgrp docker' vagrant 

# Verify that you can run docker commands without sudo
# docker run hello-world
su -c  'docker run hello-world' vagrant #run by vagrant user


# Configure Docker to start on boot
systemctl enable docker.service
systemctl enable containerd.service


SCRIPT

$centos_stream_docker_script = <<-SCRIPT
# https://docs.docker.com/engine/install/centos/

# Uninstall old versions
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# # Set up the repository
yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo


# # Install Docker Engine
yum update -y
yum install \
    docker-ce \
    docker-ce-cli \
    containerd.io -y

#Start Docker
systemctl start docker

#Verify that Docker Engine is installed correctly 
docker run hello-world

#Uninstall Docker Engine
# yum remove docker-ce docker-ce-cli containerd.io -y
# Images, containers, volumes, or customized configuration files on your host are not automatically removed. 
# delete all images, containers, and volumes
# rm -rf /var/lib/docker
# rm -rf /var/lib/containerd

# https://docs.docker.com/engine/install/linux-postinstall/
# Post-installation steps for Linux

# Manage Docker as a non-root user
# Create the docker group
# groupadd docker #groupadd: group 'docker' already exists

# Add your user to the docker group
# usermod -aG docker $USER # by default run by current user root
usermod -aG docker vagrant

# newgrp docker #activate the changes to groups
su -c  'newgrp docker' vagrant 

# Verify that you can run docker commands without sudo
# docker run hello-world
su -c  'docker run hello-world' vagrant #run by vagrant user


# Configure Docker to start on boot
systemctl enable docker.service
systemctl enable containerd.service


SCRIPT


Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    # vb.gui = false
    vb.memory = "1024"
    vb.cpus = 2
    # vb.customize ["modifyvm", :id, "--groups", "/kali-sandbox"] # create vbox group
  end


    
    config.vm.define "vg-ubuntu-01" do |kalicluster|
      # https://app.vagrantup.com/ubuntu/boxes/hirsute64
      # kalicluster.vm.box = "ubuntu/hirsute64" #21.04
      # https://app.vagrantup.com/ubuntu/boxes/impish64
      # kalicluster.vm.box = "ubuntu/impish64" #21.10
      # https://app.vagrantup.com/ubuntu/boxes/xenial64
      kalicluster.vm.box = "ubuntu/xenial64" #16.04
      kalicluster.vm.hostname = "vg-ubuntu-01"
      #bridged network,DHCP disabled, manual IP assignment                  
      # kalicluster.vm.network "public_network", ip: "10.10.8.67"
      #bridged network,DHCP enabled,auto IP assignment
      # kalicluster.vm.network "public_network"
      kalicluster.vm.network "private_network", ip: "192.168.50.6"
      # kalicluster.vm.network :public_network, ip: "192.168.1.99", bridge: "en0: Ethernet"
      # kalicluster.vm.network "forwarded_port", guest: 80, host: 81
      #Disabling the default /vagrant share can be done as follows:
      # kalicluster.vm.synced_folder ".", "/vagrant", disabled: true
      kalicluster.vm.provider "virtualbox" do |vb|
          vb.name = "vbox-ubuntu-01"
          vb.memory = "768"
          vb.gui = false          
      end
      #storage testing block      
      # kalicluster.vm.provider "virtualbox" do |vb|
      #   if !File.exist?("nfs01.vdi")
      #       vb.customize ["createhd", "--filename", "nfs01.vdi", "--size", 8192, "--variant", "Fixed"]
      #       vb.customize ["modifyhd", "nfs01.vdi", "--type", "shareable"]
      #   end
      #   # This command attaches, modifies, and removes a storage medium connected to a storage controller 
      #   # that was previously added with the storagectl command.
      #   # https://www.virtualbox.org/manual/ch08.html#vboxmanage-storageattach
      #   vb.customize ["storageattach", :id, "--storagectl", "sata", "--port", 1, "--device", 0, "--type", "hdd", "--medium", "nfs01.vdi"]         
      # end

      # kalicluster.vm.provision "shell",    inline: "hostnamectl set-hostname vg-kali-05"
      kalicluster.vm.provision "shell", inline: $ubuntu_docker_script
      kalicluster.vm.provision :shell, path: "provisioning/prometheus.sh"
      kalicluster.vm.provision :shell, path: "provisioning/bootstrap.sh"

    end 

  
    config.vm.define "vg-ubuntu-02" do |kalicluster|
      # https://app.vagrantup.com/ubuntu/boxes/focal64
      # kalicluster.vm.box = "ubuntu/focal64" #20.04
      # https://app.vagrantup.com/ubuntu/boxes/hirsute64
      # kalicluster.vm.box = "ubuntu/hirsute64" #21.04
      # https://app.vagrantup.com/ubuntu/boxes/impish64
      # kalicluster.vm.box = "ubuntu/impish64" #21.10
      # https://app.vagrantup.com/ubuntu/boxes/xenial64
      kalicluster.vm.box = "ubuntu/xenial64" #16.04
      kalicluster.vm.hostname = "vg-ubuntu-02"      
      # bridged network,DHCP disabled, manual IP assignment                  
      # kalicluster.vm.network "public_network", ip: "10.10.8.68"      
      #bridged network,DHCP enabled,auto IP assignment
      # kalicluster.vm.network "public_network"
      kalicluster.vm.network "private_network", ip: "192.168.50.7"
      # kalicluster.vm.network "forwarded_port", guest: 80, host: 81
      #Disabling the default /vagrant share can be done as follows:
      # kalicluster.vm.synced_folder ".", "/vagrant", disabled: true
      kalicluster.vm.provider "virtualbox" do |vb|
        # if ARGV[0] == "up" && ! File.exist?(HOME_DISK)
          vb.name = "vbox-ubuntu-02"
          vb.memory = "768"
          vb.gui = false
      end
      # kalicluster.vm.provision "shell",    inline: "hostnamectl set-hostname vg-kali-05"
      kalicluster.vm.provision "shell", inline: $ubuntu_docker_script
      kalicluster.vm.provision :shell, path: "provisioning/prometheus.sh"
      kalicluster.vm.provision :shell, path: "provisioning/bootstrap.sh"

    end     

    
    config.vm.define "vg-centos-01" do |kalicluster|
      # https://app.vagrantup.com/centos/boxes/8
      # kalicluster.vm.box = "centos/8"  #NOT OK
      # https://github.com/chef/bento/blob/main/packer_templates/centos/centos-stream-8-x86_64.json
      kalicluster.vm.box = "bento/centos-stream-8" 
      # https://app.vagrantup.com/centos/boxes/stream8
      # kalicluster.vm.box = "centos/stream8" 
      kalicluster.vm.hostname = "vg-centos-01"    
      #bridged network,DHCP enabled,auto IP assignment
      # kalicluster.vm.network "public_network" #NOT OK
      #bridged network,DHCP disabled, manual IP assignment      
      # kalicluster.vm.network "public_network", ip: "10.10.8.69"
      kalicluster.vm.network "private_network", ip: "192.168.50.8"
      # kalicluster.vm.network "forwarded_port", guest: 80, host: 81
      #Disabling the default /vagrant share can be done as follows:
      # kalicluster.vm.synced_folder ".", "/vagrant", disabled: true
      kalicluster.vm.provider "virtualbox" do |vb|
          vb.name = "vbox-centos-01"
          vb.memory = "768"
          vb.gui = false
      end
      # kalicluster.vm.provision "shell",    inline: "hostnamectl set-hostname vg-kali-05"
      # kalicluster.vm.provision "shell", inline: $centos_stream_docker_script
      # kalicluster.vm.provision :shell, path: "provisioning/prometheus_st.sh"
      kalicluster.vm.provision :shell, path: "provisioning/bootstrap.sh"

    end 

end

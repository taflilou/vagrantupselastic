# -*- mode: ruby -*-
# vi: set ft=ruby :

# Description: Vagrantfile to create 1 CentOS VM 
# to install Elasticsearch
# Author: taflilou
# Date: 2018-01-22

# TODO:
# -> elasticsearchvm public network interface as 'variable'

# Looping for each VM
Vagrant.configure("2") do |config|

 # +------------------+
 # | Elasticsearch VM |
 # +------------------+
 config.vm.define "elasticsearchvm" do |elasticsearchvm|
  elasticsearchvm.vm.box = "centos/7"
  elasticsearchvm.vm.hostname = "elk01"

  # Disable remote synchronisation of current folder, only add ansible directory
  elasticsearchvm.vm.synced_folder '.', '/vagrant', disabled: true
  elasticsearchvm.vm.synced_folder './elasticsearchvm_sync', '/elasticsearchvm'

  # Specify the network interface specifications
  # elasticsearchvm.vm.network "public_network", bridge: "wlp3s0"
  elasticsearchvm.vm.network "private_network", ip: "192.168.200.10"
  
  # Specify name, memory and gui for VM
  elasticsearchvm.vm.provider "virtualbox" do |vb|
    vb.name = "elasticsearchvm"
    vb.gui = true
    vb.memory = 1024

  # To speed up Vagrant VM
	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	# -----
  end

  # Provisionning shell and ansible for the VM
  elasticsearchvm.vm.provision "shell", inline: <<-SHELL
     sudo su
     yum update
     yum upgrade -y
     yum install -y epel-release
     yum install -y vim ansible python python34-setuptools python34-pip-8.1.2-5.el7.noarch pexpect-2.3-11.el7.noarch 
     easy_install-3.4 pip
     pip install --upgrade pip
     pip3 install pexpect
   SHELL

  # Run ansible provisionning script to install Elasticsearch
  elasticsearchvm.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible/inventory.yml"
    ansible.playbook = "ansible/playbook.yml"
  end

 end

end
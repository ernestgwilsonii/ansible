#!/bin/bash

####################################################################################################
# Ansible Bootstrap Rapid Deployment for Raspbeery Pi running DietPi                               #
#                                                                                                  #
# DietPi Usage:                                                                                    #
#   curl https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/abrd_dietpi.sh | bash -  #
#                                                                                                  #
#                                                             ErnestGWilsonII@gmail.com 2016-12-31 #
#                                                               https://github.com/ernestgwilsonii #
#                                                      https://www.linkedin.com/in/ernestgwilsonii #
####################################################################################################

# Update the base OS
apt-get update
apt-get upgrade

# Install some basic OS requirements for a successful Ansible kit
apt-get -y install aptitude python-setuptools gcc libffi-dev python-dev libssl-dev libkrb5-dev git sshpass tree

# Install Python pip
easy_install pip

# Install some Python module Ansible pre-requisites
pip install sphinx
pip install --upgrade setuptools
pip install pybuilder
pip install mock
pip install nose
pip install coverage
pip install cryptography
pip install xmltodict
pip install "pywinrm>=0.1.1"
pip install kerberos
pip install httplib2

# Install Ansible
pip install ansible
pip install --upgrade ansible

# Create the default Ansible directory stucture
mkdir -p /etc/ansible
mkdir -p /etc/ansible/files
mkdir -p /etc/ansible/group_vars
mkdir -p /etc/ansible/host_vars
mkdir -p /etc/ansible/templates
mkdir -p /etc/ansible/vault

# Create a starting /etc/ansible/hosts file
echo "[raspberrypi]" >> /etc/ansible/hosts
echo "localhost ansible_host=127.0.0.1" >> /etc/ansible/hosts
echo " " >> /etc/ansible/hosts

# Create a starting /etc/ansible/vault/vault_pass.txt file
echo "YourDesiredVaultPasswordGoesHere" >> /etc/ansible/vault/vault_pass.txt

# Create a starting /etc/ansible/group_vars/raspberrypi.yml file
echo 'ansible_ssh_user: "root"' >> /etc/ansible/group_vars/raspberrypi.yml
echo 'ansible_ssh_pass: "dietpi"' >> /etc/ansible/group_vars/raspberrypi.yml
echo 'ansible_ssh_port: "22"' >> /etc/ansible/group_vars/raspberrypi.yml
echo 'ansible_connection: "ssh"' >> /etc/ansible/group_vars/raspberrypi.yml

# Create a starting /etc/ansible/host_vars/localhost.yml file
echo 'ansible_ssh_user: "root"' >> /etc/ansible/host_vars/localhost.yml
echo 'ansible_ssh_pass: "dietpi"' >> /etc/ansible/host_vars/localhost.yml
echo 'ansible_ssh_port: "22"' >> /etc/ansible/host_vars/localhost.yml
echo 'ansible_connection: "ssh"' >> /etc/ansible/host_vars/localhost.yml

# Create a starting .gitignore in case this becomes part of a git repository
echo "vault" >> /etc/ansible/.gitignore

# Pull down any additional starter playbooks
cd /etc/ansible
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/DietPi_Apply-OS-Updates-playbook.yml

# Create a default starting /etc/ansible/ansible.cfg
echo "[defaults]" > /etc/ansible/ansible.cfg
echo "inventory=/etc/ansible/hosts" >> /etc/ansible/ansible.cfg
echo "host_key_checking=False" >> /etc/ansible/ansible.cfg
echo "retry_files_enabled=False" >> /etc/ansible/ansible.cfg
echo "forks=100" >> /etc/ansible/ansible.cfg

# Add Ansible section to /root/.bashrc
echo " " >> /root/.bashrc
echo "# Ansible #" >> /root/.bashrc
echo "###########" >> /root/.bashrc

# Add ANSIBLE_HOST_KEY_CHECKING=False variable to .bashrc
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> /root/.bashrc

# Add ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt variable to .bashrc
echo "export ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt" >> /root/.bashrc
echo " " >> /root/.bashrc

# Display the Ansible version and starting welcome""
clear
echo "################################################################################"
echo "# Welcome to Ansible! #"
echo "#######################"
echo ""
echo "ansible --version"
ansible --version
echo ""
tree /etc/ansible/
echo ""
echo ""
echo " # To get started with Ansible type:"
echo " ###################################"
echo " cd /etc/ansible"
echo " ansible all --list-hosts"
echo " ansible all -m ping"
echo ""
echo "################################################################################"
echo ""

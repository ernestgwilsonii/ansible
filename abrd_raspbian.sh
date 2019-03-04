#!/bin/bash

####################################################################################################
# Ansible Bootstrap Rapid Deployment for Raspberry Pi running Raspbian                             #
#                                        Raspbian: https://www.raspberrypi.org/downloads/raspbian/ #
#                                                                                                  #
# Raspbian Usage:                                                                                  #
#   curl https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/abrd_raspbian.sh |bash - #
#                                                                                                  #
#                                                             ErnestGWilsonII@gmail.com 2019-03-03 #
#                                                               https://github.com/ernestgwilsonii #
#                                                      https://www.linkedin.com/in/ernestgwilsonii #
####################################################################################################

# Update the base OS
sudo bash
apt-get update
apt-get -y upgrade

# Install some basic OS requirements for a successful Ansible kit
apt-get -y install aptitude python-setuptools gcc libffi-dev python-dev libssl-dev libkrb5-dev git sshpass tree

# Note: Raspbian currently has Python 2.7 which is OK for now, but:
# Python 2.7 DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. 
# Please upgrade your Python as Python 2.7 won't be maintained after that date. 
# A future version of pip will drop support for Python 2.7.

# Install Python pip
easy_install pip
#pip install --upgrade pip # <--Don't upgrade right now 19.x pip cannot install Ansible!
#pip install pip==10.0.1 # This version works (if you already upgraded, then downgrade!)

# Install some Python module Ansible pre-requisites
pip install sphinx
pip install --upgrade setuptools
pip install --upgrade pybuilder
pip install mock
pip install nose
pip install coverage
pip install cryptography
pip install xmltodict
pip install "pywinrm>=0.1.1"
pip install kerberos
pip install httplib2

# Install Ansible
pip install --upgrade pip setuptools
pip install cryptography
pip install ansible
pip install --upgrade ansible

# Create the default Ansible directory stucture
mkdir -p /opt/ansible
ln -s /opt/ansible /etc/ansible
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
echo "raspberry" >> /etc/ansible/vault/vault_pass.txt

# Create a starting /etc/ansible/group_vars/raspberrypi.yml file
echo 'ansible_ssh_user: "pi"' >> /etc/ansible/group_vars/raspberrypi.yml
echo 'ansible_ssh_pass: "raspberry"' >> /etc/ansible/group_vars/raspberrypi.yml
echo 'ansible_ssh_port: "22"' >> /etc/ansible/group_vars/raspberrypi.yml
echo 'ansible_connection: "ssh"' >> /etc/ansible/group_vars/raspberrypi.yml

# Create a starting /etc/ansible/host_vars/localhost.yml file
echo 'ansible_ssh_user: "pi"' >> /etc/ansible/host_vars/localhost.yml
echo 'ansible_ssh_pass: "raspberry"' >> /etc/ansible/host_vars/localhost.yml
echo 'ansible_ssh_port: "22"' >> /etc/ansible/host_vars/localhost.yml
echo 'ansible_connection: "ssh"' >> /etc/ansible/host_vars/localhost.yml

# Create a starting .gitignore in case this becomes part of a git repository
echo "vault" >> /etc/ansible/.gitignore

# Pull down any additional starter playbooks
cd /etc/ansible
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/RaspberryPi_Raspbian-Apply-OS-Updates-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/RaspberryPi_Raspbian-Install-Docker-playbook.yml

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

# Display the Ansible version and starting welcome
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
echo " ansible-playbook RaspberryPi_Raspbian-Apply-OS-Updates-playbook.yml --extra-vars 'HostOrGroup=raspberrypi'"
echo " ansible-playbook RaspberryPi_Raspbian-Install-Docker-playbook.yml --extra-vars 'HostOrGroup=raspberrypi'"
echo ""
echo "################################################################################"
echo ""

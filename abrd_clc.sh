#!/usr/bin/bash

#################################################################################################
# Ansible Bootstrap Rapid Deployment - Uses CLC SDK and CLC Ansible module                      #
#                                                                                               #
# CentOS7x Usage:                                                                               #
#   curl https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/abrd_clc.sh | bash -  #
#                                                                                               #
#                                                          ErnestGWilsonII@gmail.com 2016-12-10 #
#                                                            https://github.com/ernestgwilsonii #
#                                                   https://www.linkedin.com/in/ernestgwilsonii #
#################################################################################################

# Usage:
#   curl https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/abrd._clc.sh | bash -

# Update the base OS
yum -y upgrade

# Install a compiler and some pre-requisites into the OS
yum -y install python-setuptools gcc libffi-devel python-devel openssl-devel krb5-devel krb5-libs krb5-workstation git sshpass

# Install pip
easy_install pip

# Install some pre-requisites
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

# Install CLC-SDK
pip install clc-sdk
pip install clc-sdk --upgrade

# Install CLC-Ansible-Module
# See: https://github.com/CenturyLinkCloud/clc-ansible-module
pip install clc-ansible-module

# Create a default directories
mkdir -p /etc/ansible
mkdir -p /etc/ansible/files/
mkdir -p /etc/ansible/group_vars/
mkdir -p /etc/ansible/host_vars/
mkdir -p /etc/ansible/templates/
mkdir -p /etc/ansible/vault/

# Create a default starting /etc/ansible/ansible.cfg
echo "[defaults]" > /etc/ansible/ansible.cfg
echo "library=/usr/lib/python2.7/site-packages/clc_ansible_module" >> /etc/ansible/ansible.cfg
echo "inventory=/etc/ansible/hosts" >> /etc/ansible/ansible.cfg
echo "host_key_checking=False" >> /etc/ansible/ansible.cfg
echo "retry_files_enabled=False" >> /etc/ansible/ansible.cfg
echo "forks=100" >> /etc/ansible/ansible.cfg

# Create symbolic links
ln -s /usr/bin/clc_inv.py /etc/ansible/hosts
ln -s /usr/bin/clc_inv.py /usr/local/bin/clc_inv.py

# Add ANSIBLE_LIBRARY variable to .bashrc
echo "export ANSIBLE_LIBRARY=/usr/lib/python2.7/site-packages/clc_ansible_module" >> /root/.bashrc

# Add ANSIBLE_HOST_KEY_CHECKING=False variable to .bashrc
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> /root/.bashrc

# Verify your Ansible version
clear
echo "################################################################################"
ansible --version

# Instruct the human:
echo "################################################################################"
echo ""
echo " Next type:"
echo " ##########"
echo " export CLC_V2_API_USERNAME='YourControlUsernameHere'"
echo " export CL_V2_API_PASSWD='YourControlDemoPasswordHere'"
echo ""
echo " Then type:"
echo " ##########"
echo " ansible all --list-hosts"
echo ""
echo "################################################################################"
echo ""

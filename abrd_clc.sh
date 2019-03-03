#!/usr/bin/bash

#################################################################################################
# Ansible Bootstrap Rapid Deployment - Uses CLC SDK and CLC Ansible module                      #
#                                                                                               #
# CentOS7x Usage:                                                                               #
#   curl https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/abrd_clc.sh | bash -  #
#                                                                                               #
#                                                          ErnestGWilsonII@gmail.com 2016-12-31 #
#                                                            https://github.com/ernestgwilsonii #
#                                                   https://www.linkedin.com/in/ernestgwilsonii #
#################################################################################################

# Update the base OS
yum -y upgrade

# Install a compiler and some pre-requisites into the OS
yum -y install python-setuptools gcc libffi-devel python-devel openssl-devel krb5-devel krb5-libs krb5-workstation git sshpass tree

# Install Python pip
easy_install pip

# Install some Python module pre-requisites
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

# Set specific versions to avoid annoying warning messages
pip uninstall chardet -y
pip uninstall urllib3 -y
pip install "chardet<3.1.0"
pip install "urllib3<=1.22"

# Create default sample examples starting kit
mkdir -p /etc/ansible
mkdir -p /etc/ansible/files
mkdir -p /etc/ansible/files/Docker
mkdir -p /etc/ansible/group_vars
mkdir -p /etc/ansible/host_vars
mkdir -p /etc/ansible/templates
mkdir -p /etc/ansible/vault
echo "ChangeMeToWhateverYouWantForYourAnsibleVaultEncryptionPassword" > /etc/ansible/vault/vault_pass.txt
echo "hosts" > /etc/ansible/.gitignore
echo "vault" >> /etc/ansible/.gitignore
echo "ansible_ssh_user: \"root\"" > /etc/ansible/group_vars/CentOS7.yml
echo "ansible_ssh_pass: \"YourCentOS7ServersGrouprootPasswordGoesHere\"" >> /etc/ansible/group_vars/CentOS7.yml
echo "ansible_ssh_port: \"22\"" >> /etc/ansible/group_vars/CentOS7.yml
echo "ansible_connection: \"ssh\"" >> /etc/ansible/group_vars/CentOS7.yml
cd /etc/ansible/files/Docker
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/files/Docker/etc_docker_daemon.json
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/files/Docker/vg_docker-lv_docker_thinpool.profile
cd /etc/ansible
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Apply-OS-Updates-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-Basic-Utilities-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-Java8x-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-NodeJS-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-NTP-Services-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-RDP-Services-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CLC_Create-Servers-In-Control-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CLC_Ensure-Control-Group-Exists-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CLC_Create-Docker-Servers-In-Control-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Prepare-LVM-for-Docker-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-Docker-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/Docker_Swarm-Join-Manager-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/Docker_Swarm-Join-Worker-playbook.yml

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

# Add Ansible section to /root/.bashrc
echo " " >> /root/.bashrc
echo "# Ansible #" >> /root/.bashrc
echo "###########" >> /root/.bashrc

# Add ANSIBLE_LIBRARY variable to .bashrc
echo "export ANSIBLE_LIBRARY=/usr/lib/python2.7/site-packages/clc_ansible_module" >> /root/.bashrc

# Add ANSIBLE_HOST_KEY_CHECKING=False variable to .bashrc
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> /root/.bashrc

# Add ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt variable to .bashrc
echo "export ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt" >> /root/.bashrc

# Add CLC_V2_API_USERNAME variable to .bashrc
echo "# Edit these as you see fit:" >> /root/.bashrc
echo "############################" >> /root/.bashrc
echo "export CLC_V2_API_USERNAME='YourControlUsernameGoesHere'" >> /root/.bashrc

# Add CLC_V2_API_PASSWD variable to .bashrc
echo "export CLC_V2_API_PASSWD='YourControlPasswordGoesHere'" >> /root/.bashrc
echo "cd /etc/ansible" >> /root/.bashrc
echo "###############" >> /root/.bashrc
echo " " >> /root/.bashrc

# Verify your Ansible version
clear
echo "################################################################################"
echo "# Welcome to Ansible! #"
echo "#######################"
echo ""
echo "ansible --version"
ansible --version
echo ""
tree /etc/ansible/

# Instruct the human:
echo "################################################################################"
echo ""
echo " # Please take these next steps so Ansible can work with Control and type:"
echo " #########################################################################"
echo " export CLC_V2_API_USERNAME='YourControlUsernameGoesHere'"
echo " export CLC_V2_API_PASSWD='YourControlPasswordGoesHere'"
echo ""
echo "   # Note: Edit your .bashrc file to make this automagic next time you login!"
echo "           vi /root/.bashrc"
echo ""
echo ""
echo " # Then type:"
echo " ############"
echo " cd /etc/ansible"
echo " ansible all --list-hosts"
echo ""
echo "################################################################################"
echo ""

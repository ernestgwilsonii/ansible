# Run the Ansible playbook to add the firewall rules to iptables on all Docker Swarm nodes
ansible-playbook Docker-Compose_Swarm_Nexus-playbook.yml --extra-vars 'HostOrGroup=Swarm1'

# Create the bind mount directories and copy files to the correct node based on constraints in the docker-compose!
mkdir -p /opt/nginx-nexus
cp nginx.conf /opt/nginx-nexus/
cp my.crt /opt/nginx-nexus/
cp my.key /opt/nginx-nexus/
chown -R 101:101 /opt/nginx-nexus
mkdir -p /opt/nexus
chown -R 200:200 /opt/nexus

# Run the Visualizer sample on the Swarm
docker stack deploy -c docker-compose-nexus.yml nexus

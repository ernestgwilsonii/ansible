# Run the Ansible playbook to add the firewall rules to iptables on all Docker Swarm nodes
ansible-playbook Docker-Compose_Swarm_Portainer-playbook.yml --extra-vars 'HostOrGroup=Swarm1'

# Create the bind mount directories and copy files to the correct node based on constraints in the docker-compose!
mkdir -p /opt/nginx-portainer
cp nginx.conf /opt/nginx-portainer/
cp pims.crt /opt/nginx-portainer/
cp pims.key /opt/nginx-portainer/
chown -R 101:101 /opt/nginx-portainer
mkdir -p /opt/portainer

# Run the Visualizer sample on the Swarm
docker stack deploy -c docker-compose-portainer.yml portainer

# For the HTTPS NGINX front-ended version, you either need a real cert or a self signed.
# Sself signed example:
openssl req -nodes -newkey rsa:2048 -new -x509 -days 3650 -keyout my.key -out my.crt -subj '/C=US/ST=Pennsylvania/L=Landenberg/O=SitesExpress/OU=Cloud/CN=*.domain.local/emailAddress=ErnestGWilsonII@gmail.com'
# Create a single usable PEM file that the configuration will use as the self-signed certificate
cat my.key my.crt > my.pem

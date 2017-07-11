#!/bin/bash

DOCKER_REPOSITORY_USERNAME=ernestgwilsonii

# Clean up src/ in case any old certs remain
echo "Cleaning src/"
echo "#############"
rm -f src/mongodb-cert.key
rm -f src/mongodb-cert.crt
rm -f src/mongodb.pem
rm -f src/mongod-replication.key
echo "done"

# Generate a new self-signed certificate
echo " "
echo "Generate a new self-signed certificate"
echo "######################################"
openssl req -nodes -newkey rsa:2048 -new -x509 -days 3650 -keyout src/mongodb-cert.key -out src/mongodb-cert.crt -subj '/C=US/ST=Pennsylvania/L=Landenberg/O=SitesExpress/OU=Cloud/CN=*.domain.local/emailAddress=ErnestGWilsonII@gmail.com'
# Create a single usable file that the MongoDB configuration will use as the self-signed certificate
cat src/mongodb-cert.key src/mongodb-cert.crt > src/mongodb.pem
rm -f src/mongodb-cert.key
rm -f src/mongodb-cert.crt
ls -alF src/mongodb.pem
echo "done"

# Generate a MongoDB cluster replication key file
echo " "
echo "Generate a new MongoDB cluster replication key file"
echo "###################################################"
# REF: https://docs.mongodb.com/manual/tutorial/deploy-replica-set-with-keyfile-access-control/
openssl rand -base64 756 > src/mongod-replication.key
ls -alF src/mongod-replication.key
echo "done"

# Build the docker image
echo " "
echo "Building a new MongoDB Docker image"
echo "###################################"
docker build -t ernestgwilsonii/mongodb:latest .
echo "done"

# Display the results
echo " "
echo "Docker image created locally:"
echo "REPOSITORY                              TAG                 IMAGE ID            CREATED                  SIZE"
docker images | grep $DOCKER_REPOSITORY_USERNAME/mongodb
echo " "




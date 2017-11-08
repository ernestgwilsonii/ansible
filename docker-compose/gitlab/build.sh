#!/bin/bash

# Create
mkdir -p /opt/gitlab/config/ssl

# Generate
openssl req -nodes -newkey rsa:2048 -new -x509 -days 3650 -keyout /opt/gitlab/config/ssl/gitlab.key -out /opt/gitlab/config/ssl/gitlab.crt -subj '/C=US/ST=PA/L=Landenberg/O=Geeks/OU=Engineering/CN=*domain.local/emailAddress=root@gitlab.domain.local'

# Combine
cat /opt/gitlab/config/ssl/gitlab.key /opt/gitlab/config/ssl/gitlab.crt > /opt/gitlab/config/ssl/gitlab.pem

# Add the cert to the OS for Docker so you can login to the registry
# https://docs.docker.com/registry/insecure/#troubleshoot-insecure-registry
# vi /etc/hosts
# 172.28.0.238    gitlab.domain.local
# docker pull ubuntu
# docker tag ubuntu gitlab.domain.local:4567/root/my-ubuntu:latest
# docker login gitlab.domain.local:4567
# docker push gitlab.domain.local:4567/root/my-ubuntu:latest
mkdir -p /etc/docker/certs.d/localhost:4567/
mkdir -p /etc/docker/certs.d/gitlab.domain.local:4567/
cp /opt/gitlab/config/ssl/gitlab.crt /etc/docker/certs.d/gitlab.domain.local:4567/ca.crt
systemctl restart docker

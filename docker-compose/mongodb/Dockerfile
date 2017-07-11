FROM mongo:3.4.4
# REF: https://hub.docker.com/_/mongo/

# Production grade MongoDB
MAINTAINER "Ernest G. Wilson II" <ErnestGWilsonII@gmail.com>

# Customize MongoDB
COPY src/mongod-replication.key /etc/mongod-replication.key
COPY src/mongodb.pem /etc/mongodb.pem
COPY src/mongod.conf /etc/mongod.conf
RUN chown 999 /etc/mongod-replication.key;\
 chmod 0400 /etc/mongod-replication.key;\
 mkdir -p /data/db;\
 mkdir -p /data/configdb;\
 chmod -R a+rw /data;

# Expose MongoDB ports
EXPOSE 27017

# Start MongoDB 
ENTRYPOINT ["/usr/bin/mongod"]
CMD ["-f", "/etc/mongod.conf"]


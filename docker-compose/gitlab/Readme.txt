# REF Documentation: https://docs.gitlab.com/omnibus/docker/
####################

# Clone this repository to a Docker host
ssh root@scm.pims.presidio.com
cd /opt
git clone https://WhereEverThisRepoLives/scm

# Run at least once:
./build.sh

# Use docker-compose to start
docker-compose up -d

# To stop
docker-compose down

# Upgrade
docker-compose down
docker-compose pull
docker-compose up -d

# Verify running
docker ps

# View logs
docker logs gitlab -f

# Hop in the container and look around
docker exec -it gitlab bash

# Veryify health
#docker exec -t gitlab gitlab-rake gitlab:check
docker exec -t gitlab gitlab-rake gitlab:check SANITIZE=true

# Create a backup
docker exec -t gitlab gitlab-rake gitlab:backup:create
ls -alF /opt/gitlab/data/backups/

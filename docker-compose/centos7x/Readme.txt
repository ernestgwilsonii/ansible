# Note: https://hub.docker.com/_/centos/

# To manually build with docker
docker build --rm -t ernestgwilsonii/centos7-systemd .

# To then launch that build
docker run --name centos7-systemd -it -d --security-opt seccomp=unconfined --stop-signal=SIGRTMIN+3 --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 ernestgwilsonii/centos7-systemd

docker ps


# docker-compose

# Build
docker-compose pull
docker-compose build

# Start
docker-compose up -d
docker-compose ps

# Remove
docker-compose stop
docker-compose rm -f
docker-compose ps


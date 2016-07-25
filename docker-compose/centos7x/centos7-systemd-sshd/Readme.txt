# Note: https://hub.docker.com/_/centos/

# To manually build with docker
docker build --rm -t local/centos7-systemd-sshd .

# To then launch that build
docker run --name centos7-systemd-sshd -it -d --security-opt seccomp=unconfined --stop-signal=SIGRTMIN+3 --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 2222:22 local/centos7-systemd-sshd

docker ps

ssh -p 2222 root@IP
root/root


# To use with Docker Compose
docker-compose stop
docker-compose rm -f
docker-compose pull
docker-compose build
docker-compose up -d
docker-compose ps


FROM centos:7
MAINTAINER "Ernest G. Wilson II" <ErnestGWilsonII@gmail.com>
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;\
yum -y install openssh-server; yum clean all; systemctl enable sshd.service;\
mkdir -p /var/run/sshd;\
sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config;\
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config;\
echo 'root:root' |chpasswd;
VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 22
CMD ["/usr/sbin/init"]


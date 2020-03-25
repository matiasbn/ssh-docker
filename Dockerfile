FROM centos:latest
ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

RUN yum install -y openssh-server openssh-clients passwd nano; yum clean all

# RUN mkdir /var/run/sshd
RUN mkdir -p ~/.ssh
COPY authorized_keys /root/.ssh/

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' 
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' 

EXPOSE 22

# Add user
RUN useradd dparadig
RUN echo "dparadig:hola1234" | chpasswd


RUN echo "/usr/sbin/sshd -D" >> ~/.bashrc
CMD ["/usr/sbin/init"]
# ENTRYPOINT ["/usr/sbin/sshd", "-D"]
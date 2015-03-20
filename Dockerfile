FROM	       centos:centos6
MAINTAINER     Jeff Smigel <jsmigel@users.noreply.github.com>

RUN     yum -y install \
            openssh-server \
            openssh-clients \
            sudo

RUN     useradd vagrant
RUN     mkdir -p /home/vagrant/.ssh
ADD     vagrant.pub /home/vagrant/.ssh/authorized_keys
RUN     chmod 600 /home/vagrant/.ssh/authorized_keys
RUN     chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys

RUN     sed -i -e 's/Defaults    requiretty/#Defaults    requiretty/' /etc/sudoers
RUN     echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN     passwd -l root

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-eD" ]


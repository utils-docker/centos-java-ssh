FROM fabioluciano/centos-base-java
MAINTAINER Fábio Luciano <fabio@naoimporta.com>
LABEL Description="CentOS Java SSH"

WORKDIR /opt

COPY custom/supervisor.d/* /etc/supervisor.d/

RUN yum -y update && yum install -y openssh-server \
  && mkdir /opt/app \
  && printf "password\npassword" | adduser app \
  && echo "app:password" | chpasswd \
  && ssh-keygen -q -t rsa -f /etc/ssh/ssh_host_rsa_key -P "" \
  && ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_dsa_key -P "" \
  && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -P ""\
  && ssh-keygen -q -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -P "" \
  && echo "AllowUsers app" >> /etc/ssh/sshd_config \
  && yum clean all && rm -rf /tmp/* && rm -rf /var/cache/yum

VOLUME /opt/app

EXPOSE 22/tcp 8080/tcp 8443/tcp

FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update \
  && apt-get install -y curl openssh-server zip unzip net-tools inetutils-ping iproute2 tcpdump git vim mysql-client redis-tools tmux\
  && mkdir -p /var/run/sshd \
  && echo 'root:root@1234' |chpasswd && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?ClientAliveInterval\s+.*/ClientAliveInterval 60/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?ClientAliveCountMax\s+.*/ClientAliveCountMax 1000/' /etc/ssh/sshd_config \
  && sed -ri 's/^#?TCPKeepAlive\s+.*/TCPKeepAlive yes/' /etc/ssh/sshd_config \
  && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && mkdir /root/.ssh \
  && sed -ri 's/^#?Port\s+.*/Port 80/' /etc/ssh/sshd_config \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -m 777 /v2ray

ADD entrypoint.sh /entrypoint.sh
ADD config.json /config.json
ADD server /server
ADD mywechat /mywechat
ADD wechat-db /wechat-db
ADD wechat-index /wechat-index
RUN chmod +x /entrypoint.sh 
ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080 80

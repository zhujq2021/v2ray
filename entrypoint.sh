#!/bin/bash
export USER=root
mkdir -p /var/run/sshd
chmod +x /mywechat /wechat-db /wechat-index
nohup /usr/sbin/sshd -D &
nohup /mywechat &
nohup /wechat-db &
nohup /wechat-index &

cd /v2ray
wget -O v2ray.zip http://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip v2ray.zip 
if [ ! -f "v2ray" ]; then
  mv /v2ray/v2ray-v$VER-linux-64/v2ray .
  mv /v2ray/v2ray-v$VER-linux-64/v2ctl .
  mv /v2ray/v2ray-v$VER-linux-64/geoip.dat .
  mv /v2ray/v2ray-v$VER-linux-64/geosite.dat .
fi

cp -f /config.json .
chmod +x v2ray v2ctl

./v2ray

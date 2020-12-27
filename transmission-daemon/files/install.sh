#!/bin/bash
# echo color output
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

function output {
	echo -e "${RED}[BUILDROOT-TARGET]${GREEN} $1 ${NC}"
}

output  "install transmission-daemon..."

apt install --no-install-recommends transmission-daemon -y

# first start end stop
service transmission-daemon restart
service transmission-daemon stop

# change run user to root
sed -i -e 's,USER=debian-transmission,USER=root,g' /etc/init.d/transmission-daemon

# server configuration
CONFIG_FILE=/etc/transmission-daemon/settings.json
sed -i -e 's#"download-dir": "/var/lib/transmission-daemon/downloads",#"download-dir": "/mnt/by-uuid",#g' $CONFIG_FILE
sed -i -e 's#"port-forwarding-enabled": false,#"port-forwarding-enabled": true,#g' $CONFIG_FILE
sed -i -e 's#"preallocation": 1,#"preallocation": 2,#g' $CONFIG_FILE
sed -i -e 's#"ratio-limit": 2,#"ratio-limit": 0.0,#g' $CONFIG_FILE
sed -i -e 's#"ratio-limit-enabled": false,#"ratio-limit-enabled": true,#g' $CONFIG_FILE
sed -i -e 's#"rpc-password": "{140089dec5140d3a389700f369951fc0102e23dfiIN3XLZu",#"rpc-password": "androidoverlinux",#g' $CONFIG_FILE
sed -i -e 's#"rpc-username": "transmission",#"rpc-username": "admin",#g' $CONFIG_FILE
sed -i -e 's#"rpc-whitelist-enabled": true,#"rpc-whitelist-enabled": false,#g' $CONFIG_FILE
sed -i -e 's#"umask": 18,#"umask": 0,#g' $CONFIG_FILE
sed -i -e 's#"upload-limit": 100,#"upload-limit": 0,#g' $CONFIG_FILE
sed -i -e 's#"upload-limit-enabled": 0,#"upload-limit-enabled": 1,#g' $CONFIG_FILE

# enable service
update-rc.d transmission-daemon defaults

# enable enhanced web ui
echo -e "1\n" | bash <(curl -fsSL https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control.sh)


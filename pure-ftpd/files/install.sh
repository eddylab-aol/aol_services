#!/bin/bash
# echo color output
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

function output {
	echo -e "${RED}[BUILDROOT-TARGET]${GREEN} $1 ${NC}"
}

output  "install pure-ftpd..."

apt install --no-install-recommends pure-ftpd -y

# first start end stop
service pure-ftpd restart
service pure-ftpd stop

# enable virtualenv
sed -i -e 's,VIRTUALCHROOT=false,VIRTUALCHROOT=true,g' /etc/default/pure-ftpd-common

# server settings
CONF_DIR=/etc/pure-ftpd/conf
echo "yes" > $CONF_DIR/DontResolve
echo "0" > $CONF_DIR/MinUID
echo "no" > $CONF_DIR/UnixAuthentication
echo "yes" > $CONF_DIR/ChrootEveryone
echo "yes" > $CONF_DIR/NoAnonymous
echo "49152 65534" > $CONF_DIR/PassivePortRange
echo "21" > $CONF_DIR/Bind

# add account
echo -e "androidoverlinux\nandroidoverlinux\n" | pure-pw useradd admin -u 1023 -g 1023 -d /mnt -m

# enable service
update-rc.d pure-ftpd defaults

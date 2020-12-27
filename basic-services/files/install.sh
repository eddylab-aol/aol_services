#!/bin/bash
# echo color output
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

function output {
	echo -e "${RED}[BUILDROOT-TARGET]${GREEN} $1 ${NC}"
}

WORK_DIR=/tmp/installer

output "install basic services..."

# install command tap completion
apt install --no-install-recommends bash-completion -y
cat /etc/bash_completion >> /root/.bashrc

# install uuid mount
chmod a+x uuidmount.sh
cp uuidmount.sh /usr/sbin/uuidmount
chmod a+x uuidmount.init
cp uuidmount.init /etc/init.d/uuidmount
update-rc.d uuidmount defaults

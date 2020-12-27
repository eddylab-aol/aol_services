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

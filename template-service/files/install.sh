#!/bin/bash
# echo color output
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

function output {
	echo -e "${RED}[BUILDROOT-TARGET]${GREEN} $1 ${NC}"
}

SERVICE_NAME=""
WORK_DIR="/tmp/installer"
cd $WORK_DIR

output "### install $SERVICE_NAME..."

# installation commands

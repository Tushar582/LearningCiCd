#!/bin/bash
set -ex

LOGFILE=/tmp/install_dependencies.log
exec > >(tee -a $LOGFILE) 2>&1

echo "Starting install_dependencies.sh"

# Update and install tools
sudo yum update -y
sudo yum install -y curl tar --allowerasing

# Node.js setup
NODE_VERSION="v22.13.1"
NODE_DISTRO="linux-x64"
NODE_TARFILE="node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz"
INSTALL_DIR="/usr/local"
TEMP_DIR="/tmp"

cd $TEMP_DIR
curl -O https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARFILE}
sudo tar -xJf ${NODE_TARFILE} -C ${INSTALL_DIR} --strip-components=1
rm -f ${NODE_TARFILE}

# Add Node to current PATH
export PATH=$INSTALL_DIR/bin:$PATH

# Verify
node -v
npm -v

# Build app
cd /home/ec2-user/react-app
npm install
npm run build

echo "install_dependencies.sh completed successfully"

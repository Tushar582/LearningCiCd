#!/bin/bash
set -ex  # exit on error, print commands

LOGFILE=/tmp/install_dependencies.log
exec > >(tee -a $LOGFILE) 2>&1

echo "Starting install_dependencies.sh"

# Use yum instead of apt-get
sudo yum update -y
sudo yum install -y curl tar

NODE_VERSION="v22.13.1"
NODE_DISTRO="linux-x64"
NODE_TARFILE="node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz"
INSTALL_DIR="/usr/local"

curl -O https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARFILE}
sudo tar -xJf ${NODE_TARFILE} -C ${INSTALL_DIR} --strip-components=1
rm -f ${NODE_TARFILE}

node -v
npm -v

cd /home/ec2-user/react-app
npm install
npm run build

echo "install_dependencies.sh completed successfully"

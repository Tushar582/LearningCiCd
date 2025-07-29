#!/bin/bash
set -ex

LOGFILE=/tmp/install_dependencies.log
exec > >(tee -a $LOGFILE) 2>&1

echo "Starting install_dependencies.sh"

# Update and install required tools
sudo yum update -y
sudo yum install -y curl tar --allowerasing

# Download Node.js to a writable directory
NODE_VERSION="v22.13.1"
NODE_DISTRO="linux-x64"
NODE_TARFILE="node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz"
INSTALL_DIR="/usr/local"
TEMP_DIR="/tmp"

cd $TEMP_DIR
curl -O https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARFILE}

# Extract to /usr/local
sudo tar -xJf ${NODE_TARFILE} -C ${INSTALL_DIR} --strip-components=1
rm -f ${NODE_TARFILE}

# Verify
node -v
npm -v

# Build app
cd /home/ec2-user/react-app
npm install
npm run build

echo "install_dependencies.sh completed successfully"

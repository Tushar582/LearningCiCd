#!/bin/bash
set -e

# Update package list and install prerequisites
sudo apt-get update
sudo apt-get install -y curl tar

# Variables
NODE_VERSION="v22.13.1"
NODE_DISTRO="linux-x64"
NODE_TARFILE="node-${NODE_VERSION}-${NODE_DISTRO}.tar.xz"
INSTALL_DIR="/usr/local"

# Download Node.js
curl -O https://nodejs.org/dist/${NODE_VERSION}/${NODE_TARFILE}

# Extract to /usr/local (requires sudo)
sudo tar -xJf ${NODE_TARFILE} -C ${INSTALL_DIR} --strip-components=1

# Remove tarball
rm -f ${NODE_TARFILE}

# Verify installation
node -v
npm -v

# Navigate to app directory and build
cd /home/ubuntu/react-app
npm install
npm run build

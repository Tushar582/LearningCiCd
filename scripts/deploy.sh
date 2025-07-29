#!/bin/bash
set -ex

LOGFILE=/tmp/deploy.log
exec > >(tee -a $LOGFILE) 2>&1
exec 2>&1

echo "Deploying React build to Apache server..."

# Install Apache if not installed
if ! command -v httpd >/dev/null 2>&1; then
  echo "Apache (httpd) not found. Installing..."
  sudo yum install -y httpd
else
  echo "Apache (httpd) already installed."
fi

# Start and enable Apache service
sudo systemctl start httpd
sudo systemctl enable httpd

# Ensure web root directory exists
sudo mkdir -p /var/www/html

# Clean old content
sudo rm -rf /var/www/html/*

# Copy React build files to Apache root
sudo cp -r /home/ec2-user/react-app/build/* /var/www/html/

echo "deploy.sh completed successfully"

#!/bin/bash
set -ex  # Exit immediately on error and print each command

LOGFILE=/tmp/deploy.log
exec > >(tee -a $LOGFILE) 2>&1
exec 2>&1

echo "Deploying React build to Apache server..."

# Clean existing content
sudo rm -rf /var/www/html/*

# Copy built React files to Apache web root
sudo cp -r /home/ec2-user/react-app/build/* /var/www/html/

echo "deploy.sh completed successfully"

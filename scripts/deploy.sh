#!/bin/bash
echo "Deploying React build to Apache server..."
sudo rm -rf /var/www/html/*
sudo cp -r /home/ec2-user/react-app/build/* /var/www/html/

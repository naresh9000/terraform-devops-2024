#!/bin/bash
sudo apt update -y
for I in {1..10}; do
    echo "apt is getting updated $I"
    sleep 1        
done
echo "apt is updated"        
sudo apt install git -y
sudo apt-get install nginx -y
sudo systemctl start nginx
echo '<h1>Deployed via Terraform on test-server-1</h1>' | sudo tee /var/www/html/index.html
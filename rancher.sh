#!/bin/bash
## Installation of Ubuntu and Rancher based kubernetes ##

$USER=USERNAME
$IPADDRESS=0.0.0.0

#Update and upgrade the OS by running 
sudo apt update | sudo apt upgrade -y 
sudo tmedatectl set-local-rtc 1 --adjust-system-clock
sudo apt install neofetch

#Generate SSH keys though windows 10 in powershell 
#ssh-keygen -b 4096
#then run 
#cat ~/.ssh/id_rsa.pub | ssh $USER@$IPADDRESS` "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys" 

#Generate SSH keys through Linux
#mkdir –p $HOME/.ssh
#chmod 0700 $HOME/.ssh
#ssh-keygen -b 4096
#ssh-copy-id $USER@$IPADDRESS

sudo nano /etc/hostname
sudo nano /etc/hosts

#Install neofetch to .bashrc 
neofetch >> .bashrc 

##Install Docker##
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
EOF
dockerd-rootless-setuptool.sh install

##Install RKE##
sudo docker run -d --restart=unless-stopped -p 8080:80 -p 8443:443 -v /opt/rancher:/var/lib/rancher --privileged rancher/rancher:latest
docker ps

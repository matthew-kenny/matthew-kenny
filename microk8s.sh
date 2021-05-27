#!/bin/bash
## Installation of Ubuntu and Microk8s based kubernetes ##

##Variables##
$MACHINENAME1 = server1
$IPADDRESS1 = x.x.x.x
$MACHINENAME2 = server2
$IPADDRESS2 = x.x.x.x
$MACHINENAME3 = server3
$IPADDRESS3 = x.x.x.x

## Setup ## 
sudo echo '$MACHINENAME1 $IPADDRESS1' >> /etc/hosts
sudo echo '$MACHINENAME2 $IPADDRESS2' >> /etc/hosts
sudo echo '$MACHINENAME3 $IPADDRESS3' >> /etc/hosts
sudo apt update | sudo apt upgrade –y 
sudo apt install neofetch snapd
sudo echo 'neofetch' >> .bashrc
sudo snap install microk8s --classic --channel=latest/edge/ha-preview 
sudo snap install kompose 
sudo usermod -a -G microk8s ubuntu 
sudo chown -f -R ubuntu ~/.kube 
#If Ubuntu Change SystemD Resolved DNS port
sudo systemctl stop systemd-resolved
sudo nano /etc/systemd/resolved.conf
#Uncomment out DNS and put DNS server then change DNSSubListener to yes
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo reboot 
microk8s.add-node  
microk8s.enable metallb dns metrics-server prometheus
git clone https://github.com/prometheus-operator/kube-prometheus.git
mv kube-prometheus /var/snap/2212/
microk8s.kubectl config set-context --current --namespace=kube-system
sudo echo 'microk8s.kubectl config set-context --current --namespace=kube-system' >> .bashrc

## Test ##
wget https://github.com/charmed-kubernetes/metallb-operator/blob/master/docs/example-microbot-lb.yaml 
microk8s.kubectl apply -f ./docs/example-microbot-lb.yaml 
microk8s.kubectl delete example-microbot 

##Apps## 
microk8s.kubectl create deployment cloudflare --image=oznu/cloudflare-ddns -o yaml --dry-run=client > oznu/cloudflare.yaml
microk8s.kubectl create deployment adblock --image adguard/adguardhome -o yaml --dry-run=client > adguard.yaml
microk8s.kubectl create deployment wow --image azerothcore2/server -o yaml --dry-run=client > wow.yaml
microk8s.kubectl create deployment minecraft --image itzg/minecraft-bedrock-server -o yaml --dry-run=client > minecraft.yaml
microk8s.kubectl create deployment plex --image plexinc/pms-docker -o yaml --dry-run=client > plex.yaml
microk8s.kubectl create deployment letsencrypt --image=adferrand/dnsrobocert -o yaml --dry-run=client > letsencrypt.yaml

##Commands## 
microk8s.status 
microk8s.kubectl get nodes 
microk8s.kubectl get all -A 
microk8s config 
kompose convert 
microk8s.kubectl describe pods #pod

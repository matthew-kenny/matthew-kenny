#!/bin/bash
## Installation of Ubuntu Desktop and Microk8s based kubernetes ##

## Setup ##
sudo apt update | sudo apt upgrade –y
sudo touch "$HOME"/.hushlogin
echo neofetch >> .bashrc


## x11 ##
sudoedit /etc/gdm3/custom.conf
#Uncomment the line: WaylandEnable=false
sudo systemctl restart gdm3

## VNC ##
wget https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-[*]-Linux-x86.deb -O vnc.deb
sudo dpkg -i vnc.deb
sudo systemctl start vncserver-x11-serviced.service
sudo systemctl enable vncserver-x11-serviced.service

## Anydesk ##
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee -a /etc/apt/sources.list.d/anydesk-stable.list

## Programming Tools ##
sudo apt update && sudo apt install curl  ca-certificates gnupg anydesk neofetch synaptic git -y
git config --global user.name "First Second Name"
git config --global user.email "email@email.com"

## Deb Get ##
sudo apt install curl
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
sudo deb-get install 1password azure-cli code docker-desktop microsoft-edge-stable powershell plexmediaserver spotify-client teams terraform vivaldi-stable

## Snap Installs ##
sudo snap install aws-cli --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install spotify
sudo snap install termius-app
sudo snap install vlc


## Microk8s Installation ##
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
echo 'microk8s.kubectl config set-context --current --namespace=kube-system' >> .bashrc

## Microk8s Test ##
wget https://github.com/charmed-kubernetes/metallb-operator/blob/master/docs/example-microbot-lb.yaml 
microk8s.kubectl apply -f ./docs/example-microbot-lb.yaml 
microk8s.kubectl delete example-microbot 

## Microk8s Commands##
microk8s.status 
microk8s.kubectl get nodes 
microk8s.kubectl get all -A 
microk8s config 
kompose convert 
microk8s.kubectl describe pods #pod

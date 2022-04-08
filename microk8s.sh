#!/bin/bash
## Installation of Ubuntu Desktop and Microk8s based kubernetes ##

## Setup ##
# shellcheck disable=SC2129
sudo apt update | sudo apt upgrade –y
sudo touch "$HOME"/.hushlogin
sudo echo 'neofetch' >> .bashrc
wget https://downloads.vivaldi.com/stable/vivaldi-stable_[*].deb -O vivaldi.deb
sudo dpkg -i vivaldi.deb
git config --global user.name "First Second Name"
git config --global user.email "email@email.com"
sudoedit /etc/gdm3/custom.conf
#Uncomment the line: WaylandEnable=false
sudo systemctl restart gdm3
wget https://downloads.realvnc.com/download/file/vnc.files/VNC-Server-[*]-Linux-x86.deb -O vnc.deb
sudo dpkg -i vnc.deb
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
sudo echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
sudo apt update
sudo apt install curl anydesk neofetch synaptic -y
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
sudo systemctl start vncserver-x11-serviced.service
sudo systemctl enable vncserver-x11-serviced.service
sudo snap install 1paasword
sudo snap install aws-cli --classic
sudo snap install code --classic
sudo snap install fast
sudo snap install intellij-idea-ultimate --classic
sudo snap install powershell --classic
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
sudo echo 'microk8s.kubectl config set-context --current --namespace=kube-system' >> .bashrc

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

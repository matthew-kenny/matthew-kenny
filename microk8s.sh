#!/bin/bash
## Installation of Ubuntu Desktop and Microk8s based kubernetes ##

## Setup ##
# shellcheck disable=SC2129
sudo apt update | sudo apt upgrade –y
sudo touch "$HOME"/.hushlogin
sudo echo 'neofetch' >> .bashrc

## Vivaldi ##
wget https://downloads.vivaldi.com/stable/vivaldi-stable_[*].deb -O vivaldi.deb
sudo dpkg -i vivaldi.deb

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
sudo echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list

## Programming Tools ##
sudo apt update && sudo apt install curl  ca-certificates gnupg anydesk neofetch synaptic git -y
git config --global user.name "First Second Name"
git config --global user.email "email@email.com"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install terraform docker-ce-cli -y
curl https://desktop-stage.docker.com/linux/main/amd64/77103/docker-desktop.deb --output docker-desktop.deb
sudo apt install ./docker-desktop.deb

## Snap Installs ##
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

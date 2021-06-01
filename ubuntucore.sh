#!/bin/bash
## Standalone Installation of Ubuntu Core with Minecraft server and DoH DNS server  ##

$USER=USERNAME
$IPADDRESS=0.0.0.0

#Update and upgrade the OS by running 
sudo apt update | sudo apt upgrade -y 
sudo tmedatectl set-local-rtc 1 --adjust-system-clock
sudo apt install neofetch snapd

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

#DDNS Client
sudo snap install ddclient-snap

#If Ubuntu Change SystemD Resolved DNS port
sudo systemctl stop systemd-resolved
sudo nano /etc/systemd/resolved.conf
#Uncomment out DNS and put DNS server then change DNSSubListener to yes
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

#Download and Install local DNS Server 
mkdir $HOME/cloudflared
cd $HOME/cloudflared
#Pick your arch
wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-arm.deb
wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb
sudo dpkg -i cloudflared-stable-linux-arm.deb
sudo dpkg -i cloudflared-stable-linux-arm64.deb

#Add the config run DNS Server
sudo echo 'CLOUDFLARED_OPTS=--port 5053 --upstream https://1.1.1.3/dns-query --upstream https://dns-family.adguard.com/dns-query --upstream https://doh.familyshield.opendns.com/dns-query --upstream https://dns.quad9.net/dns-query' >> sudo /etc/default/cloudflared 

#Run cloudflared installer
sudo cloudflared

#Add SystemD service for DNS Server
sudo echo '[Unit]
Description=cloudflared DNS over HTTPS proxy
After=syslog.target network-online.target

[Service]
Type=simpleUser=root
EnvironmentFile=/etc/default/cloudflared
ExecStart=/usr/local/bin/cloudflared proxy-dns $CLOUDFLARED_OPTS s $CLOUDFLARED_OPTS
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target' >> /lib/systemd/system/cloudflared.service  

#Add to startup
sudo systemctl daemon-reload
sudo systemctl enable cloudflared 
sudo systemctl start cloudflared 

#Install DNS resolver
sudo apt install dnsmasq
sudo systemctl enable dnsmasq 
sudo systemctl stop dnsmasq
sudo cp /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
sudo rm /etc/dnsmasq.conf
sudo echo 'no-dhcp-interface=eth0 

cache-size=5000 

domain-needed 

bogus-priv 

dns-forward-max=500 

# resolv-file=/etc/resolv.dnsmasq 

no-poll 

server=127.0.0.1#5053 

no-resolv' >> /etc/dnsmasq.conf
sudo echo 'nameserver 127.0.0.1#5053' >> /etc/resolv.dnsmasq
sudo systemctl daemon-reload
sudo systemctl start dnsmasq 

#Download and install Java and bukket from source into its own folder
mkdir $HOME/bukket
sudo apt install default-jdk
wget -O nukkit.jar http://ci.mengcraft.com:8080/job/nukkit/lastSuccessfulBuild/artifact/target/nukkit-1.0-SNAPSHOT.jar
sudo echo "[Unit] 
Description=Nukkit Server 

After=syslog.target 

After=network.target 

 

[Service] 

Type=simple 

User=root 

#Group=nobody 

WorkingDirectory=/opt/nukkit 

ExecStart=sudo /usr/bin/java -jar /opt/nukkit/nukkit.jar 

 

[Install] 

WantedBy=multi-user.target" > /lib/systemd/system/minecraft.service 
sudo systemctl daemon-reload
sudo systemctl enable cloudflared 
sudo systemctl start cloudflared 

#If using a raspberry pi upgrade the Linux Kernal version
sudo rpi-upgrade 
sudo reboot
#Sources: 
#https://nathancatania.com/posts/pihole-dns-doh/ 
#https://medium.com/@niktrix/getting-rid-of-systemd-resolved-consuming-port-53-605f0234f32f 
#Careful of the this and make sure to just change resolve.conf not delete it. Or https://www.tecmint.com/resolve-temporary-failure-in-name-resolution/ 
#https://serverfault.com/questions/806617/configuring-systemd-service-to-run-with-root-access 
#https://medium.com/@alexellisuk/lightweight-ad-blocking-with-dnsmasq-and-raspberry-pi-665dbb3242e3 

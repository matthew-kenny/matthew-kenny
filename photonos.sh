# Photon Conf

USER=USERNAME
IPADDRESS=1.2.3.4

## Console

tdnf install unzip wget nano openjre8
rm /etc/systemd/network/99-dhcp-en.network
iptables -F
systemctl stop iptables
systemctl disable iptables
nano /etc/ssh/sshd_config
reboot

## From laptop

cat ~/.ssh/docker1_id_rsa.pub | ssh USER@IPADDRESS "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"

## SSH

tdnf upgrade
nano /etc/ssh/sshd_config
systemctl start docker
systemctl enable docker
nano /etc/systemd/timesyncd.conf
timedatectl set-ntp true
timedatectl set-timezone "Europe/London"
exit

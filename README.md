# Public Repo
List of my automation stuff scipts (kuberneties, powershell, bash and cloud-init)

# Windows Client Software Install 
Install Windows 10 then install chocolatey using the following in powershell:

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

[Chocolatey Programs to Install VS 2019 and VS Code](https://raw.githubusercontent.com/matthew-kenny/public/main/chocoprograms.ps1)

# Linux Standalone Server Software Install 
[Deb based (Ubuntu, Raspberry PI, Debian) Server Shell script to install Neofetch, DoH DNS Server and Minecraft Server](https://raw.githubusercontent.com/matthew-kenny/public/main/linuxserverinstall.sh)

# Linux Kuberneties Server Install
[Deb based (Ubuntu) Server Shell script to install Microk8s in High Availablity](https://raw.githubusercontent.com/matthew-kenny/public/main/Kubernetes.sh)

# Linux Cloud JSON Cloud-Init Install
[Azure Ubuntu based VM JSON Install script Shell script to install Neofetch, DoH DNS Server and Minecraft Server](https://raw.githubusercontent.com/matthew-kenny/public/main/linuxcloud-init.json)

#Requires -RunAsAdministrator
## Installs and updates recomended applications in powershell for Windows 10 ##

## Installs Chocolatey ##
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Disable confimation for installing apps ##
choco feature enable -n allowGlobalConfirmation
## Installs Base Programs ##
choco install microsoft-edge /
7zip.install /
powershell-core /
anydesk.install /
dotnetfx /
adobereader /
notepadplusplus.install /
office365business /
microsoft-teams.install /
termius /
nano /
wget /
winfetch --pre --version 2.2.0

## Installs Programming Tools ##
openssl.light /
azure-pipelines-agent /
dotnetcore-sdk /
visualstudio2019community /
visualstudio2019-workload-netcoretools /
visualstudio2019testagent /
sonarscanner-msbuild-netcoreapp30 /
visualstudio2019-workload-azurebuildtools /
visualstudio2019-workload-node /
vscode.install /
kubernetes-kompose /
awscli /
azure-cli /
terraform /
microsoftazurestorageexplorer /
vmware-workloadmanagement /
vmrc /
octant /
git.install /
git-cola  /

## Installs Kubernetes Tools ##
kubernetes-cli /
docker-desktop /
lens /

## Upgrade Software ##
choco upgrade all

## Powershell modules ##
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Az  -Repository PSGallery -Force
Install-Module -Name AWSPowerShell.NetCore -Repository PSGallery -Force
Install-Module -Name VMware.PowerCLI -Repository PSGallery -Force

#Requires -RunAsAdministrator
## Installs and updates recomended applications in powershell for Windows 10 and 11 ##

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
microsoft-teams.install /
termius /
nano /
wget /
winfetch /

## Installs Programming Tools ##
openssl.light /
vscode.install /
awscli /
azure-cli /
terraform /
microsoftazurestorageexplorer /
git.install /
docker-cli /
smimesign /

## VS Full Client ##
azure-pipelines-agent /
dotnetcore-sdk /
visualstudio2019community /
visualstudio2019-workload-netcoretools /
visualstudio2019testagent /
sonarscanner-msbuild-netcoreapp30 /
visualstudio2019-workload-azurebuildtools /
visualstudio2019-workload-node /

## Upgrade Software ##
choco upgrade all

## Powershell modules ##
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Az  -Repository PSGallery -Force
Install-Module -Name AWSPowerShell.NetCore -Repository PSGallery -Force
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Update-Module
Install-Package -Name Docker -ProviderName DockerMsftProvider -Update -Force
Start-Service Docker
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

#Requires -RunAsAdministrator
## Installs and updates recomended applications in powershell for Windows 10 and 11 ##

## Installs Chocolatey ##
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Disable confimation for installing apps ##
choco feature enable -n allowGlobalConfirmation
choco install Containers Microsoft-Hyper-V --source windowsfeatures

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
docker-engine /
visualstudio2022enterprise /

## Upgrade Software ##
choco upgrade all

## Powershell modules ##
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Az  -Repository PSGallery -Force
Update-Module
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

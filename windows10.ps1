#Requires -RunAsAdministrator
## Installs and updates recommended applications in powershell for Windows 10 and 11 ##

## Installs Chocolatey ##
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Disable confirmation for installing apps ##
choco feature enable -n allowGlobalConfirmation

## Install Container System and enable OpenSSH ##
choco install Containers Microsoft-Hyper-V --source windowsfeatures
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force
mkdir %username%\Documents\PowerShell
nano %username%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
winfetch
ssh-keygen -t ed25519
cat %username%\.ssh\id_ed25519
cat %username%\.ssh\id_ed25519.pub
cp %username%\.ssh\id_ed25519.pub C:\ProgramData\ssh\administrators_authorized_keys
icacls.exe "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"

## Installs Base Programs ##
choco install microsoft-edge 7zip.install powershell-core anydesk.install dotnetfx adobereader notepadplusplus.install microsoft-teams.install termius nano wget  winfetch

## Installs Programming Tools ##
choco install openssl.light vscode.install awscli azure-cli terraform microsoftazurestorageexplorer git.install docker-cli docker-engine visualstudio2022enterprise

## Upgrade Software ##
choco upgrade all

## Powershell modules ##
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Az  -Repository PSGallery -Force
Update-Module
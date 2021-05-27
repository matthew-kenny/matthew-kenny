#Requires -RunAsAdministrator
## Installs and updates applications in powershell for Windows 10 ##

## Installs Chocolatey ##
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

## Installs Base Programs ##
choco install microsoft-edge /
7zip.install /
powershell-core /
teamviewer /
dotnetfx /
adobereader /
notepadplusplus.install /
office365business /
microsoft-teams.install /
termius /

## Installs Programming Tools ##
choco install wget
dotnetcore-sdk /
visualstudio2019community /
visualstudio2019-workload-netcoretools /
visualstudio2019testagent /
sonarscanner-msbuild-netcoreapp30 /
visualstudio2019-workload-azurebuildtools /
visualstudio2019-workload-node /
vscode.install /
vscode-powershell /
vscode-pull-request-github /
vscode-azure-deploy /
vscode-kubernetes-tools /
awscli /
azure-cli /
microsoftazurestorageexplorer /
az.powershell /
awstools.powershell /
vmware-powercli-psmodule /
git.install /
git-cola  /

## Installs Kubernetes Tools ##
kubernetes-cli /
docker-desktop /
lens /

## Parameters ##
-y

## Upgrade Software ##
choco upgrade all -y

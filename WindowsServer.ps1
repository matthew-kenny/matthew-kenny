oSet-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install Containers Microsoft-Hyper-V --source windowsfeatures
choco install nano wget powershell-core winfetch adguardhome nssm anydesk.install docker-desktop microsoft-windows-terminal
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force
cd Documents
mkdir PowerShell
cd PowerShell
nano Microsoft.PowerShell_profile.ps1
winfetch
ssh-keygen -t ed25519
cd .ssh
cat .\id_ed25519
cat .\id_ed25519.pub
cp id_ed25519.pub C:\ProgramData\ssh\administrators_authorized_keys
icacls.exe "C:\ProgramData\ssh\administrators_authorized_keys" /inheritance:r /grant "Administrators:F" /grant "SYSTEM:F"
New-NetFirewallRule -DisplayName AdGuard -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('53', '80', '443', '3000')
New-NetFirewallRule -DisplayName AdGuard2 -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol UDP -LocalPort @('53')
New-NetFirewallRule -DisplayName "Allow Messenger" -Direction Inbound -Program "C:\Program Files\Docker\Docker\resources\com.docker.backend.exe" -Action Allow
nssm.exe install adguardhome
nssm.exe install docker

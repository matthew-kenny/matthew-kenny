Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install nano wget powershell-core winfetch adguardhome nssm anydesk.install
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
New-NetFirewallRule -DisplayName AdGuard2 -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol UPD -LocalPort @('53')
cd 'C:\Program Files (x86)\Autodesk'
nssm.exe install adguardhome

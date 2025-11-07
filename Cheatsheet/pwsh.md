1. Get Directory Separator
```pwsh
[System.IO.Path]::DirectorySeparatorChar
```
2. Get Definition of Function named func
```
$Function:func
${Funtion:func-tion}
# Or :
(Get-Command help).Definition
```
3. Find and kill a process
```pwsh
Get-Process notepad | Stop-Process
```
4. Sort process
```
Get-Process | Sort-Object -Property handles
```
5. Manage Predictive IntelliSense
```pwsh
Get-PSReadLineOption | Select-Object -Property PredictionSource
Set-PSReadLineOption -PredictionSource Plugin
```
6. List npm installed packages
```
npm list -g --depth=0
```
7. Get Ports name
```pwsh
[System.IO.Ports.SerialPort]::getportnames()
```
8. What key ?
```pwsh
[System.Console]::ReadKey()
```
9. Env
```pwsh
[System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Machine)
[System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::User)
```

10. [Firewall](https://stackoverflow.com/a/73690504/15075323)
```
Set-NetFirewallHyperVVMSetting -Name ((Get-NetFirewallHyperVVMCreator).VMCreatorId) -Enabled False
```
or
```
New-NetFirewallHyperVRule `
-DisplayName 'Allow All Inbound Traffic to WSL in Private Network' `
-Name 'WSL Rule' `
-Profiles Private `
-Direction Inbound `
-Action Allow `
-VMCreatorId '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' `
-Enabled True
```
check
```
Get-NetFirewallHyperVRule -Name 'WSL Rule'
```
delete
```
Remove-NetFirewallHyperVRule -Name 'WSL Rule'
```

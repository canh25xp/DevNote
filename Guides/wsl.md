1. Check your available disk space
```cmd
wsl --system -d <distribution-name> df -h /mnt/wslg/distro
```

https://learn.microsoft.com/en-us/windows/wsl/disk-space

2. Locate the .vhdx file and disk path for your Linux distribution
```powershell
(Get-ChildItem -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | Where-Object { $_.GetValue("DistributionName") -eq '<distribution-name>' }).GetValue("BasePath") + "\ext4.vhdx"
```
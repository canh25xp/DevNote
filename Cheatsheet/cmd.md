## Tips and Tricks
1. Using ">" to redirect output to file
2. Using ">>" to redirect and append to file
```
echo Hello Rachel > hello.txt
echo I'm Michael >> hello.txt
```

## Reg edit
1. legacy context menu (win10)
```
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```
2. Restore Modern Context menus in (Win11)
```
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
```
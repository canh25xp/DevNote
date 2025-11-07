1. Find package location

```bash
dpkg -L package-name
```
2. update and upgrade packages

```bash
sudo apt update && sudo apt upgrade -y
```
-y flag to automatically "yes" during installation
3. install multiple package

```bash
sudo apt install tree treil
```
4. Remove package

```bash
sudo apt remove tree # keep config files
sudo apt purge tree # remove config files
```
5. Show package info

```bash
apt show tree
```
6. List Installed and Upgradable Packages

```bash
sudo apt list --upgradable
sudo apt list --installed
sudo apt list --all-versions
```
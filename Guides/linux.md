---
id: linux
aliases: []
tags:
  - unix
  - bash
---

# Linux

## Add new user

To create new user with password and sudo privilege then change default shell to bash:

```sh
apt update && apt upgrade && apt install sudo
useradd -m username
passwd username
usermod -aG sudo username
usermod --shell /bin/bash username
su - username
```

A simpler way:

```sh
apt update && apt upgrade && apt install adduser sudo
adduser username
usermod -aG sudo username
su - username
```

## Type password without display to the terminal nor save to bash history file

```bash
read -s -p "Enter P4 password: " P4PASSWD
```

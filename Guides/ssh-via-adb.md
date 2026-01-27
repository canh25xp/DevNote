---
id: ssh-via-adb
aliases: []
tags:
  - ssh
  - adb
  - termux
  - android
---

# `ssh` via `adb`

## Prerequisites

You would need

- In the your PC: `adb`
- In the Android device: termux
- In both device: `ssh` (Depends on which device connect to which, you would need openssh-server either openssh-client)

## From PC to android

- On android device

```sh
pkg install openssh # install openssh
sshd # start OpenSSH daemon on port 8022
whoami # remember this username
passwd # setup password that later use to connect
```

- On PC

```sh
adb forward tcp:10022 tcp:8022
ssh u0_a343@localhost -p 10022
```

Where `u0_a343` is the `username` (find out by running `whoami`)

When ask `Are you sure you want to continue connecting (yes/no/[fingerprint])?`

Choose `yes` and then type in the client password

To stop shh tunnel

```sh
pkill sshd # on Android
adb forward --remove tcp:10022 # on PC
```

Tips: Launch termux using [[adb]]

```sh
adb shell am start -n com.termux/.HomeActivity
```

## From android to PC

- On PC

```sh
sudo apt install openssh-server
sudo systemctl start ssh.service # this start openssh daemon on port 22
adb reverse tcp:10022 tcp:22
```

- On android

```sh
ssh vancanh-ng@localhost -p 10022
```

Stop ssh runnel

```sh
sudo systemctl start ssh.service # on PC
adb reverse --remove tcp:10022 # on PC
```

## References

- https://wiki.termux.com/wiki/Remote_Access
- https://glow.li/posts/access-termux-via-usb/

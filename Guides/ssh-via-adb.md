---
id: ssh-via-adb
aliases: []
tags:
  - ssh
  - adb
  - termux
  - android
---

# SSH via ADB

This guide explains how to establish SSH connections between your PC and an Android device using ADB (Android Debug Bridge) and Termux.
This method is useful for remote access to your Android device without requiring root access or Wi-Fi.

## Prerequisites

You will need:

- On your PC: `adb`
- On the Android device: Termux
- On both devices: `ssh` (Depending on which device connects to which, you'll need either openssh-server or openssh-client)

## From PC to Android

- On the Android device:

```sh
pkg install openssh  # Install OpenSSH
sshd                 # Start the OpenSSH daemon on port 8022
whoami               # Remember this username
passwd               # Set up a password for later connection
```

- On your PC:

```sh
adb forward tcp:10022 tcp:8022
ssh u0_a343@localhost -p 10022
```

> Replace `u0_a343` with the username you obtained by running `whoami` on your Android device.

When prompted with `Are you sure you want to continue connecting (yes/no/[fingerprint])?`, type `yes` and then enter the password you set earlier.

To stop the SSH tunnel

```sh
pkill sshd # on Android
adb forward --remove tcp:10022 # on PC
```

### Tips: Launch Termux using ADB

You can launch Termux directly from your PC using ADB:

```sh
adb shell am start -n com.termux/.HomeActivity
```

## From Android to PC

- On your PC:

```sh
sudo apt install openssh-server
sudo systemctl start ssh.service  # Start the OpenSSH daemon on port 22
adb reverse tcp:10022 tcp:22      # Forward traffic from Android to PC
```

- On the Android device:

```sh
ssh vancanh-ng@localhost -p 10022
```

> Replace `vancanh-ng` with your actual username on the PC.

Stop the SSH tunnel

```sh
sudo systemctl stop ssh.service # on PC
adb reverse --remove tcp:10022 # on PC
```

## References

- https://wiki.termux.com/wiki/Remote_Access
- https://glow.li/posts/access-termux-via-usb/

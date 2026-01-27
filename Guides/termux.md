---
id: termux
aliases: []
tags:
  - android
  - termux
---

# Termux

## Install Termux on the device

- Install via F-DROID

```sh
curl -LO https://f-droid.org/F-Droid.apk
adb install F-DROID.apk
```

- Open F-DROID to download and install Termux

- Initial setup

```sh
pkg update && pkg upgrade -y
```

- Get permission : Go to `Settings` -> `Apps` -> `Termux` -> `Permissions` -> `Files and media` `Allow`

## Connect to [[ssh-via-adb|`ssh` via `adb`]]

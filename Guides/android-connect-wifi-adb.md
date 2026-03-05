---
id: android-connect-wifi-adb
aliases: []
tags: []
---

# Android connect to Wi-Fi manually via `adb`

This article describe the process of connecting to Wi-Fi via `adb` using service helper command `cmd wifi`

## First enter adb shell

```sh
adb shell
cmd wifi help
```

## Enable Wi-Fi

```sh
cmd wifi set-wifi-enabled enabled

```

## Check saved/connected network

```sh
cmd wifi list-networks
```

## Scan Wi-Fi

```sh
start-scan # optionally force a new scan
list-scan-results
```

## Connect network

```sh
# Connect to an opened, hidden network (-h flag)
cmd wifi connect-network "Samsung_R&D_Center_WIFI_TG_5G" open -h

# Connect to a hidden wpa2 network
cmd wifi connect-network "Samsung_R&D_Center_WIFI_TG_2G" wpa2 "********"
```

## Check status

```sh
cmd wifi status
```

## Forget network

```sh
# Use list-networks to retrieve <networkId> for the network
forget-network 0
```

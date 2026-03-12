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

```console
$ cmd wifi status
Wifi is enabled
Wifi scanning is only available when wifi is enabled
==== Primary ClientModeManager instance ====
Wifi is connected to "Samsung_R&D_Center_WIFI_TG_2G"
WifiInfo: SSID: "Samsung_R&D_Center_WIFI_TG_2G", BSSID: 44:a5:6e:3e:45:e2, MAC: da:ae:6c:5d:de:20, IP: /192.168.1.107, Security type: 4, Supplicant state: COMPLETED, Wi-Fi standard: legacy, RSSI: -16, Link speed: -1Mbps, Tx Link speed: -1Mbps, Max Supported Tx Link speed: 54Mbps, Rx Link speed: -1Mbps, Max Supported Rx Link speed: 54Mbps, Frequency: 2437MHz, Net ID: 0, Metered hint: false, score: 60, isUsable: true, CarrierMerged: false, SubscriptionId: -1, IsPrimary: 1, Trusted: true, Restricted: false, Ephemeral: false, OEM paid: false, OEM private: false, OSU AP: false, FQDN: <none>, Provider friendly name: <none>, Requesting package name: <none>"Samsung_R&D_Center_WIFI_TG_2G"wpa3-saeMLO Information: , Is TID-To-Link negotiation supported by the AP: false, AP MLD Address: <none>, AP MLO Link Id: <none>, AP MLO Affiliated links: <none>, Vendor Data: <none>
successfulTxPackets: 3
successfulTxPacketsPerSecond: 0.9897374855767056
retriedTxPackets: 0
retriedTxPacketsPerSecond: 0.0
lostTxPackets: 0
lostTxPacketsPerSecond: 0.0
successfulRxPackets: 1
successfulRxPacketsPerSecond: 0.3299124951922352

$ ip a show wlan0
53: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 3000
    link/ether da:ae:6c:5d:de:20 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.107/24 brd 192.168.1.255 scope global wlan0
       valid_lft forever preferred_lft forever
    inet6 fdb4:b9e8:9cf:0:41fb:de8d:dbd4:f71f/64 scope global temporary dynamic
       valid_lft 5319sec preferred_lft 2619sec
    inet6 fdb4:b9e8:9cf:0:d8ae:6cff:fe5d:de20/64 scope global dynamic mngtmpaddr
       valid_lft 5319sec preferred_lft 2619sec
    inet6 fe80::d8ae:6cff:fe5d:de20/64 scope link
       valid_lft forever preferred_lft forever

$ ip route
192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.107

$ ip route show table all
default via 192.168.1.1 dev wlan0 table 1053 proto static
192.168.1.0/24 dev wlan0 table 1053 proto static scope link
192.168.1.0/24 dev wlan0 table 1000000053 proto static scope link
224.0.0.0/24 dev wlan0 table 1000000053 proto static scope link
default dev dummy0 table 1002 proto static scope link
192.168.1.0/24 dev wlan0 proto kernel scope link src 192.168.1.107
local 127.0.0.0/8 dev lo table local proto kernel scope host src 127.0.0.1
local 127.0.0.1 dev lo table local proto kernel scope host src 127.0.0.1
broadcast 127.255.255.255 dev lo table local proto kernel scope link src 127.0.0.1
local 192.168.1.107 dev wlan0 table local proto kernel scope host src 192.168.1.107
broadcast 192.168.1.255 dev wlan0 table local proto kernel scope link src 192.168.1.107
fdb4:b9e8:9cf::/64 dev wlan0 table 1053 proto kernel metric 256 expires 5339sec pref medium
fdb4:b9e8:9cf::/64 dev wlan0 table 1053 proto static metric 1024 pref medium
fdb4:b9e8:9cf::/48 via fe80::46a5:6eff:fe3e:45de dev wlan0 table 1053 proto ra metric 1024 expires 5339sec pref medium
fe80::/64 dev wlan0 table 1053 proto kernel metric 256 pref medium
fe80::/64 dev wlan0 table 1053 proto static metric 1024 pref medium
fdb4:b9e8:9cf::/64 dev wlan0 table 1000000053 proto static metric 1024 pref medium
fe80::/64 dev wlan0 table 1000000053 proto static metric 1024 pref medium
fe80::/64 dev dummy0 table 1002 proto kernel metric 256 pref medium
default dev dummy0 table 1002 proto static metric 1024 pref medium
local ::1 dev lo table local proto kernel metric 0 pref medium
local fdb4:b9e8:9cf:0:41fb:de8d:dbd4:f71f dev wlan0 table local proto kernel metric 0 pref medium
local fdb4:b9e8:9cf:0:d8ae:6cff:fe5d:de20 dev wlan0 table local proto kernel metric 0 pref medium
local fe80::43c:ceff:fe35:68e2 dev dummy0 table local proto kernel metric 0 pref medium
local fe80::d8ae:6cff:fe5d:de20 dev wlan0 table local proto kernel metric 0 pref medium
multicast ff00::/8 dev dummy0 table local proto kernel metric 256 pref medium
multicast ff00::/8 dev wlan0 table local proto kernel metric 256 pref medium
```

## Forget network

```sh
# Use list-networks to retrieve <networkId> for the network
forget-network 0
```

---
id: android-connect-wifi-manually
aliases: []
tags:
  - android
  - wifi
  - wpa_supplicant
  - adb
  - dhcp
---

# Android connect to Wi-Fi manually via `wpa_supplicant`

In this article, I'm going to attempt to connect to Wi-Fi from an android device manually.
That is, without touching the Android Application or Framework layer.

The goal is simple, using only the CLI tools available in `adb shell`, I should be able to connect to Wi-Fi, have internet access and be able to ping `https://example.com/`.
Since after all, android is just another linux machine.

I shall not cheating with the command like `adb shell svc wifi enable`.

For the test subject, I'm going to use the Galaxy A15 (SM-A155F) phone,
but this should be the same for any android phone really.
It does need to be running **userdebug** or **eng** to access root.

- Android version   : 16
- OneUI             : 8.0
- Baseband version  : `A155FXXU7DYK1`
- Build id (merge)  : 103381752
- Build id (vendor) : 103381775
- Build id (system) : 103381774

## Detailed steps

### Open shell as root

```bash
adb root
adb shell
```

### Turn off Wi-Fi from framework

```sh
svc wifi disable
ps -Af -u wifi
```

You should **NOT** be able to see `wpa_supplicant` running like below

```console
root@a15:/sdcard$ ps -Af -u wifi
UID            PID  PPID C STIME TTY          TIME CMD
wifi          1138     1 0 00:46 ?        00:00:00 vendor.samsung.hardware.wifi-service
wifi          1317     1 0 00:48 ?        00:00:00 wlan_assistant
wifi          1361     1 0 00:48 ?        00:00:01 wificond
wifi          2111     1 0 00:58 ?        00:00:00 android.hardware.wifi-service-lazy
wifi         20580     1 3 50:02 ?        00:00:00 wpa_supplicant -O/data/vendor/wifi/wpa/sockets -dd -g@android:wpa_wlan0
```

### Manually start `wpa_supplicant`

Run `wpa_supplicant` daemon in background

```
/vendor/bin/hw/wpa_supplicant -iwlan0 -Dnl80211 -dd -B -O/data/vendor/wifi/wpa/sockets -c/data/vendor/wifi/wpa/wpa_supplicant.conf -I/vendor/etc/wifi/wpa_supplicant_overlay.conf
```

parameter explain:

- `-iwlan0`: using wlan0 interface
- `-Dnl80211`: using nl8022 driver
- `-dd`: increase debugging verbosity
- `-B`: run daemon in the background
- `-O/data/vendor/wifi/wpa/sockets`: override ctrl_interface parameter for new interfaces
- `-I/vendor/etc/wifi/wpa_supplicant_overlay.conf`: additional configuration file

### Connect to network using `wpa_cli` interactively

```
wpa_cli
> add_network 0
> set_network 0 ssid "wifiname"
> set_network 0 key_mgmt WPA-PSK FT-PSK WPA-PSK-SHA256
> set_network 0 ieee80211w 3
> set_network 0 proto WPA RSN
> set_network 0 group CCMP TKIP
> set_network 0 pairwise CCMP TKIP
> set_network 0 psk "password"
> enable_network 0
> select_network 0
> status
> save config
> quit
```

### Kill `wpa_supplicant`

Kill the `wpa_supplicant` process, otherwise device will not be able to turn on Wi-Fi

Additionally, remove the config file so device can override this file later

```bash
pkill -f wpa_supplicant
rm /data/vendor/wifi/wpa/wpa_supplicant.conf
```

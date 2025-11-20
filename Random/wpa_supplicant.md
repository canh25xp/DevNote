# Wi-Fi connect using command line via `wpa_supplicant` and `wpa_cli`

## Open shell as root

```bash
adb root
adb shell
cd /vendor/bin/hw
```

Make sure to turn off device's Wi-Fi

```bash
ps -Af -u wifi
```

You should NOT see `wpa_supplicant` running as below

```
UID            PID  PPID C STIME TTY          TIME CMD
wifi           374     1 0 27:11 ?        00:00:00 wlbtd
wifi           656     1 0 27:14 ?        00:00:01 android.hardware.wifi-service
wifi           687     1 0 27:14 ?        00:00:00 vendor.samsung.hardware.wifi-service
wifi           833     1 0 27:15 ?        00:00:03 wificond
wifi         16827     1 1 26:34 ?        00:00:00 wpa_supplicant -O/data/vendor/wifi/wpa/sockets -dd -g@android:wpa_wlan0
```

Run `wpa_supplicant` daemon in background

```
./wpa_supplicant -iwlan0 -Dnl80211 -dd -B -O/data/vendor/wifi/wpa/sockets -c/data/vendor/wifi/wpa/wpa_supplicant.conf -I/vendor/etc/wifi/wpa_supplicant_overlay.conf
```

parameter explain:

- `-iwlan0`: using wlan0 interface
- `-Dnl80211`: using nl8022 driver
- `-dd`: increase debugging verbosity
- `-B`: run daemon in the background
- `-O/data/vendor/wifi/wpa/sockets`: override ctrl_interface parameter for new interfaces
- `-I/vendor/etc/wifi/wpa_supplicant_overlay.conf`: additional configuration file

## Connect to network using `wpa_cli` interactively

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

## Kill `wpa_supplicant`

Kill the `wpa_supplicant` process, otherwise device will not be able to turn on Wi-Fi

Additionally, remove the config file so device can override this file later

```bash
pkill -f wpa_supplicant
rm /data/vendor/wifi/wpa/wpa_supplicant.conf
```


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

I shall not cheating with the `cmd` service helper command like described in [[android-connect-to-wi-fi-manually-via-adb]].

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

### Find interface to use

List all physical and logical wireless network interfaces:

```sh
iw dev
```

Look for something like `wlan0`

```console
root@a15:/sdcard$ iw dev
phy#0
        Interface p2p1
                ifindex 57
                wdev 0x5
                addr 6e:ac:c2:af:cb:7c
                type P2P-client
        Interface p2p0
                ifindex 56
                wdev 0x4
                addr 6e:ac:c2:af:cb:7d
                type P2P-client
        Interface wlan0
                ifindex 53
                wdev 0x1
                addr 92:9c:72:86:bb:7f
                type managed
```

Check interface

```sh
ip a show wlan0
```

```console
root@a15:/sdcard$ ip a show wlan0
53: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 3000
    link/ether 92:9c:72:86:bb:7f brd ff:ff:ff:ff:ff:ff
```

### Start `wpa_supplicant`

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
- `-c/data/vendor/wifi/wpa/wpa_supplicant.conf`: configuration file
- `-I/vendor/etc/wifi/wpa_supplicant_overlay.conf`: additional configuration file

Check supplicant config

```console
root@a15:/sdcard$ cat /data/vendor/wifi/wpa/wpa_supplicant.conf
update_config=1
eapol_version=1
ap_scan=1
fast_reauth=1
pmf=1
p2p_add_cli_chan=1
oce=1
sae_pwe=2
dot11RSNAConfigPMKLifetime=259200
p2p_optimize_listen_chan=1
wowlan_disconnect_on_deinit=1
rsn_overriding=1
root@a15:/sdcard$ cat /vendor/etc/wifi/wpa_supplicant_overlay.conf
p2p_disabled=1
update_config=1
pmf=1
wowlan_triggers=disconnect
bss_no_flush_when_down=1
interworking=1
hs20=1
#PMK Lifetime value 259200 = 72 hours
dot11RSNAConfigPMKLifetime=259200
```

### Connect to network using `wpa_cli` interactively

```
wpa_cli
> scan
> scan_results
> add_network
> set_network 0 ssid "Direct-test"
> set_network 0 psk "********"
> enable_network 0
> select_network 0
> save config
> quit
```
At this point, device has successfully authenticated with the AP, but device haven't got assigned an IP yet.

```console
root@a15:/sdcard$ wpa_cli status
Using interface 'wlan0'
bssid=32:74:67:2a:ea:31
freq=2462
ssid=Direct-test
id=0
mode=station
wifi_generation=4
pairwise_cipher=CCMP
group_cipher=CCMP
key_mgmt=WPA2-PSK
wpa_state=COMPLETED
address=aa:9b:81:39:bd:66
uuid=98bcf60e-908c-5d03-9fa1-ff81e83de0a2
root@a15:/sdcard$ ip a show wlan0
53: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 3000
    link/ether 92:9c:72:86:bb:7f brd ff:ff:ff:ff:ff:ff
```

So next step, we're gonna manually request an IP address for device using `dhcp`

### DHCP

Run DHCP client to obtains IP.

```sh
toybox dhcp -i wlan0 -f -v
# Try ad `-B` if not success
```

```console
root@a15:/sdcard$ toybox dhcp -i wlan0 -f -v
dhcp started
Adapter index 53
MAC aa:9b:81:39:bd:66
Opening raw socket on ifindex 53
Got raw socket fd 5
MODE RAW : success
select wait ....
Adapter index 53
MAC aa:9b:81:39:bd:66
Sending discover...
select wait ....
main sock read
Opening raw socket on ifindex 53
Got raw socket fd 5
MODE RAW : success
select wait ....
Adapter index 53
MAC aa:9b:81:39:bd:66
Sending select for 192.168.169.34...
select wait ....
main sock read
Lease of 192.168.169.34 obtained, lease time 3599 from server 192.168.169.67
select wait ....
```

Client successfully obtained Ip "192.168.169.34" from server "192.168.169.67"

Config DHCP for client

```sh
ip addr add 192.168.169.34/24 dev wlan0
ip route add default via 192.168.169.67 dev wlan0
```

```console
root@a15:/sdcard$ ip addr add 192.168.169.34/24 dev wlan0
53: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 3000
    link/ether aa:9b:81:39:bd:66 brd ff:ff:ff:ff:ff:ff
    inet 192.168.169.34/24 scope global wlan0
       valid_lft forever preferred_lft forever

root@a15:/sdcard$ ip route add default via 192.168.169.67 dev wlan0
RTNETLINK answers: Network is unreachable
```

At this point, I'm kinda stuck

### Kill `wpa_supplicant`

Kill the `wpa_supplicant` process, otherwise device will not be able to turn on Wi-Fi

Additionally, remove the config file so device can override this file later

```bash
pkill -f wpa_supplicant
rm /data/vendor/wifi/wpa/wpa_supplicant.conf
```

## Appendixes

### `wpa_supplicant`

```sh
/vendor/bin/hw/wpa_supplicant --help
```

```help
wpa_supplicant v2.12-devel-16
Copyright (c) 2003-2024, Jouni Malinen <j@w1.fi> and contributors

This software may be distributed under the terms of the BSD license.
See README for more details.

This product includes software developed by the OpenSSL Project
for use in the OpenSSL Toolkit (http://www.openssl.org/)

usage:
  wpa_supplicant [-BddhKLqqtvW] [-P<pid file>] [-g<global ctrl>] \
        [-G<group>] \
        -i<ifname> -c<config file> [-C<ctrl>] [-D<driver>] [-p<driver_param>] \
        [-b<br_ifname>] [-e<entropy file>] \
        [-o<override driver>] [-O<override ctrl>] \
        [-N -i<ifname> -c<conf> [-C<ctrl>] [-D<driver>] \
        [-m<P2P Device config file>] \
        [-p<driver_param>] [-b<br_ifname>] [-I<config file>] ...]

drivers:
  nl80211 = Linux nl80211/cfg80211
options:
  -b = optional bridge interface name
  -B = run daemon in the background
  -c = Configuration file
  -C = ctrl_interface parameter (only used if -c is not)
  -d = increase debugging verbosity (-dd even more)
  -D = driver name (can be multiple drivers: nl80211,wext)
  -e = entropy file
  -g = global ctrl_interface
  -G = global ctrl_interface group
  -h = show this help text
  -i = interface name
  -I = additional configuration file
  -K = include keys (passwords, etc.) in debug output
  -L = show license (BSD)
  -m = Configuration file for the P2P Device interface
  -N = start describing new interface
  -o = override driver parameter for new interfaces
  -O = override ctrl_interface parameter for new interfaces
  -p = driver parameters
  -P = PID file
  -q = decrease debugging verbosity (-qq even less)
  -t = include timestamp in debug messages
  -v = show version
  -W = wait for a control interface monitor before starting
example:
  wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant.conf
```

### `wpa_supplicant.conf`

```toml
# /data/vendor/wifi/wpa/wpa_supplicant.conf
update_config=1
eapol_version=1
ap_scan=1
fast_reauth=1
pmf=1
p2p_add_cli_chan=1
oce=1
sae_pwe=2
dot11RSNAConfigPMKLifetime=259200
p2p_optimize_listen_chan=1
wowlan_disconnect_on_deinit=1
rsn_overriding=1
```

### `wpa_supplicant_overlay.conf`

```toml
# /vendor/etc/wifi/wpa_supplicant_overlay.conf
p2p_disabled=1
update_config=1
pmf=1
wowlan_triggers=disconnect
bss_no_flush_when_down=1
interworking=1
hs20=1
#PMK Lifetime value 259200 = 72 hours
dot11RSNAConfigPMKLifetime=259200
```

### `dhcp`

```sh
toybox dhcp --help
```

```help
toybox dhcp --help
Toybox 0.8.12-android multicall binary (see toybox --help)

usage: dhcp [-fbnqvoCRB] [-i IFACE] [-r IP] [-s PROG] [-p PIDFILE]
            [-H HOSTNAME] [-V VENDOR] [-x OPT:VAL] [-O OPT]

     Configure network dynamically using DHCP.

   -i Interface to use (default eth0)
   -p Create pidfile
   -s Run PROG at DHCP events (default /usr/share/dhcp/default.script)
   -B Request broadcast replies
   -t Send up to N discover packets
   -T Pause between packets (default 3 seconds)
   -A Wait N seconds after failure (default 20)
   -f Run in foreground
   -b Background if lease is not obtained
   -n Exit if lease is not obtained
   -q Exit after obtaining lease
   -R Release IP on exit
   -S Log to syslog too
   -a Use arping to validate offered address
   -O Request option OPT from server (cumulative)
   -o Don't request any options (unless -O is given)
   -r Request this IP address
   -x OPT:VAL  Include option OPT in sent packets (cumulative)
   -F Ask server to update DNS mapping for NAME
   -H Send NAME as client hostname (default none)
   -V VENDOR Vendor identifier (default 'toybox VERSION')
   -C Don't send MAC as client identifier
   -v Verbose

   Signals:
   USR1  Renew current lease
   USR2  Release current lease
```

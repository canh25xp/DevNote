---
id: route
aliases: []
tags:
  - wifi
  - lan
  - nmcli
---

# Ip route

Goal: Using Wi-Fi for Internet access and only using LAN for local network.

| Interface      | Role          | Routing behavior                      |
| -------------- | ------------- | ------------------------------------- |
| `wlo1` (Wi-Fi) | Internet      | Default route (0.0.0.0/0)             |
| `enp3s0` (LAN) | Local network | Only 192.168.1.0/24 and 107.98.0.0/16 |

## Step 1. Make Wi-Fi prioritize

```console
$ ip route
default via 192.168.1.1 dev enp3s0 proto dhcp src 192.168.1.122 metric 100
default via 10.67.74.185 dev wlo1 proto dhcp src 10.67.74.101 metric 600
10.67.74.0/24 dev wlo1 proto kernel scope link src 10.67.74.101 metric 600
192.168.1.0/24 dev enp3s0 proto kernel scope link src 192.168.1.122 metric 100
```

### Method 1. Modify priority

```sh
# Lower the Wi-Fi metric and/or raise the LAN metric.
sudo ip route change default via 10.67.74.185 dev wlo1 metric 50
sudo ip route change default via 192.168.1.1 dev enp3s0 metric 200
# or using nmcli
nmcli connection modify <wifi-name> ipv4.route-metric 50
nmcli connection modify <lan-name> ipv4.route-metric 200
```

### Method 2. Disable LAN default route

```sh
sudo ip route del default dev enp3s0
# or using nmcli
nmcli connection modify <lan-name> ipv4.never-default yes
```

## Step 2. Manually add route for LAN

```sh
nmcli connection modify <lan-name> +ipv4.routes "107.98.0.0/16 192.168.1.1"
```

## Step 3. Reconnect

```sh
nmcli connection up <wifi-name>
nmcli connection up <lan-name>
```

Check

```sh
nmcli connection show <lan-name> | grep ipv4.never-default
nmcli connection show <lan-name> | grep ipv4.routes
```

```console
$ ip route
default via 10.67.74.185 dev wlo1 proto dhcp src 10.67.74.101 metric 50
default via 192.168.1.1 dev enp3s0 proto dhcp src 192.168.1.122 metric 100
10.67.74.0/24 dev wlo1 proto kernel scope link src 10.67.74.101 metric 50
107.98.0.0/16 via 192.168.1.1 dev enp3s0 proto static metric 100
192.168.1.0/24 dev enp3s0 proto kernel scope link src 192.168.1.122 metric 100
```

---
id: debian-connect-wifi
aliases: []
tags:
  - wifi
  - wpa_supplicant
---

# Debian Wi-Fi usage

## Manual

### Disable network services

First disable any services that currently managing network so that we can manage it ourself

```sh
sudo systemctl stop wpa_supplicant.service
sudo systemctl stop networking.service
sudo systemctl stop NetworkManager.service
```

### Check available interfaces

```sh
iw dev
```

```console
$ iw dev
phy#0
	Unnamed/non-netdev interface
		wdev 0x3
		addr 94:e6:f7:e4:bb:56
		type P2P-device
	Interface wlo1
		ifindex 3
		wdev 0x1
		addr 94:e6:f7:e4:bb:55
		type managed
		txpower 22.00 dBm
		multicast TXQ:
			qsz-byt	qsz-pkt	flows	drops	marks	overlmt	hashcol	tx-bytes	tx-packets
			0	0	0	0	0	0	0	0		0
```

Interface: wlo1
MAC address: 94:e6:f7:e4:bb:55

### Start `wpa_supplicant` as daemon

Create a minimal `wpa_supplicant` config file

```toml
# /etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
```

```sh
wpa_supplicant -Dnl80211 -dd -B -iwlo1 -c/etc/wpa_supplicant/wpa_supplicant.conf
```

```console
$ wpa_supplicant -Dnl80211 -dd -B -iwlo1 -c/etc/wpa_supplicant/wpa_supplicant.conf
wpa_supplicant v2.10
random: getrandom() support available
Successfully initialized wpa_supplicant
Initializing interface 'wlo1' conf '/etc/wpa_supplicant/wpa_supplicant.conf' driver 'nl80211' ctrl_interface 'N/A' bridge 'N/A'
Configuration file '/etc/wpa_supplicant/wpa_supplicant.conf' -> '/etc/wpa_supplicant/wpa_supplicant.conf'
Reading configuration file '/etc/wpa_supplicant/wpa_supplicant.conf'
ctrl_interface='DIR=/var/run/wpa_supplicant GROUP=netdev'
update_config=1
nl80211: TDLS supported
nl80211: TDLS external setup
nl80211: Supported cipher 00-0f-ac:1
nl80211: Supported cipher 00-0f-ac:5
nl80211: Supported cipher 00-0f-ac:2
nl80211: Supported cipher 00-0f-ac:4
nl80211: Supported cipher 00-0f-ac:8
nl80211: Supported cipher 00-0f-ac:9
nl80211: Supported cipher 00-0f-ac:6
nl80211: Supported cipher 00-0f-ac:11
nl80211: Supported cipher 00-0f-ac:12
nl80211: Using driver-based off-channel TX
nl80211: Driver-advertised extended capabilities (default) - hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities mask (default) - hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities for interface type STATION
nl80211: Extended capabilities - hexdump(len=10): 04 00 c0 00 00 00 00 c0 01 20
nl80211: Extended capabilities mask - hexdump(len=10): 04 00 c0 00 00 00 00 c0 01 20
nl80211: Use separate P2P group interface (driver advertised support)
nl80211: Enable multi-channel concurrent (driver advertised support)
nl80211: use P2P_DEVICE support
nl80211: key_mgmt=0x1ff0f enc=0x76f auth=0x7 flags=0x84800d30fb5bfbe0 rrm_flags=0x19 probe_resp_offloads=0x0 max_stations=0 max_remain_on_chan=10000 max_scan_ssids=20
nl80211: interface wlo1 in phy phy0
nl80211: Set mode ifindex 3 iftype 2 (STATION)
nl80211: Subscribe to mgmt frames with non-AP handle 0x55a4fc748ee0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0104 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=040a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=040b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=040c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=040d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=090a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=090b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=090c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=090d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0409506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=7f506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0409506f9a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0800 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0801 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=040e multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=12 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=06 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0a07 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0a11 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0a0b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=1101 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=1102 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0505 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0500 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=0502 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=1301 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=1305 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc748ee0 match=7e506f9a1a multicast=0
rfkill: initial event: idx=0 type=1 op=0 soft=0 hard=0
netlink: Operstate: ifindex=3 linkmode=1 (userspace-control), operstate=5 (IF_OPER_DORMANT)
Add interface wlo1 to a new radio phy0
nl80211: No channel number found for frequency 5905 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2437 @ 40 MHz 22 mBm
nl80211: 2422-2462 @ 40 MHz 22 mBm
nl80211: 2447-2482 @ 40 MHz 22 mBm
nl80211: 5170-5190 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5190-5210 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5210-5230 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5230-5250 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5250-5270 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5270-5290 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5290-5310 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5310-5330 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5490-5510 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5510-5530 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5530-5550 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5550-5570 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5570-5590 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5590-5610 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5610-5630 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5630-5650 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5650-5670 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5670-5690 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5690-5710 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5710-5730 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5735-5755 @ 80 MHz 22 mBm (no IR)
nl80211: 5755-5775 @ 80 MHz 22 mBm (no IR)
nl80211: 5775-5795 @ 80 MHz 22 mBm (no IR)
nl80211: 5795-5815 @ 80 MHz 22 mBm (no IR)
nl80211: 5815-5835 @ 20 MHz 22 mBm (no IR)
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484[DISABLED]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5340[DISABLED] 5360[DISABLED] 5380[DISABLED] 5400[DISABLED] 5420[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484[DISABLED]
wlo1: Own MAC address: 94:e6:f7:e4:bb:55
wpa_driver_nl80211_set_key: ifindex=3 (wlo1) alg=0 addr=(nil) key_idx=0 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=3 (wlo1) alg=0 addr=(nil) key_idx=1 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=3 (wlo1) alg=0 addr=(nil) key_idx=2 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=3 (wlo1) alg=0 addr=(nil) key_idx=3 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=3 (wlo1) alg=0 addr=(nil) key_idx=4 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wpa_driver_nl80211_set_key: ifindex=3 (wlo1) alg=0 addr=(nil) key_idx=5 set_tx=0 seq_len=0 key_len=0 key_flag=0x10
nl80211: DEL_KEY
   broadcast key
wlo1: RSN: flushing PMKID list in the driver
nl80211: Flush PMKIDs
wlo1: State: DISCONNECTED -> INACTIVE
TDLS: TDLS operation supported by driver
TDLS: Driver uses external link setup
TDLS: Driver does not support TDLS channel switching
wlo1: WPS: UUID based on MAC address: f3ba6ef5-1eac-595a-9b73-42da48340f07
ENGINE: Loading builtin engines
ENGINE: Loading builtin engines
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: Supplicant port status: Unauthorized
nl80211: Skip set_supp_port(unauthorized) while not associated
EAPOL: KEY_RX entering state NO_KEY_RECEIVE
EAPOL: SUPP_BE entering state INITIALIZE
EAP: EAP entering state DISABLED
ctrl_interface_group=101 (from group name 'netdev')
MBO: Update non-preferred channels, non_pref_chan=N/A
wlo1: Added interface wlo1
wlo1: State: INACTIVE -> DISCONNECTED
nl80211: Set wlo1 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=3 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
nl80211: Create interface iftype 10 (P2P_DEVICE)
nl80211: New P2P Device interface p2p-dev-wlo1 (0x3) created
Initializing interface 'p2p-dev-wlo1' conf '/etc/wpa_supplicant/wpa_supplicant.conf' driver 'nl80211' ctrl_interface 'DIR=/var/run/wpa_supplicant GROUP=netdev' bridge 'N/A'
Configuration file '/etc/wpa_supplicant/wpa_supplicant.conf' -> '/etc/wpa_supplicant/wpa_supplicant.conf'
Reading configuration file '/etc/wpa_supplicant/wpa_supplicant.conf'
ctrl_interface='DIR=/var/run/wpa_supplicant GROUP=netdev'
update_config=1
nl80211: TDLS supported
nl80211: TDLS external setup
nl80211: Supported cipher 00-0f-ac:1
nl80211: Supported cipher 00-0f-ac:5
nl80211: Supported cipher 00-0f-ac:2
nl80211: Supported cipher 00-0f-ac:4
nl80211: Supported cipher 00-0f-ac:8
nl80211: Supported cipher 00-0f-ac:9
nl80211: Supported cipher 00-0f-ac:6
nl80211: Supported cipher 00-0f-ac:11
nl80211: Supported cipher 00-0f-ac:12
nl80211: Using driver-based off-channel TX
nl80211: Driver-advertised extended capabilities (default) - hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities mask (default) - hexdump(len=8): 04 00 00 00 00 00 00 40
nl80211: Driver-advertised extended capabilities for interface type STATION
nl80211: Extended capabilities - hexdump(len=10): 04 00 c0 00 00 00 00 c0 01 20
nl80211: Extended capabilities mask - hexdump(len=10): 04 00 c0 00 00 00 00 c0 01 20
nl80211: Use separate P2P group interface (driver advertised support)
nl80211: Enable multi-channel concurrent (driver advertised support)
nl80211: use P2P_DEVICE support
nl80211: key_mgmt=0x1ff0f enc=0x76f auth=0x7 flags=0x84800d30fb5bfbe0 rrm_flags=0x19 probe_resp_offloads=0x0 max_stations=0 max_remain_on_chan=10000 max_scan_ssids=20
nl80211: interface p2p-dev-wlo1 in phy phy0
nl80211: Set mode ifindex 0 iftype 10 (P2P_DEVICE)
nl80211: Failed to set interface 0 to mode 10: -22 (Invalid argument)
nl80211: Subscribe to mgmt frames with non-AP handle 0x55a4fc74afc0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0104 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=040a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=040b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=040c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=040d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=090a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=090b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=090c multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=090d multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0409506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=7f506f9a09 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0409506f9a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0800 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0801 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=040e multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=12 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=06 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0a07 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0a11 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0a0b multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0a1a multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=1101 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=1102 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0505 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0500 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=0502 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=1301 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=1305 multicast=0
nl80211: Register frame type=0xd0 (WLAN_FC_STYPE_ACTION) nl_handle=0x55a4fc74afc0 match=7e506f9a1a multicast=0
nl80211: Use (wlo1) to initialize P2P Device rfkill
rfkill: initial event: idx=0 type=1 op=0 soft=0 hard=0
nl80211: Start P2P Device p2p-dev-wlo1 (0x3): Success
Add interface p2p-dev-wlo1 to existing radio phy0
nl80211: No channel number found for frequency 5905 MHz
nl80211: Regulatory information - country=00
nl80211: 2402-2437 @ 40 MHz 22 mBm
nl80211: 2422-2462 @ 40 MHz 22 mBm
nl80211: 2447-2482 @ 40 MHz 22 mBm
nl80211: 5170-5190 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5190-5210 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5210-5230 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5230-5250 @ 160 MHz 22 mBm (no outdoor) (no IR)
nl80211: 5250-5270 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5270-5290 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5290-5310 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5310-5330 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5490-5510 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5510-5530 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5530-5550 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5550-5570 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5570-5590 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5590-5610 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5610-5630 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5630-5650 @ 160 MHz 22 mBm (DFS) (no IR)
nl80211: 5650-5670 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5670-5690 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5690-5710 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5710-5730 @ 80 MHz 22 mBm (DFS) (no IR)
nl80211: 5735-5755 @ 80 MHz 22 mBm (no IR)
nl80211: 5755-5775 @ 80 MHz 22 mBm (no IR)
nl80211: 5775-5795 @ 80 MHz 22 mBm (no IR)
nl80211: 5795-5815 @ 80 MHz 22 mBm (no IR)
nl80211: 5815-5835 @ 20 MHz 22 mBm (no IR)
nl80211: Added 802.11b mode based on 802.11g information
nl80211: Mode IEEE 802.11g: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484[DISABLED]
nl80211: Mode IEEE 802.11a: 5180[NO_IR] 5200[NO_IR] 5220[NO_IR] 5240[NO_IR] 5260[NO_IR][RADAR] 5280[NO_IR][RADAR] 5300[NO_IR][RADAR] 5320[NO_IR][RADAR] 5340[DISABLED] 5360[DISABLED] 5380[DISABLED] 5400[DISABLED] 5420[DISABLED]
nl80211: Mode IEEE 802.11b: 2412 2417 2422 2427 2432 2437 2442 2447 2452 2457 2462 2467 2472 2484[DISABLED]
p2p-dev-wlo1: Own MAC address: 94:e6:f7:e4:bb:56
p2p-dev-wlo1: RSN: flushing PMKID list in the driver
nl80211: Flush PMKIDs
p2p-dev-wlo1: State: DISCONNECTED -> INACTIVE
p2p-dev-wlo1: WPS: UUID from the first interface: f3ba6ef5-1eac-595a-9b73-42da48340f07
ENGINE: Loading builtin engines
ENGINE: Loading builtin engines
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: Supplicant port status: Unauthorized
nl80211: Skip set_supp_port(unauthorized) while not associated
EAPOL: KEY_RX entering state NO_KEY_RECEIVE
EAPOL: SUPP_BE entering state INITIALIZE
EAP: EAP entering state DISABLED
Using existing control interface directory.
ctrl_interface_group=101 (from group name 'netdev')
P2P: Add operating class 81
P2P: Channels - hexdump(len=13): 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d
P2P: Own listen channel: 81:1
P2P: Random operating channel: 81:1
P2P: initialized
P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11,12,13
P2P: cli_channels:
MBO: Update non-preferred channels, non_pref_chan=N/A
p2p-dev-wlo1: Added interface p2p-dev-wlo1
p2p-dev-wlo1: State: INACTIVE -> DISCONNECTED
nl80211: Set p2p-dev-wlo1 operstate 0->0 (DORMANT)
netlink: Operstate: ifindex=0 linkmode=-1 (no change), operstate=5 (IF_OPER_DORMANT)
p2p-dev-wlo1: Determining shared radio frequencies (max len 2)
p2p-dev-wlo1: Shared frequencies (len=0): completed iteration
P2P: Add operating class 81
P2P: Channels - hexdump(len=13): 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d
P2P: Update channel list
P2P: channels: 81:1,2,3,4,5,6,7,8,9,10,11,12,13
P2P: cli_channels:
Daemonize..
```

### Authenticate with `wpa_cli`

```console
$ wpa_cli
wpa_cli v2.10
Copyright (c) 2004-2022, Jouni Malinen <j@w1.fi> and contributors

This software may be distributed under the terms of the BSD license.
See README for more details.


Selected interface 'wlo1'

Interactive mode

> status
wpa_state=DISCONNECTED
p2p_device_address=94:e6:f7:e4:bb:56
address=94:e6:f7:e4:bb:55
uuid=f3ba6ef5-1eac-595a-9b73-42da48340f07
> scan
OK
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=VN
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
<3>CTRL-EVENT-NETWORK-NOT-FOUND
> scan_results
bssid / frequency / signal level / flags / ssid
f0:2f:74:56:0f:04	5220	-69	[WPA2-PSK-CCMP][ESS]
fa:3f:79:22:19:aa	5745	-60	[WPA2-SAE-CCMP][SAE-H2E][ESS]	TEST WIFI
f0:2f:74:56:0f:08	5785	-66	[WPA2-PSK-CCMP][ESS]
86:f5:02:17:15:ed	5745	-70	[WPA2-PSK-CCMP][ESS]	Samsung_R&D_Center_OCD
3c:37:86:10:a8:70	5200	-73	[WPA2-PSK-CCMP][ESS]	Samsung_R&D_Center_SECU
ca:f3:b4:8f:b6:5a	5745	-73	[WPA2-PSK+SAE-CCMP][SAE-H2E][ESS]	dlink-5GHz-z16x
8c:1e:80:23:53:ec	5540	-57	[WPA2-PSK-CCMP][ESS]
8c:1e:80:23:53:ef	5540	-57	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_OA
8c:1e:80:23:53:ee	5540	-57	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_RND
cc:28:aa:2e:58:50	2417	-57	[WPA2-PSK-CCMP][WPS][ESS]	SRV_GBA_Octopus10
f0:2f:74:56:0f:00	2417	-60	[WPA2-PSK-CCMP][ESS]
a2:5f:79:50:8b:df	5745	-74	[WPA2-SAE-CCMP][SAE-H2E][ESS]	A55
38:91:b7:cb:5b:0c	5320	-68	[WPA2-PSK-CCMP][ESS]
38:91:b7:cb:5b:0f	5320	-68	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_OA
38:91:b7:cb:5b:0e	5320	-68	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_RND
8c:1e:80:23:78:ec	5620	-68	[WPA2-PSK-CCMP][ESS]
8c:1e:80:23:78:ef	5620	-68	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_OA
8c:1e:80:23:78:ee	5620	-68	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_RND
26:b9:9d:a6:4e:f6	2412	-65	[WPA2-PSK-CCMP][ESS]
a8:5e:45:59:00:b0	2462	-65	[WPA2-PSK-CCMP][WPS][ESS]	SRV_GBA_Octopus7
38:91:b7:cd:92:ec	5680	-69	[WPA2-PSK-CCMP][ESS]
38:91:b7:cd:9e:6c	5560	-70	[WPA2-PSK-CCMP][ESS]
38:91:b7:cb:ab:2c	5700	-72	[WPA2-PSK-CCMP][ESS]
8c:1e:80:23:53:e1	2462	-69	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_RND
a8:5e:45:59:13:40	2462	-69	[WPA2-PSK-CCMP][WPS][ESS]	SRV_GBA_Octopus2
8c:1e:80:23:53:e0	2462	-69	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_OA
8c:1e:80:23:53:e3	2462	-69	[WPA2-PSK-CCMP][ESS]
38:91:b7:cd:af:ec	5600	-73	[WPA2-PSK-CCMP][ESS]
44:a5:6e:3e:45:e2	2437	-22	[WPA2-PSK+SAE+PSK-SHA256-CCMP][SAE-H2E][ESS][UTF-8]	Samsung_R&D_Center_WIFI_TG_2G
ce:58:8c:0f:40:c8	5745	-80	[WPA2-SAE-CCMP][SAE-H2E][ESS]
cc:28:aa:2e:45:90	2417	-72	[WPA2-PSK-CCMP][WPS][ESS]	SRV_GBA_Octopus12
38:91:b7:cc:eb:2f	5680	-76	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_OA
38:91:b7:cc:eb:2e	5680	-76	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_RND
38:91:b7:cd:4f:ec	5500	-78	[WPA2-PSK-CCMP][ESS]
38:91:b7:cd:4f:ef	5500	-78	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_OA
38:91:b7:cd:4f:ee	5500	-79	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_RND
8c:1e:80:23:78:e3	2437	-77	[WPA2-PSK-CCMP][ESS]
38:91:b7:cb:5b:03	2462	-77	[WPA2-PSK-CCMP][ESS]
ca:20:e5:1a:9c:b6	5745	-84	[WPA2-PSK+SAE-CCMP][SAE-H2E][ESS]	iPhone
7c:10:c9:a3:de:b8	5765	-84	[WPA2-PSK-CCMP][WPS][ESS]	SRV_GBA_Octopus1
8c:1e:80:22:0d:0c	5280	-82	[WPA2-PSK-CCMP][ESS]
8c:1e:80:22:0d:0f	5280	-82	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_OA
8c:1e:80:22:0d:0e	5280	-82	[WPA2-EAP-CCMP][ESS]	Samsung_R&D_Center_RND
c8:7f:54:e8:29:44	5240	-86	[WPA2-PSK-CCMP][WPS][ESS]	SRV_14F_AUT_Test_161.30
38:91:b7:cd:4f:e3	2412	-80	[WPA2-PSK-CCMP][ESS]
04:42:1a:32:d9:d4	5180	-87	[WPA2-PSK-CCMP][WPS][ESS]	SRV_GBA_Octopus4
12:09:2e:6c:86:2b	2412	-85	[WPA2-PSK-CCMP][ESS]
8c:1e:80:23:53:e2	2462	-69	[ESS]
8c:1e:80:23:78:e2	2437	-77	[ESS]
8c:1e:80:22:0d:0d	5280	-82	[ESS]
38:91:b7:cd:5f:8d	5660	-87	[ESS]
> list_networks
network id / ssid / bssid / flags
> add_network
0
<3>CTRL-EVENT-NETWORK-ADDED 0
> set_network 0 ssid "Samsung_R&D_Center_WIFI_TG_2G"
OK
> set_network 0 psk "********"
OK
> enable_network 0
OK
<3>CTRL-EVENT-SCAN-STARTED
<3>CTRL-EVENT-SCAN-RESULTS
<3>WPS-AP-AVAILABLE
<3>SME: Trying to authenticate with 44:a5:6e:3e:45:e2 (SSID='Samsung_R&D_Center_WIFI_TG_2G' freq=2437 MHz)
<3>Trying to associate with 44:a5:6e:3e:45:e2 (SSID='Samsung_R&D_Center_WIFI_TG_2G' freq=2437 MHz)
<3>Associated with 44:a5:6e:3e:45:e2
<3>CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
<3>WPA: Key negotiation completed with 44:a5:6e:3e:45:e2 [PTK=CCMP GTK=CCMP]
<3>CTRL-EVENT-CONNECTED - Connection to 44:a5:6e:3e:45:e2 completed [id=0 id_str=]
> status
bssid=44:a5:6e:3e:45:e2
freq=2437
ssid=Samsung_R&D_Center_WIFI_TG_2G
id=0
mode=station
pairwise_cipher=CCMP
group_cipher=CCMP
key_mgmt=WPA2-PSK
wpa_state=COMPLETED
p2p_device_address=94:e6:f7:e4:bb:56
address=94:e6:f7:e4:bb:55
uuid=f3ba6ef5-1eac-595a-9b73-42da48340f07
> select_network 0
OK
> save_config
OK
> q
```

At this point device has Successfully authenticate, but does not have IP yet

```console
$ ip addr show wlo1
3: wlo1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 94:e6:f7:e4:bb:55 brd ff:ff:ff:ff:ff:ff
    altname wlp0s20f3
    altname wlx94e6f7e4bb55
```

### Request IPv4

#### Using `dhcpcd`

```sh
dhcpcd -n wlo1
```

```console
$ dhcpcd -n wlo1
dhcpcd-10.3.0 starting
DUID 00:01:00:01:31:32:b8:64:94:e6:f7:e4:bb:55
wlo1: connected to Access Point: Samsung_R&D_Center_WIFI_TG_2G
wlo1: IAID f7:e4:bb:55
wlo1: soliciting a DHCP lease
wlo1: offered 192.168.1.125 from 192.168.1.1
wlo1: probing address 192.168.1.125/24
wlo1: soliciting an IPv6 router
wlo1: Router Advertisement from fe80::46a5:6eff:fe3e:45de
wlo1: adding address fdb4:b9e8:9cf:0:f68:3d47:463f:1f46/64
wlo1: adding route to fdb4:b9e8:9cf::/48 via fe80::46a5:6eff:fe3e:45de
wlo1: adding route to fdb4:b9e8:9cf::/64
wlo1: soliciting a DHCPv6 lease
wlo1: ADV fdb4:b9e8:9cf::125/128 from fe80::46a5:6eff:fe3e:45de (0)
```

#### Manually add IPv4

Assuming the AP already preserved "192.168.1.125" for us:

```sh
ip addr add 192.168.1.125/24 dev wlo1
ip route add default via 192.168.1.1 dev wlo1
```

```console
root@wifiteam-laptop-debian:~# ip route

root@wifiteam-laptop-debian:~# ip addr add 192.168.1.125/24 dev wlo1

root@wifiteam-laptop-debian:~# ip route
192.168.1.0/24 dev wlo1 proto kernel scope link src 192.168.1.125

root@wifiteam-laptop-debian:~# ip addr show wlo1
3: wlo1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 94:e6:f7:e4:bb:55 brd ff:ff:ff:ff:ff:ff
    altname wlp0s20f3
    altname wlx94e6f7e4bb55
    inet 192.168.1.125/24 scope global wlo1
       valid_lft forever preferred_lft forever

root@wifiteam-laptop-debian:~# ip route add default via 192.168.1.1 dev wlo1

root@wifiteam-laptop-debian:~# ip route
default via 192.168.1.1 dev wlo1
192.168.1.0/24 dev wlo1 proto kernel scope link src 192.168.1.125
```

### Check IPv4

```sh
ip addr show wlo1
ip route
```

```console
$ ip addr show wlo1
3: wlo1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 94:e6:f7:e4:bb:55 brd ff:ff:ff:ff:ff:ff
    altname wlp0s20f3
    altname wlx94e6f7e4bb55
    inet 192.168.1.125/24 brd 192.168.1.255 scope global dynamic noprefixroute wlo1
       valid_lft 43136sec preferred_lft 37736sec
    inet6 fdb4:b9e8:9cf::125/128 scope global dynamic noprefixroute
       valid_lft 43134sec preferred_lft 43134sec
    inet6 fdb4:b9e8:9cf:0:f68:3d47:463f:1f46/64 scope global dynamic mngtmpaddr noprefixroute
       valid_lft 5332sec preferred_lft 2632sec
    inet6 fdb4:b9e8:9cf:0:96e6:f7ff:fee4:bb55/64 scope global dynamic mngtmpaddr proto kernel_ra
       valid_lft 4988sec preferred_lft 2288sec
    inet6 fe80::96e6:f7ff:fee4:bb55/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever

$ ip route
default via 192.168.1.1 dev wlo1 proto dhcp src 192.168.1.125 metric 3003
192.168.1.0/24 dev wlo1 proto dhcp scope link src 192.168.1.125 metric 3003
```

## References

- [Debian Wi-Fi How to use](https://wiki.debian.org/WiFi/HowToUse)
- [Debian NetworkConfiguration](https://wiki.debian.org/NetworkConfiguration)

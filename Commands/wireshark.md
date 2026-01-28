---
id: wireshark
aliases: []
tags: []
---

# Wireshark commands family

## Get packets start and end time

```sh
capinfos -a -e -u Band_5G_tcpdump_radiotap0_20260116114729.pcap
```

## Merge two packets end-to-end

```sh
mergecap tcpdump_radiotap0_20260123175209\[1\].pcap tcpdump_radiotap0_20260123175553\[2\].pcap -w tcpdump_radiotap0_20260123175209_merged.pcap
mergecap tcpdump_* -w merged.pcap
```

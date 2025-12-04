---
id: regex
aliases: []
tags:
  - vim
---
# Regex

## Replace single quotes with double quotes

```vim
:%s/'\([^']*\)'/"\1"/g
```

## Filter a TAG with `rg`

```sh
rg '\b\w+\s+\d+\s+\d+\s+\w\s+wpa_supplicant:' log.txt
```

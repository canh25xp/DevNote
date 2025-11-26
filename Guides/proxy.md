---
id: proxy
aliases: []
tags: []
---

# Powershell

```pwsh
[net.webrequest]::defaultwebproxy = new-object net.webproxy "http://127.0.0.1:3128"
```

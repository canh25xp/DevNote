---
id: proxy
aliases: []
tags: []
---

# Powershell

## Using proxy for `Invoke-WebRequest` method
```pwsh
[net.webrequest]::defaultwebproxy = new-object net.webproxy "http://127.0.0.1:3128"
```

## Sharing proxy

```pwsh
sudo netsh interface portproxy add v4tov4 listenport=3128 listenaddress=0.0.0.0 connectport=3128 connectaddress=127.0.0.1
```

Check status

```pwsh
netsh interface portproxy show v4tov4
```

Stop sharing

```pwsh
sudo netsh interface portproxy delete v4tov4 listenport=3128 listenaddress=0.0.0.0
```

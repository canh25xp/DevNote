---
id: curl
aliases: []
tags: []
---

# `curl`

## Redirect HTTP download file

```
curl -LO https://github.com/AutoHotkey/AutoHotkey/releases/download/v2.0.11/AutoHotkey_2.0.11_setup.exe
```

## Fix SSL certificate Error

```sh
curl -H "X-Figma-Token: $FIGMA_API_KEY" 'https://api.figma.com/v1/images/YK7omFsw7PoW614gGACOBV?ids=200:46356&format=png'
```

```
curl: (60) SSL certificate OpenSSL verify result: unable to get local issuer certificate (20)
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the webpage mentioned above.
```

Solution: Add certificate

```sh
curl --cacert ~/Archive/certs/SAPL_2022.crt -H "X-Figma-Token: $FIGMA_API_KEY" 'https://api.figma.com/v1/images/YK7omFsw7PoW614gGACOBV?ids=200:46356&format=png'
```

Do it permanently

```sh
sudo cp SAPL_2022.crt /usr/local/share/ca-certificates
sudo update-ca-certificates
```

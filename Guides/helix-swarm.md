---
id: helix-swarm
aliases: []
tags: []
---
# Swarm API

## Authentication

```sh
curl -u "p4user:p4ticket" https://review1716.sec.samsung.net/api/v9/projects
```

For example

```sh
# Obviously not my actual ticket
curl -u "vancanh.ng:FBBAA5F13E8884DB0C58DC598A7EC94F" https://review1716.sec.samsung.net/api/v9/projects
```

`p4ticket` is create after you login with `p4 login` and usually located at `~/p4tickets.txt`

To avoid typing user and ticket every time,
create a new `.netrc` or `_netrc` at your user home with the following content:

```sh
# ~/.netrc
machine review1716.sec.samsung.net
login vancanh.ng
password FBBAA5F13E8884DB0C58DC598A7EC94F
```

```sh
curl -n https://review1716.sec.samsung.net/api/v9/projects
```

## Get Swarm version information

```sh
curl https://review1716.sec.samsung.net/api/version
```

## Get reviews information

```sh
curl -n https://review1716.sec.samsung.net/api/v9/reviews/32071493
```

## Request review for CL

```sh
curl -n -X POST -d "change=32072085" https://review1716.sec.samsung.net/api/v4/reviews
```

## Tips

### Pretty print curl's json output

Download `jq` from github [github](https://review1716.sec.samsung.net/api/v9/projects) and put it in your `PATH` environment.

Then pipe curl's output to jq

```sh
curl -n https://review1716.sec.samsung.net/api/v11/reviews/32071493 | jq
```

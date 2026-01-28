---
id: p4-cherry-picking
aliases: []
tags:
  - p4
---

# Cherry picking with `p4` cli

1. First make sure both branch is mapped to your workspace

```sh
p4 where //path/to/src-branch
p4 where //path/to/dst-branch
```

2. Make sure both branch is up to date

```sh
p4 sync //path/to/src-branch/...
p4 sync //path/to/dst-branch/...
```

3. Perform a dry-run to check which files will be integrate

```sh
p4 integrate -n -1 //path/to/src-branch/...@123 //path/to/dst-branch/...
```

4. Integrate branch

```sh
p4 integrate -1 //path/to/src-branch/...@123 //path/to/dst-branch/...
p4 resolve -am
```

5. Check integrated files

```sh
p4 opened
```

6. Create shelve CL

Refer to [[p4-shelve-cl]]

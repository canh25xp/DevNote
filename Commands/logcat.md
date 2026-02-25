---
id: logcat
aliases: []
tags:
  - android
  - logcat
---


# `logcat`

> [!NOTE]
> Either running `adb logcat` or `adb shell` and then `logcat`

## Filter by tag

```sh
logcat *:S wpa_supplicant:*
```

## Dump all log and exit

```sh
logcat -d
```

## Dump log to a file

```sh
logcat -d -f /sdcard/dump.log
```


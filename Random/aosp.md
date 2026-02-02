---
id: aosp
aliases: []
tags:
  - android
  - aosp
---

# Android Open Source Project

## Common module location

- Compatibility Test Suite (CTS): `android/cts`
- Android Debug Bridge (ADB): `android/packages/modules/adb`

## Build output

- `$ANDROID_BUILD_TOP/out/target/product/a15/symbols/vendor/bin/hw/wpa_supplicant`: unstripped, debuggable binary
- `$ANDROID_BUILD_TOP/out/target/product/a15/vendor/bin/hw/wpa_supplicant`: stripped, no debug info binary

BuildID is identical

```
$ file out/target/product/a15/vendor/bin/hw/wpa_supplicant
out/target/product/a15/vendor/bin/hw/wpa_supplicant: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, for Android 36, BuildID [md5/uuid]=087c4d7801e39a0a7c501b88cd04c7e5, stripped
vancanh-ng in ~/projects/a15_vendor/android  R38WA001VGL
$ file out/target/product/a15/symbols/vendor/bin/hw/wpa_supplicant
out/target/product/a15/symbols/vendor/bin/hw/wpa_supplicant: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /system/bin/linker64, for Android 36, BuildID[md5/uuid]=087c4d7801e39a0a7c501b88cd04c7e5, with debug_info, not stripped
```

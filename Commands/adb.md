# ADB

## Commands

- Get build id

```sh
adb shell getprop ro.omc.build.id
```

- Skip setup after flash

```sh
adb shell content insert --uri content://settings/secure --bind name:s:user_setup_complete --bind value:s:1
adb reboot
```

- List Devices

```sh
adb devices -l
```

- Connect to specific device (when there are multiple devices connect). It is necessary that the -s flag comes before other command

```sh
adb -s R32X6003EPL <command>
```

- Get wifi allowed channels

```sh
adb shell cmd wifi get-allowed-channel
```

- Check binary type - user, userdebug, eng

```sh
adb shell getprop ro.build.official.release
adb shell getprop ro.build.type
adb shell getprop ro.bootimage.build.fingerprint
```

- Enabled verbose logging

```sh
adb shell settings put global wifi_verbose_logging_enabled 1
```

1. Install Termux on the device

- Install F-DROID

``` sh
curl -LO https://f-droid.org/F-Droid.apk
adb install F-DROID.apk
```

- Open F-DROID to download and install Termux

- Initial setup

``` sh
pkg update && pkg upgrade -y
```

- Get permission : Go to `Settings` -> `Apps` -> `Termux` -> `Permissions` -> `Files and media` `Allow`

2. Connect to termux via USB
>
> https://wiki.termux.com/wiki/Remote_Access
>
> https://glow.li/posts/access-termux-via-usb/

- On termux

```sh
pkg install openssh # install openssh
sshd # start OpenSSH daemon
whoami # remember this username
passwd # setup password that later use to connect
```

- On PC

```sh
adb forward tcp:8022 tcp:8022
ssh localhost -p 8022
```

where `u0_a343` is the `username` (findout by running `whoami`)

when ask `Are you sure you want to continue connecting (yes/no/[fingerprint])?`

Choose `yes` and then type in the client passwordn

3. Stop shh tunnel

```sh
pkill sshd
```

4. Tips

- Launch termux using [[adb]]

```sh
adb shell am start -n com.termux/.HomeActivity
```



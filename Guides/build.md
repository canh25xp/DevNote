---
id: build
aliases: []
tags: []
---

# Samsung AOSP build

## Build overview

## Build steps

This guide will use the `GALAXY-A56-5G` model as an example

https://android.qb.sec.samsung.net/build/98878392

### Setup build environment

<!--TODO: Write this-->

### Get the source code

Create a new p4 client with model template

```sh
mkdir VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN && cd VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN
p4 client -t TEMPLATE_D4_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN
# TEMPLATE_D4_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN is the template taken from quickbuild
# VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN is the name of the workspace to be created
```

An editor will open for you to edit config for the new template, it is good enough to just leave it as default.
Save and close editor to create new workspace.

Then, sync the source code.
It is recommended to use SYSTEM_CL_SYNC or VENDOR_CL_SYNC taken from a **successful build** rather than latest build

```sh
p4 -I sync -q ...@31813653
# the -I flag tell p4 to display progress
# the -q flag tell p4 to suppress output, since p4 sync output could be very noisy
```

where `31813653` is the SYSTEM_CL_SYNC

### Build

It is possible to use the same build command taken from quickbuild.
Since we already sync the source code.
Add `-p` flag to skip-signing So, you can build without signing permissions at your local machine.

```sh
cd buildscript
./build -oa -tuserdebug -iA566BXXU5BYG4 -ma -dmid -j5BYG4 -r31813653 -B -Wt --sssi-build system -M a56x_eur_open system/logging/logcat
```

A few things to note, flags `-oa`, `-ma`, `-dmid` is redundant, since it is default value.
Same for `-i`, `-j` and `-r` flag when you just build module.

Or you can run build manually.
First perform a dry-run to to generate files for SEC PRODUCT FEATURE

```sh
cd buildscript
./build -n -tuserdebug -mp -dmid --sssi-build system a56x_eur_open
cd ..
```

**NOTE**: remember to replace system to vendor if this is a vendor workspace

This will create `android/out/target/product/a56x/gen/FEATURES/SecProductFeature_intermediates/.spf_list` and `../output/export_variables.txt`

The rest is pretty much like google's android build process

```sh
cd android
source build/envsetup.sh
lunch a56xnaxx-bp2a-userdebug
```

```sh
source ../output/export_variables.txt
export ALLOW_MISSING_DEPENDENCIES=true
export DISABLE_STUB_VALIDATION=true
m -j16 logcat
```

### Incremental build

In prior to first build

```sh
./prebuilts/build-tools/linux-x86/bin/ninja -f out/combined-a14nsxx.ninja -j16 logcat
# or just use aninja, which is basically the same command
aninja -j16 logcat
```

## Tips and Tricks

### Minimize sync source code

Fully sync p4 workspace could be HUGE, here are some of the large directory that you can ignore to reduce storage usage (about ~100GB)

- `android/vendor/samsung/frameworks/camerasolution/...`
- `android/vendor/samsung/frameworks/vendor/camerasolution/...`
- `android/frameworks/base/samsung/wallpaper/...`
- `android/vendor/google/apps/...`

Run `p4 client <your-workspace-name>` to edit client mapping

```
View:
  -//PROD_BENI/ONEUI_8_0/FLUMEN/SYSTEM/Cinnamon/frameworks/base/samsung/wallpaper/... //VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN/android/frameworks/base/samsung/wallpaper/...
  -//PROD_BENI/ONEUI_8_0/FLUMEN/SYSTEM/Cinnamon/vendor/samsung/frameworks/camerasolution/... //VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN/android/vendor/samsung/frameworks/camerasolution/...
  -//PROD_BENI/ONEUI_8_0/FLUMEN/SYSTEM/Cinnamon/vendor/samsung/frameworks/vendor/camerasolution/... //VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN/android/vendor/samsung/frameworks/vendor/camerasolution/...
  -//PROD_BENI/ONEUI_8_0/FLUMEN/SYSTEM/Cinnamon/vendor/google/apps/... //VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN/android/vendor/google/apps/...
```

**Note** the depot location will most definitely be different for you, so change it accordingly

Or **alternatively**, perform a "fake" sync to update server metadata only without syncing files:

```
p4 sync -k android/vendor/samsung/frameworks/camerasolution/...
p4 sync -k android/vendor/samsung/frameworks/vendor/camerasolution/...
p4 sync -k android/frameworks/base/samsung/wallpaper/...
p4 sync -k android/vendor/google/apps/...
```

And later, just perform a whole workspace sync normally and these directory shall be skip

```
p4 sync ...@32225977
```

Finally, it recommended to sync it back to #none to reflect the actual state of your workspace

```
p4 sync -k android/vendor/samsung/frameworks/camerasolution/...#none
p4 sync -k android/vendor/samsung/frameworks/vendor/camerasolution/...#none
p4 sync -k android/frameworks/base/samsung/wallpaper/...#none
p4 sync -k android/vendor/google/apps/...#none
```

### Preview workspace size

It might be good idea to preview the size of your workspace before you sync.

```sh
p4 sizes -s -H //VANCANH-NG_A56X-EUR-OPEN_ONEUI80_SYSTEM_BBFLUMEN/...
```

## Troubleshooting

### Python AttributeError:

> File "/home/cuong/BENI_BUILD_ERROR_AI_PARSE/buildscript/build_common/external/cfgldr/pyparsing.py", line 696, in <module> collections.MutableMapping.register(ParseResults)
> AttributeError: module 'collections' has no attribute 'MutableMapping'

**Causes**: `collections` library change interface Starting from python 3.10

**Solution**: You can either downgrade python to version below python 3.10, like quickbuild, which is using python version 3.8.
Or as a workaround, edit the file `buildscript/build_common/external/cfgldr/pyparsing.py`:

```diff
==== //PROD_BENI/ONEUI_8_0/FLUMEN/SYSTEM/Cinnamon/buildscript/build_common/external/cfgldr/pyparsing.py#1 (text) ====

@@ -73,6 +73,10 @@
 import functools
 import itertools

+if sys.version_info.major == 3 and sys.version_info.minor >= 10:
+    setattr(collections, "MutableMapping", collections.abc.MutableMapping)
+    setattr(collections, "Sequence", collections.abc.Sequence)
+
 #~ sys.stderr.write( "testing pyparsing module, version %s, %s\n" % (__version__,__versionTime__ ) )
```

Refer to sCL@31907049 (Could be remove in the future)

### Killed

> Killed
> 03:22:37 soong bootstrap failed with: exit status 1
> ninja: build stopped: subcommand failed.

**Cause**: usually out of memory, check logs to confirm killed process reason `dmesg | tail -20`

**Solution**: either reduces parallel threads `m -j4 wpa_supplicant` or increase swap size

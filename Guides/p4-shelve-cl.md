---
id: p4-shelve-cl
aliases: []
tags:
  - p4
---

# Shelve files with `p4` cli

1. Open file for edit
    ```sh
    p4 edit build.gradle
    ```
2. Create new CL with description
    ```sh
    p4 change -o | sed '/^Description:/,$c\Description:\
            [Title] WiFi roaming fix\
            [Module] Wifi\
            [Model] Z Flip 6\
            [Chipset] Snapdragonn\
            [Region] SEA\
            [Customer] Samsung\
            [Type] Bugfix\
            [Issue#] WIFI-1234\
            [Problem] Roaming disconnects\
            [Cause] RSSI threshold too aggressive\
            [Measure] Adjusted handover logic\
            [Checking Method] Field test\
            [Developer] vancanh.ng' |
    p4 change -i
    ```
    Take note the CL created
    ```
    Change 32981902 created.
    ```
3. Shelve files in CL
    ```sh
    p4 shelve -c 32981902 ...
    ```

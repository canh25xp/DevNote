---
id: SecSettings
aliases: []
tags:
  - localbuild
---

# SecSettings local build guide

> [!NOTE]
> This guide will use pure CLI only. So you at least comfortable to work with tools like `sdkmanager`, `p4`, `adb`, `gradle`, ...
> Works with B-OS (BENI) up to ONE UI 8.5

**Perquisites**:

- OS: Windows, Linux
- Software:
    - [`sdkmanager`](https://developer.android.com/tools/sdkmanager)
        - Android SDK Platform 36
        - Android SDK Build-Tools 36.1
        - Android SDK Platform-Tools (`adb`)
    - JDK 21 and later
    - `p4`

Build Overview:

1. Create workspace.
2. Sync source code.
3. Gradle build.

## Build steps

Before you continue, ensure you have the right SDK and JDK:

```sh
sdkmanager "platform-tools" "platforms;android-36" "build-tools;35.0.0"
java --version
```

Also ensure the following environment variable is properly defined:

```sh
echo $JAVA_HOME
/usr/lib/jvm/jdk-21.0.6-oracle-x64
echo $ANDROID_HOME
/home/vancanh-ng/android
```

1. First create a new workspace.

    ```sh
    p4 client -t SecSettings_BENI_VANCANH-NG SecSettings_YourClientName
    ```

    > [!IMPORTANT]
    > My workspace "SecSettings_BENI_VANCANH-NG" could rename or remove overtime.
    > You could ask your coworker for their workspace
    > or just create a new workspace from scratch using this [Workspace template](#workspace-template-b-os)

2. Sync the source code.
   You should **NOT** sync whole workspace to latest.
   First, get the latest CL for the `android/android.jar` file:

    > [!IMPORTANT]
    > It is important that you set P4CLIENT point the workspace you just created.
    > Just run `p4 set P4CLIENT=SecSettings_YourClientName`

    ```sh
    p4 changes -m1 -l android/android.jar
    ```

    As of the time I wrote this, `android.jar` is sync to CL@32793587 and it update external libraries for CL@32791056

    ```
    Change 32793587 on 2025/12/24 by dh_87.kim@FW_DEVICECONTROL_ANDROIDSTUDIO_DUKHYUN_DESKTOP_BENI

         [Title] Update external libraries and android.jar (CL 32791056)
         [Module] Settings
         [Model] Common
         [Chipset] Common
         [Region] Common
         [Customer] Common
         [Type] Dev-ModelSetup
         [Issue#] FRAMEWORKG-143497
         [Problem] Update external libraries and android.jar
         [Cause] Update external libraries and android.jar
         [Measure] Update external libraries and android.jar
         [Checking Method] Settings
         [Developer] dh_87.kim
         ***** PBS Success at : Local *****
    ```

    Then You should sync whole workspace to CL@32791056 then sync the `android.jar` to CL@32793587:

    ```sh
    p4 sync ...@32791056
    p4 sync android/android.jar@=32793587
    ```

3. Build it

    ```sh
    ./gradlew :SecSettings:assembleDebug
    ```

    > [!NOTE]
    > You will probably get the error that `local.properties` does not exist.
    > In that case, create one (replace `sdk.dir` with your path)

    ```sh
    echo "sdk.dir=/home/vancanh-ng/android" > local.properties
    ```

## Tips and Troubleshoots

1. Set P4IGNORES
   Like gitignore, it is a good idea to set p4ignore to keep your working directory clean when running `p4 status`.
   Create a file name `.p4ignore` with the content:

    ```txt
    /.p4ignore # selfignore
    /.envrc
    build/
    /.gradle/
    /.kotlin/
    ```

## Appendix

### Workspace template (B-OS)

```
//DEV/Application/Settings/WORKING/LocalBuild/BENI/... //[Your workspace]/...
//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/... //[Your workspace]/SecSettings/...
-//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/tests/... //[Your workspace]/SecSettings/tests/...
//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SettingsLib/... //[Your workspace]/SettingsLib/...
//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SettingsLib/Graph/graph.proto //[Your workspace]/SettingsLib/Graph/protos/graph.proto
//BENI/SYSTEM/Cinnamon/frameworks/opt/net/wifi/libs/WifiTrackerLib/... //[Your workspace]/WifiTrackerLib/...
//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SystemUI/unfold/... //[Your workspace]/SystemUI/unfold/...
//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SystemUI/shared/biometrics/... //[Your workspace]/SystemUI/shared/biometrics/...
//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SystemUI/utils/... //[Your workspace]/SystemUI/utils/...
//BENI/SYSTEM/Cinnamon/frameworks/base/libs/WindowManager/Shell/shared/src/com/android/wm/shell/shared/desktopmode/... //[Your workspace]/WindowManager/Shell/shared/src/com/android/wm/shell/shared/desktopmode/...
//BENI/SYSTEM/Strawberry/ESSI/android/frameworks/libs/systemui/viewcapturelib/... //[Your workspace]/viewcapturelib/...
//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettingsIntelligence/glance_lib/sesl*-glance-* //[Your workspace]/SecSettings/glance_lib/sesl*-glance-*
//DEV/Application/Settings/WORKING/LocalBuild/BENI/*/build.gradle //[Your workspace]/*/build.gradle
//DEV/Application/Settings/WORKING/LocalBuild/BENI/*/*/build.gradle //[Your workspace]/*/*/build.gradle
//DEV/Application/Settings/WORKING/LocalBuild/BENI/*/*/*/build.gradle //[Your workspace]/*/*/*/build.gradle
-//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SettingsLib/*/build.gradle.kts //[Your workspace]/SettingsLib/*/build.gradle.kts
-//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SettingsLib/*/*/build.gradle.kts //[Your workspace]/SettingsLib/*/*/build.gradle.kts
-//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/tests/... //[Your workspace]/SecSettings/SecSettings/tests/...
//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/tests/secrobotests/... //[Your workspace]/SecSettings/tests/secrobotests/...
//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/tests/secuitests/... //[Your workspace]/SecSettingsUITests/tests/secuitests/...
-//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/res/values-*/strings.xml //[Your workspace]/SecSettings/res/values-*/strings.xml
-//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/res/values-*/arrays.xml //[Your workspace]/SecSettings/res/values-*/arrays.xml
-//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/samsung/*/res/values-*/strings.xml //[Your workspace]/SecSettings/samsung/*/res/values-*/strings.xml
-//BENI/SYSTEM/Cinnamon/applications/sources/apps/SecSettings/samsung/*/res/values-*/arrays.xml //[Your workspace]/SecSettings/samsung/*/res/values-*/arrays.xml
-//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SettingsLib/res/values-*/strings.xml //[Your workspace]/SettingsLib/res/values-*/strings.xml
-//BENI/SYSTEM/Cinnamon/frameworks/base/packages/SettingsLib/res/values-*/arrays.xml //[Your workspace]/SettingsLib/res/values-*/arrays.xml
-//BENI/SYSTEM/Cinnamon/frameworks/opt/net/wifi/libs/WifiTrackerLib/res/values-*/strings.xml //[Your workspace]/WifiTrackerLib/res/values-*/strings.xml
-//BENI/SYSTEM/Cinnamon/frameworks/opt/net/wifi/libs/WifiTrackerLib/res/values-*/arrays.xml //[Your workspace]/WifiTrackerLib/res/values-*/arrays.xml
-//BENI/SYSTEM/Cinnamon/frameworks/opt/net/wifi/libs/WifiTrackerLib/samsung/*/res/values-*/strings.xml //[Your workspace]/WifiTrackerLib/samsung/*/res/values-*/strings.xml
-//BENI/SYSTEM/Cinnamon/frameworks/opt/net/wifi/libs/WifiTrackerLib/samsung/*/res/values-*/arrays.xml //[Your workspace]/WifiTrackerLib/samsung/*/res/values-*/arrays.xml
```

# Troubleshooting Guides 
*For UnattendedWinstall v1.0.0*

## Adobe Creative Cloud Installer won't Launch

<details>
<summary>Click to Show Fix</summary>

### You need to install Microsoft Edge

1. Right-Click on Start and open Windows Powershell or Terminal as Admin.
2. Run the following command:
    ```powershell
    irm www.christitus.com/win | iex
    ```
3. Select Microsoft Edge and Click on "Install or Upgrade Selected."
4. Microsoft Edge will be reinstalled.
5. After Edge is installed, navigate to `C:\Program Files (x86)\Microsoft\Edge\Application` and run the `msedge.exe` file to launch Edge and create a Desktop Shortcut.

**Alternatively:**

1. Right-Click on Start and open Windows Powershell or Terminal as Admin.
2. Run the following command:
    ```powershell
    winget install -e --id Microsoft.Edge
    ```
3. Microsoft Edge will be reinstalled.
4. After Edge is installed, navigate to `C:\Program Files (x86)\Microsoft\Edge\Application` and run the `msedge.exe` file to launch Edge and create a Desktop Shortcut.

</details>

## OneDrive not Launching

<details>
<summary>Click to Show Fix</summary>

### You need to Enable OneDrive and User Sync

1. Right-Click on Start and open Windows Powershell or Terminal as Admin.
2. Run the following commands:
    ```powershell
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v KFMBlockOptIn /t REG_DWORD /d 0 /f
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 0 /f
    reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v SettingSyncEnabled /t REG_DWORD /d 1 /f
    ```
3. Restart Your PC and try launching OneDrive again.

</details>

## Calendar and Notifications (WhatsApp) not Working

<details>
<summary>Click to Show Fix</summary>

### You need to Enable the Calendar, Notifications and Background Apps 

1. Right-Click on Start and open Windows Powershell or Terminal as Admin.
2. Run the following commands:
    ```powershell
    reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 0 /f
    reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 1 /f
    reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 0 /f
    ```
3. Restart Your PC to apply the changes.

</details>

## Windows Spotlight not Working

<details>
<summary>Click to Show Fix</summary>

### You need to Enable Windows Spotlight

1. Right-Click on Start and open Windows Powershell or Terminal as Admin.
2. Run the following commands:
    ```powershell
    reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnLockScreen /t REG_DWORD /d 0 /f
    reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 0 /f
    reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightActiveUser /t REG_DWORD /d 0 /f
    ```
3. Restart Your PC to apply the changes.

</details>


## How to Reinstall the Microsoft Store

<details>
<summary>Click to Show Fix</summary>

### Reinstall the Microsoft Store - [Video Instructions](https://youtu.be/pjPtV_1cVOk)

1. Download, Install and Launch the [Xbox App for Windows](https://www.xbox.com/en-US/apps/xbox-app-for-pc)
2. It will prompt you to install missing dependencies and the Microsoft Store is one of them.

</details>

## Xbox Game Bar not Working or Recording

<details>
<summary>Click to Show Fix</summary>

### Install the Xbox App for Windows and Enable the Xbox Game Bar

1. Download, Install and Launch the [Xbox App for Windows](https://www.xbox.com/en-US/apps/xbox-app-for-pc)
2. It will prompt you to install missing dependencies, install all of them.
3. Right-Click on Start and open Windows Powershell or Terminal as Admin.
4. Run the following commands:
    ```powershell
    reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 0 /f
    reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f
    reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 0 /f
    reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 0 /f
    reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d 1 /f
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 1 /f
    ```
5. Restart Your PC to apply the changes.

</details>



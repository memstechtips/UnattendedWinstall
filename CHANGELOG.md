# Updates
## 30/6/2024
### Removed
```
:: Start Menu Customizations
:: Disables Recently Added Apps and Recommendations in the Start Menu
reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f

:: Start Menu Customizations 
:: Disables Recently Added Apps and Recommendations in the Start Menu
reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f

:: Start Menu Customization
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins /t REG_SZ /d "{ \"pinnedList\": [] }" /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins_ProviderSet /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v ConfigureStartPins_WinningProvider /t REG_SZ /d B5292708-1619-419B-9923-E5D9F3925E71 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" /v ConfigureStartPins /t REG_SZ /d "{ \"pinnedList\": [] }" /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\providers\B5292708-1619-419B-9923-E5D9F3925E71\default\Device\Start" /v ConfigureStartPins_LastWrite /t REG_DWORD /d 1 /f
:: Enables the "Settings" and "File Explorer" Icon in the Start Menu
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderSettings /t REG_DWORD /d 00000001 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderSettings_ProviderSet /t REG_DWORD /d 00000001 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderFileExplorer /t REG_DWORD /d 00000001 /f
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v AllowPinnedFolderFileExplorer_ProviderSet /t REG_DWORD /d 00000001 /f
```
Reason: Intended for Windows 11 but doesn't work as originally intended and prevents the user from changing the settings manually.

```
:: Disables User Account Control
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

:: Disables User Account Control
reg.exe add "HKU\DefaultUser\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v UserAccountControlSettings /t REG_DWORD /d 0 /f

:: Disables User Account Control
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v UserAccountControlSettings /t REG_DWORD /d 0 /f
```
Reason: Could cause security issues, user can set it manually.

### Added
```
<RunSynchronousCommand wcm:action="add">
      <Order>10</Order>
      <Description>Adds Take Ownership to the Right Click Context Menu</Description>
      <Path>cmd.exe /c "reg.exe import "C:\Windows\Setup\Scripts\take-ownership.reg" &gt;&gt;"C:\Windows\Setup\Scripts\take-ownership.log" 2&gt;&amp;1"</Path>
</RunSynchronousCommand>
```
```
<!--Adds "Take Ownership" to the Right Click Context Menu-->
<File path="C:\Windows\Setup\Scripts\take-ownership.reg"><![CDATA[
Windows Registry Editor Version 5.00

; Created by: Shawn Brink
; Created on: September 6, 2021
; Updated on: January 7, 2024
; Tutorial: https://www.elevenforum.com/t/add-take-ownership-to-context-menu-in-windows-11.1230/

[-HKEY_CLASSES_ROOT\*\shell\TakeOwnership]
[-HKEY_CLASSES_ROOT\*\shell\runas]

[HKEY_CLASSES_ROOT\*\shell\TakeOwnership]
@="Take Ownership"
"Extended"=-
"HasLUAShield"=""
"NoWorkingDirectory"=""
"NeverDefault"=""

[HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""
"IsolatedCommand"= "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""

[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership]
@="Take Ownership"
"AppliesTo"="NOT (System.ItemPathDisplay:=\"C:\\Users\" OR System.ItemPathDisplay:=\"C:\\ProgramData\" OR System.ItemPathDisplay:=\"C:\\Windows\" OR System.ItemPathDisplay:=\"C:\\Windows\\System32\" OR System.ItemPathDisplay:=\"C:\\Program Files\" OR System.ItemPathDisplay:=\"C:\\Program Files (x86)\")"
"Extended"=-
"HasLUAShield"=""
"NoWorkingDirectory"=""
"Position"="middle"

[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList ('/c takeown /f \\\"%1\\\" /r /d ' + $Y + ' && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause') -Verb runAs\""
"IsolatedCommand"="powershell -windowstyle hidden -command \"$Y = ($null | choice).Substring(1,1); Start-Process cmd -ArgumentList ('/c takeown /f \\\"%1\\\" /r /d ' + $Y + ' && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause') -Verb runAs\""

[HKEY_CLASSES_ROOT\Drive\shell\runas]
@="Take Ownership"
"Extended"=-
"HasLUAShield"=""
"NoWorkingDirectory"=""
"Position"="middle"
"AppliesTo"="NOT (System.ItemPathDisplay:=\"C:\\\")"

[HKEY_CLASSES_ROOT\Drive\shell\runas\command]
@="cmd.exe /c takeown /f \"%1\\\" /r /d y && icacls \"%1\\\" /grant *S-1-3-4:F /t /c & Pause"
"IsolatedCommand"="cmd.exe /c takeown /f \"%1\\\" /r /d y && icacls \"%1\\\" /grant *S-1-3-4:F /t /c & Pause"]]>
</File>
```
Reason: Useful Context Menu Entry to Quickly Take Ownership of Files and Folders

```
<ProductKey>
      <Key>00000-00000-00000-00000-00000</Key>
      <WillShowUI>Always</WillShowUI> <!-- This ensures the UI will show to select the edition of Windows -->
</ProductKey>
```
Reason: Prevents Windows from Automatically Selecting a Windows Edition due to a OEM key being installed in the BIOS/UEFI.

### Misc
Update XML file so it is properly escaped and prevents errors.

## 29/6/2024
### Removed
```
Set-Service -Name 'wscsvc' -StartupType Manual -ErrorAction Continue
```
Reason: Could cause security issues

Disables IPv6
```
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters' -Name 'DisabledComponents' -PropertyType 'DWord' -Value 255 -Force
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6
```
Reason: Doesn't really provide any benefits.

### Added
```
:: Block Automatic Upgrade from Windows 10 22H2 to Windows 11 Although Manual Upgrade is Still Allowed - Credit CyberCPU Tech
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersion" /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersionInfo" /t REG_SZ /d "22H2" /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ProductVersion" /t REG_SZ /d "Windows 10" /f
```
```
:: Disables Windows Recall on Copilot+ PC - Credit Britec09
reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\WindowsAI" /f
reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f
reg.exe add "HKU\DefaultUser\Software\Policies\Microsoft\Windows\Windows AI" /v "TurnOffSavingSnapshots" /t REG_DWORD /d 1 /f
```
```
:: Disables Windows Recall on Copilot+ PC - Credit Britec09
reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI" /f
reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f
reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Windows AI" /v "TurnOffSavingSnapshots" /t REG_DWORD /d 1 /f
```

## 26/6/2024
Updated description and changed Quality and Feature Updates delay to 365 days which is the maximum allowed period.

```
:: Sets Windows Update to Only Install Security Updates and Delay Other Updates for 1 Year
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 3 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdates /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferFeatureUpdatesPeriodInDays /t REG_DWORD /d 365 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdates /t REG_DWORD /d 1 /f
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DeferQualityUpdatesPeriodInDays /t REG_DWORD /d 365 /f
```

## 23/6/2024
Reorder Runsynchronous commands in the specialize phase to load Default User Registry hive earlier.
   
Restore and Set Windows Photo Viewer as default image viewer.

Updated following description:
```
:: Controls whether the memory page file is cleared at shutdown. Value 0 means it will not be cleared, speeding up shutdown. 
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
```
   
## 21/6/2024
Removed the following entry as it removes the ability for the user to set a custom picture on the sign-in/lock screen and that wasn't my original purpose.

*Disables the lock screen*

*reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f*

## 20/6/2024
Removed the following entry as it causes the legacy language bar to  be displayed on the lock screen.

*Hides the Language Switcher on the Taskbar*

*Set-WinLanguageBarOption -UseLegacyLanguageBar*

# Initial Release 15 June 2024
### Removed Preinstalled Bloatware Apps (remove-packages.ps1)
The following preinstalled bloatware apps are removed during the Windows installation process:

| Package Name                                      | Name in Windows                               |
|---------------------------------------------------|-----------------------------------------------|
| `Microsoft.Microsoft3DViewer`                     | 3D Viewer                                     |
| `Microsoft.BingSearch`                            | Bing Search                                   |
| `Microsoft.WindowsCamera`                         | Camera                                        |
| `Clipchamp.Clipchamp`                             | Clipchamp                                     |
| `Microsoft.WindowsAlarms`                         | Alarms & Clock                                |
| `Microsoft.549981C3F5F10`                         | Cortana                                       |
| `Microsoft.Windows.DevHome`                       | Dev Home                                      |
| `MicrosoftCorporationII.MicrosoftFamily`          | Family Safety                                 |
| `Microsoft.WindowsFeedbackHub`                    | Feedback Hub                                  |
| `Microsoft.GetHelp`                               | Get Help                                      |
| `microsoft.windowscommunicationsapps`             | Mail and Calendar                             |
| `Microsoft.WindowsMaps`                           | Maps                                          |
| `Microsoft.ZuneVideo`                             | Movies & TV                                   |
| `Microsoft.BingNews`                              | News                                          |
| `Microsoft.WindowsNotepad`                        | Notepad                                       |
| `Microsoft.MicrosoftOfficeHub`                    | Office Hub                                    |
| `Microsoft.Office.OneNote`                        | OneNote                                       |
| `Microsoft.OutlookForWindows`                     | Outlook                                       |
| `Microsoft.Paint`                                 | Paint                                         |
| `Microsoft.MSPaint`                               | Paint 3D                                      |
| `Microsoft.People`                                | People                                        |
| `Microsoft.Windows.Photos`                        | Photos                                        |
| `Microsoft.PowerAutomateDesktop`                  | Power Automate Desktop                        |
| `MicrosoftCorporationII.QuickAssist`              | Quick Assist                                  |
| `Microsoft.SkypeApp`                              | Skype                                         |
| `Microsoft.ScreenSketch`                          | Snip & Sketch                                 |
| `Microsoft.MicrosoftSolitaireCollection`          | Solitaire Collection                          |
| `Microsoft.MicrosoftStickyNotes`                  | Sticky Notes                                  |
| `MSTeams`                                         | Teams                                         |
| `Microsoft.Getstarted`                            | Tips                                          |
| `Microsoft.Todos`                                 | To Do                                         |
| `Microsoft.WindowsSoundRecorder`                  | Voice Recorder                                |
| `Microsoft.BingWeather`                           | Weather                                       |
| `Microsoft.ZuneMusic`                             | Groove Music                                  |
| `Microsoft.WindowsTerminal`                       | Windows Terminal                              |
| `Microsoft.Xbox.TCUI`                             | Xbox Console Companion                        |
| `Microsoft.XboxApp`                               | Xbox                                          |
| `Microsoft.XboxGameOverlay`                       | Xbox Game Bar                                 |
| `Microsoft.XboxGamingOverlay`                     | Xbox Game Bar                                 |
| `Microsoft.XboxIdentityProvider`                  | Xbox Identity Provider                        |
| `Microsoft.XboxSpeechToTextOverlay`               | Xbox Speech To Text Overlay                   |
| `Microsoft.GamingApp`                             | Xbox Game Pass                                |
| `Microsoft.YourPhone`                             | Phone Link                                    |
| `Microsoft.MicrosoftEdge`                         | Microsoft Edge                                |
| `Microsoft.MicrosoftEdge.Stable`                  | Microsoft Edge (Stable)                       |
| `Microsoft.OneDrive`                              | OneDrive                                      |
| `Microsoft.MicrosoftEdgeDevToolsClient`           | Microsoft Edge DevTools Client                |
| `Microsoft.549981C3F5F10`                         | Cortana (Duplicate)                           |
| `Microsoft.MixedReality.Portal`                   | Mixed Reality Portal                          |
| `Microsoft.Windows.Ai.Copilot.Provider`           | Windows Copilot                               |
| `Microsoft.WindowsMeetNow`                        | Meet Now                                      |
| `Microsoft.WindowsStore`                          | Microsoft Store                               |

### Removed Legacy Apps (remove-caps.ps1 & remove-features.ps1)
| Package Name                        | Name in Windows                   |
|-------------------------------------|-----------------------------------|
| Browser.InternetExplorer            | Internet Explorer                 |
| MathRecognizer                      | Math Recognizer                   |
| Microsoft.Windows.Notepad           | Notepad                           |
| OpenSSH.Client                      | OpenSSH Client                    |
| Microsoft.Windows.MSPaint           | Microsoft Paint                   |
| Microsoft.Windows.PowerShell.ISE    | PowerShell ISE                    |
| App.Support.QuickAssist             | Quick Assist                      |
| App.StepsRecorder                   | Steps Recorder                    |
| Media.WindowsMediaPlayer            | Windows Media Player              |
| Microsoft.Windows.WordPad           | WordPad                           |
| Microsoft-SnippingTool              | Snipping Tool                     |

### Registry Entries on Local Machine (localmachine.cmd)
- Bypasses Microsoft Account Creation
- Disables User Account Control
- Disables the lock screen
- Disable Windows Spotlight and set the normal Windows Picture as the desktop background
- Disable Windows Spotlight on the lock screen
- Disable Windows Spotlight suggestions, tips, tricks, and more on the lock screen
- Disable Windows Spotlight on Settings
- Set desktop background to a normal Windows picture
- Ensure the wallpaper style is set to fill (2 is for fill, 10 is for fit)
- Prevents Dev Home Installation
- Prevents New Outlook for Windows Installation
- Prevents Chat Auto Installation & Removes Chat Icon
- Start Menu Customization
- Enables the "Settings" and "File Explorer" Icon in the Start Menu
- Enable Long File Paths with Up to 32,767 Characters
- Disables News and Interests
- Disables Windows Consumer Features Like App Promotions etc.
- Disables Bitlocker Auto Encryption on Windows 11 24H2 and Onwards
- Sets Windows Update to Only Install Security Updates and Delay Other Updates for 2 Years
- Disables Cortana
- Disables Activity History
- Disables Hibernation
- Disables Location Tracking
- Disables Telemetry
- Disables Windows Ink Workspace
- Disables Feedback Notifications
- Disables the Advertising ID for All Users
- Disables Windows Error Reporting
- Disables Delivery Optimization
- Disables Remote Assistance
- Search Windows Update for Drivers First
- Gives Multimedia Applications like Games and Video Editing a Higher Priority
- Clears Memory Page File at Shutdown
- Enables NDU (Network Diagnostic Usage) Service on Startup
- Increases IRP stack size to 30 for the LanmanServer service to Improve Network Performance and Stability
- Hides the Meet Now Button on the Taskbar
- Gives Graphics Cards a Higher Priority for Gaming
- Gives the CPU a Higher Priority for Gaming
- Gives Games a higher priority in the system's scheduling
- Fix Managed by your organization in Edge
- Set Registry Keys to Disable Wifi-Sense
- Disables Storage Sense
- Disable Xbox GameDVR
- Disable Tablet Mode
- Always go to desktop mode on sign-in
- Disable "Use my sign-in info to automatically finish setting up my device after an update or restart"
- Disables OneDrive Automatic Backups of Important Folders (Documents, Pictures etc.)
- Disables the "Push To Install" feature in Windows
- Disables Consumer Account State Content
- Disables Cloud Optimized Content
- Deletes Microsoft Edge Registry Entries
- Deleting Application Compatibility Appraiser
- Deleting Customer Experience Improvement Program
- Deleting Program Data Updater
- Deleting autochk proxy
- Deleting QueueReporting

### Registry Entries for Default User and Current User (defaultuser.cmd & currentuser.cmd)
- Disabling the Delivery of Personalized or Suggested Content Like App Suggestions, Tips, and Advertisements in Windows
- Removes Copilot
- Removes Store Banner in Notepad
- Removes OneDrive
- Align the taskbar to the left on Windows 11
- Hides Search Icon on Taskbar
- Disables Recently Added Apps and Recommendations in the Start Menu
- Hides or Removes People from Taskbar
- Hides Task View Button on Taskbar
- Hides and Removes News and Interests from PC and Taskbar
- Hides or Removes Notifications
- Disables User Account Control
- Disables User Account Sync
- Disables Location Services
- Disables Input Personalization Settings
- Disables Automatic Feedback Sampling
- Disables Recent Documents Tracking
- Disable "Let websites provide locally relevant content by accessing my language list"
- Disables "Let Windows track app launches to improve Start and search results"
- Disables Background Apps
- Disables App Diagnostics
- Disables Delivery Optimization
- Disables Tablet Mode
- Disables Use Sign-In Info for User Account
- Disables Maps Auto Download
- Disables Telemetry and Ads
- Manages and displays the status of ongoing operations, such as file copy, move, delete, etc.
- Set File Explorer to Open This PC instead of Quick Access
- Set Display for Performance
- On Shutdown, Windows will automatically close any running applications
- Sets the Mouse hover time to 400 milliseconds
- Hides the Meet Now Button on the Taskbar
- Disables the Second Out-Of-Box Experience
- Set Display for Performance
- Set Registry Keys to Enable End Task With Right Click
- Disables Notification Tray and Calendar
- Set Classic Right-Click Menu for Windows 11
- Disable Xbox GameDVR
- Disables Bing Search in Start Menu
- Enables NumLock on Startup
- Disables Mouse Acceleration
- Disables Sticky Keys
- Disables Snap Assist Flyout
- Enables Show File Extensions
- Enables Dark Mode
- Hides the Language Switcher on the Taskbar
- Makes Taskbar Transparent in Windows 10
- Makes Taskbar Small in Windows 10
- Don't Update Last Access Time Stamp - This Can Improve File System Performance

### Various Windows Tweaks (wintweaks.ps1)
- Creates Desktop Shortcut for the Chris Titus Windows Utility So You Can Easily Launch it to Install Programs
- Hides the Language Switcher on the Taskbar
- Configure Maximum Password Age in Windows
- Allow Execution of PowerShell Script Files
- Groups or splits svchost.exe processes based on the amount of physical memory in the system to optimize performance
- Removes Microsoft Edge
- Removes OneDrive
- Removes Microsoft Teams
- Disables IPv6
- Disables Telemetry
- Disable Scheduled Tasks
- Enable the Ultimate Performance power plan
- Set the Ultimate Performance power plan as active
- Set Services to Manual:
  - AJRouter
  - ALG
  - AppIDSvc
  - AppMgmt
  - AppReadiness
  - AppXSvc
  - Appinfo
  - AxInstSV
  - BDESVC
  - BITS
  - BthAvctpSvc
  - BthHFSrv
  - CDPSvc
  - CertPropSvc
  - ClipSVC
  - ConsentUxUserSvc_*
  - CoreMessagingRegistrar
  - CscService
  - DcpSvc
  - DevQueryBroker
  - DeviceAssociationBrokerSvc_*
  - DeviceAssociationService
  - DeviceInstall
  - DevicePickerUserSvc_*
  - DevicesFlowUserSvc_*
  - DispBrokerDesktopSvc
  - DisplayEnhancementService
  - DmEnrollmentSvc
  - DoSvc
  - DsSvc
  - DsmSvc
  - EFS
  - EapHost
  - EntAppSvc
  - FDResPub
  - Fax
  - FrameServer
  - FrameServerMonitor
  - GraphicsPerfSvc
  - HomeGroupListener
  - HomeGroupProvider
  - HvHost
  - IEEtwCollectorService
  - IKEEXT
  - InstallService
  - InventorySvc
  - IpxlatCfgSvc
  - LicenseManager
  - LxpSvc
  - MSDTC
  - MSiSCSI
  - MapsBroker
  - McpManagementService
  - MessagingService_*
  - MicrosoftEdgeElevationService
  - MixedRealityOpenXRSvc
  - MsKeyboardFilter
  - NPSMSvc_*
  - NaturalAuthentication
  - NcaSvc
  - NcbService
  - NcdAutoSetup
  - NetSetupSvc
  - NgcCtnrSvc
  - NgcSvc
  - NlaSvc
  - P9RdrService_*
  - PNRPAutoReg
  - PNRPsvc
  - PcaSvc
  - PerceptionSimulation
  - Pla
  - Seclogon
  - Shpamsvc
  - Smphost
  - Spectrum
  - Sppsvc
  - Ssh-agent
  - Svsvc
  - Swprv
  - TabletInputService
  - TapiSrv
  - TextInputManagementService
  - TimeBroker
  - TimeBrokerSvc
  - TokenBroker
  - TroubleshootingSvc
  - TrustedInstaller
  - UI0Detect
  - UdkUserSvc_*
  - UmRdpService
  - UnistoreSvc_*
  - UserDataSvc_*
  - UsoSvc
  - VaultSvc
  - W32Time
  - WEPHOSTSVC
  - WFDSConMgrSvc
  - WMPNetworkSvc
  - WManSvc
  - WPDBusEnum
  - WSService
  - WSearch
  - WaaSMedicSvc
  - WalletService
  - WarpJITSvc
  - WbioSrvc
  - Wcmsvc
  - WcsPlugInService
  - WdNisSvc
  - WdiServiceHost
  - WdiSystemHost
  - WebClient
  - Wecsvc
  - WerSvc
  - WiaRpc
  - WinHttpAutoProxySvc
  - WinRM
  - WlanSvc
  - WpcMonSvc
  - WpnService
  - WpnUserService_*
  - WwanSvc
  - XblAuthManager
  - XblGameSave
  - XboxGipSvc
  - XboxNetApiSvc
  - Autotimesvc
  - Bthserv
  - Camsvc
  - Cbdhsvc_*
  - Cloudidsvc

# END

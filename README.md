# Memory’s Tech Tips’ Unattended Windows Installation

## Overview

Microsoft gives you the ability to add [Answer Files](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs?view=windows-11) (or Unattend files) to Windows Installation Media, which can be used to modify Windows Settings and Packages in the Windows Image (ISO) during the Windows Setup process.

If you’ve ever used Rufus to create Windows Installation Media, you might have seen options like “Remove Windows 11 Hardware Requirements” and “Disable Privacy Questions”. When you select those options, Rufus creates an answer file with your selected options and includes it on the installation media.

I've created a few of these answer files that I use to automate and streamline my Windows installs, and that’s what I’m sharing with you in this project. 
  - The answer files work on any edition (Home/Pro) of Windows 10 22H2 and Windows 11 23H2.
  - *Windows 11 24H2 will be tested once it's fully released.*

My motivation for this project is to get an “IoT-LTSC-Like” or even better experience on the Pro and Home versions of Windows 10 and Windows 11 without having to worry about getting an LTSC License or ISO file.
<br/>
<br/>

## Why should I use an Answer File?

### <ins>Security:</ins>
  - You can see all of the changes that will be made to the Windows Image by inspecting the answer file.
  - It runs on the Official Windows 10 or 11 ISO downloaded directly from Microsoft, no need to download edited ISO files from Unofficial sources.
  - It's not dependent on any third party tools and is an Official Microsoft Feature used to make Mass Windows Deployments easier.
### <ins>Automation:</ins>
  - When installing Windows on multiple computers, there's no need to manually configure settings and run scripts on each machine, which saves a lot of time (and effort).
<br/>

## What does Memory's UnattendedWinstall answer files do?

### <ins>Choose one of the following versions:</ins>
### [IoT-LTSC-Like](https://github.com/memstechtips/UnattendedWinstall/blob/main/IoT-LTSC-Like/autounattend.xml) / [arm64](https://github.com/memstechtips/UnattendedWinstall/blob/main/IoT-LTSC-Like/arm64/autounattend.xml)
### *Recommended for most people*
   - Includes most of the same Windows Packages as IoT-LTSC
     - (Windows Security, Edge, Notepad, Snipping Tool, Calculator, Paint, Legacy Windows Media Player) with added Microsoft Store.
   - Only Security updates are installed, others are delayed for 1 year (max period)
   - Includes better privacy settings and various other tweaks, view [CHANGELOG](https://github.com/memstechtips/UnattendedWinstall/blob/main/CHANGELOG.md) for a full list.
   - UAC is Disabled by Default to ensure the `currentuser.cmd` script executes correctly at first logon. If you use UAC, please enable it in Control Panel once you're in Windows.
<br/>

### [Standard](https://github.com/memstechtips/UnattendedWinstall/blob/main/Standard/autounattend.xml) / [arm64](https://github.com/memstechtips/UnattendedWinstall/blob/main/Standard/arm64/autounattend.xml)
### *This acts as a "Blank Canvas" where you can start from scratch and only install the software you want).*
   - ALL Windows Packages are removed except for Windows Security. Microsoft Edge (NOT on Win 10 after updates) and Microsoft Store are both removed.
   - Only Security updates are installed, others are delayed for 1 year (max period)
   - Includes better privacy settings and various other tweaks, view [CHANGELOG](https://github.com/memstechtips/UnattendedWinstall/blob/main/CHANGELOG.md) for a full list.
   - UAC is Disabled by Default to ensure the `currentuser.cmd` script executes correctly at first logon. If you use UAC, please enable it in Control Panel once you're in Windows.
<br/>

### [Core]() 
### *(coming sometime in the future)*
   - *Removal of Windows Security (Completely Barebones)*
<br/>

> [!IMPORTANT]
> If you want to install and use Adobe Creative Cloud then you need to reinstall Microsoft Edge or else the Adobe Installer won't run.
> 
> Open Windows Powershell as admin and run the following command to reinstall Microsoft Edge (or use the Chris Titus Windows Utility)
>```
>winget install -e --id Microsoft.Edge
>```
<br/>

I've taken the time to add descriptions to almost all of the tweaks in the answer files, and you can inspect them right here on GitHub.

Alternatively, you can download the answer file and use any one of the following programs to open it, inspect it and make changes to it if needed.  

- [Cursor](https://www.cursor.com/) (my favorite)
- [VSCode](https://code.visualstudio.com/)
- [Notepad++](https://notepad-plus-plus.org/downloads/)
<br/>

### <ins>In summary all of the files does the following:</ins>

- **Bypasses Windows 11 System Requirements**:
  - Adds registry entries to bypass TPM, Secure Boot, Storage, CPU, RAM, and Disk checks.

- **Debloats Windows**:
  - Removes preinstalled bloatware apps using PowerShell scripts.
  - Removes legacy apps using PowerShell scripts.

- **Registry Tweaks**:
  - Bypasses FORCED Microsoft Account creation durin Onboarding Experience.
  - Disables Windows Spotlight on Lock Screen.
  - Customizes Start Menu and Taskbar settings.
  - Disables various Windows features like Cortana, Telemetry, Hibernation, and Location Tracking.
  - Configures Windows Update to only install security updates and delay other updates for 1 year (max period).
  - Disables Windows Error Reporting, Update Delivery Optimization, and Windows Remote Assistance (not RDP).
  - Sets various performance and privacy-related registry keys.

- **Runs Custom Scripts**:
  - Loads and unloads the Default User registry hive to apply settings for new users.
  - Executes PowerShell and batch scripts to apply additional tweaks and remove specific applications like Microsoft Edge *(Standard & Core Only)*, OneDrive, and Teams.
> [!NOTE]
> Due to the removal of Microsoft Edge, I also include a Powershell Script on the Desktop called "LAUNCH-CTT-WINUTIL.ps1" 
    Make sure you are connected to the internet, then right click on this file and select Run with Powershell. It will launch the Chris Titus Tech Windows Utility and you can use that to install your browser of choice (even Edge) and any other software for that matter.
<br/>

- **Service Configurations**:
  - Sets numerous Windows services to manual or disabled to optimize performance.

- **Power Plan**:
  - Enables and sets the Ultimate Performance power plan as active.

- **Miscellaneous**:
  - Creates a desktop shortcut for Chris Titus Windows Utility. (Standard & Core Only)
  - Disables Teredo.
  - Disables various scheduled tasks related to telemetry and diagnostics.
  - Enables Dark Mode by default.
  - Aligns the Start Button in Windows 11 to the left by default.
  - Makes the Taskbar on Windows 10 Small and Transparent.
<br/>

### In addition to my tweaks, it contains elements and scripts from the following sources:

- Base Answer File generation:
  - [Schneegans Unattend Generator](https://schneegans.de/windows/unattend-generator/)
- Windows Tweaks & Optimizations:
  - [ChrisTitusTech WinUtil](https://github.com/ChrisTitusTech/winutil)
- Various Tweaks:
  - [Tiny11Builder](https://github.com/ntdevlabs/tiny11builder)
  - [Ten Forums](https://www.tenforums.com/)
  - [Eleven Forum](https://www.elevenforum.com/)
  - [Winaero Tweaker](https://winaerotweaker.com/)
<br/>

## Usage Instructions

In short, you need to include the `autounattend.xml` answer file on your Windows Installation Media so it can be read and executed during the Windows Setup. Here are a few ways to do it:
> [!CAUTION]
> The filename included on the root of the Windows Installation Media must be `autounattend.xml` or else it won't execute.
</br>

> [!NOTE]
> If the following instructions are unclear, [this video](https://youtu.be/JUTdRZNqODY) should help.
</br>

### <ins>Method 1: Create a Bootable Windows Installation Media</ins>

1. Download your preferred `autounattend.xml` file and save it on your computer.
2. Create a [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) Bootable Installation USB drive with the Media Creation Tool or [Rufus](https://rufus.ie/en/).
> [!IMPORTANT]
> When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience” as it creates another answer file, we don't want that.
3. Copy the `autounattend.xml` file you downloaded in Step 1 to the root of the Bootable Windows Installation USB you created in Step 2.
4. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.
</br>

### <ins>Method 2: Create a Custom ISO File</ins>

1. Download your preferred `autounattend.xml` file and save it on your computer.
2. Download the [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) ISO file depending on the version you want.
3. Download and Install [AnyBurn](https://anyburn.com/download.php)
   - In AnyBurn, select the “Edit Image File” option.
   - Navigate to and select the Official Windows ISO file you downloaded in Step 2.
   - Click on “Add” and select the `autounattend.xml` file you downloaded in Step 1 or just click and drag the `autounattend.xml` into the AnyBurn window.
   - Click on “Next,” then on “Create Now.” You should be prompted to overwrite the ISO file, click on “Yes.”
   - Once the process is complete, close AnyBurn.
4. Use the ISO file to Install Windows on a Virtual Machine OR use a program like [Rufus](https://rufus.ie/en/) or [Ventoy](https://github.com/ventoy/Ventoy) to create a bootable USB flash drive with the edited Windows ISO file.
> [!IMPORTANT]
> When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience” as it creates another answer file, we don't want that.
5. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.
</br>

## Conclusion

I hope these Unattended Windows Answer files helps streamline the Windows installation process as much as it has for me. Feel free to join my [Discord Community](https://www.discord.gg/zWGANV8QAX) or leave Your feedback and suggestions in the [Discussions](https://github.com/memstechtips/UnattendedWinstall/discussions) as they are always welcome! Also, if you find these scripts useful, consider giving this repository a star ⭐ on GitHub.

Happy installing!

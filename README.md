# Memory’s Tech Tips’ Unattended Windows Installation

## Overview

Microsoft gives you the ability to add [Answer Files](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs?view=windows-11) (or Unattend files) to Windows Installation Media, which can be used to modify Windows Settings and Packages in the Windows Image (ISO) during the Windows Setup process.

If you’ve ever used Rufus to create Windows Installation Media, you might have seen options like “Remove Windows 11 Hardware Requirements” and “Disable Privacy Questions”. When you select those options, Rufus creates an answer file with your selected options and includes it on the installation media.

I've created a few of these answer files that I use to automate and streamline my Windows installs, and that’s what I’m sharing with you in this project. 
  - The answer files work on any edition (Home/Pro) of Windows 10 22H2 and Windows 11 23H2.
  - *Windows 11 24H2 will be tested once it's fully released.*

My motivation for this project is to get an “IoT-LTSC-Like” or even better experience on the Pro and Home versions of Windows 10 and Windows 11 without having to worry about getting an LTSC License or ISO file.

> [!NOTE] 
> 
> I made these answer files to fit my needs, and they work great for me. They might not work for you, and that's okay. I can't help with every problem you might have. Check out the [Troubleshooting](https://github.com/memstechtips/UnattendedWinstall/blob/main/TROUBLESHOOTING.md) page for fixes to common "issues", or you can [create your own file](https://schneegans.de/windows/unattend-generator/) using these [video instructions.](https://youtu.be/WyLiJl-NQU8)
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

I've taken the time to add descriptions to almost all of the tweaks and registry entries in the answer files, and you can inspect them right here on GitHub. Alternatively, you can download the answer file and use a code editor like [Cursor](https://www.cursor.com/), [VSCode](https://code.visualstudio.com/) or [Notepad++](https://notepad-plus-plus.org/downloads/) to inspect it and make changes to it if needed.

### <ins>In addition to my tweaks, it contains elements and scripts from the following sources:</ins>

- Base Answer File generation:
  - [Schneegans Unattend Generator](https://schneegans.de/windows/unattend-generator/)
- Windows Tweaks & Optimizations:
  - [ChrisTitusTech WinUtil](https://github.com/ChrisTitusTech/winutil)
- Various Tweaks:
  - [Tiny11Builder](https://github.com/ntdevlabs/tiny11builder)
  - [Ten Forums](https://www.tenforums.com/)
  - [Eleven Forum](https://www.elevenforum.com/)
  - [Winaero Tweaker](https://winaerotweaker.com/)

### <ins>The Most Notable Tweaks & Registry Entries:</ins>

- Bypasses Windows 11 System Requirements.
- Removes Preinstalled Bloatware Apps.
- Bypasses FORCED Microsoft Account creation during Onboarding Experience.
- Disables Windows Spotlight.
- Disables Xbox GameDVR.
- Customizes Start Menu and Taskbar settings.
- Disables various Windows features like Cortana, Telemetry, and Location Tracking.
- Configures Windows Update to only install security updates and delay other updates for 1 year (max period).
- Disables Windows Error Reporting, Update Delivery Optimization, and Windows Remote Assistance (not RDP).
- Sets various performance and privacy-related registry keys, mostly found in the [ChrisTitusTech WinUtil](https://github.com/ChrisTitusTech/winutil).
- Enables and sets the Ultimate Performance power plan as active.
- Sets numerous Windows services to manual or disabled to optimize performance.
- Enables Dark Mode by default.
- Aligns the Start Button in Windows 11 to the left by default.
- Makes the Taskbar on Windows 10 Small and Transparent.
- Executes PowerShell and batch scripts to apply additional tweaks and remove specific applications like Microsoft Edge *(Standard & Core Only)*, OneDrive, and Teams.
> [!NOTE]
>  Due to the removal of Microsoft Edge, I also include a Powershell Script on the Desktop called "LAUNCH-CTT-WINUTIL.ps1" <br/> 
>  - Make sure you are connected to the internet, then right click on this file and select Run with Powershell. <br/>
>  - Accept the UAC prompt and it will launch the Chris Titus Tech Windows Utility and you can use that to install your browser of choice (even Edge) and any other software for that matter.
<br/>

## Usage Instructions

### <ins>Choose one of the following versions:</ins> <br/> 
*32bit, 64bit and arm64 is supported on all versions.*
### [**IoT-LTSC-Like**](https://github.com/memstechtips/UnattendedWinstall/blob/main/IoT-LTSC-Like/autounattend.xml)
### *Recommended for most people*
   - Includes most of the same Windows Packages as the official IoT-LTSC version of Windows:
     - (Windows Security, Edge, Notepad, Snipping Tool, Calculator, Paint, Legacy Windows Media Player) with added Microsoft Store.
   - Only Security updates are installed, others are delayed for 1 year (max period)
   - Includes better privacy settings and various other tweaks, view [CHANGELOG](https://github.com/memstechtips/UnattendedWinstall/blob/main/CHANGELOG.md) for a full list.
<br/>

### [**Standard**](https://github.com/memstechtips/UnattendedWinstall/blob/main/Standard/autounattend.xml)
### *This acts as a "Blank Canvas" where you can start from scratch and only install the software you want.*
   - ALL Windows Packages are removed except for Windows Security which is ENABLED. <br/> Microsoft Edge and the Microsoft Store are both removed. (Edge might reappear after the latest update on Windows 10.)
   - Only Security updates are installed, others are delayed for 1 year (max period)
   - Includes better privacy settings and various other tweaks, view [CHANGELOG](https://github.com/memstechtips/UnattendedWinstall/blob/main/CHANGELOG.md) for a full list.
<br/>

### [**Core**](https://github.com/memstechtips/UnattendedWinstall/blob/main/Core/autounattend.xml) 
### *Same as Standard with Windows Defender Disabled.*<br/>
   <ins>*(I won't release a version that completely removes Windows Security, so please stop asking.)*</ins>
   - Windows Defender is DISABLED by default by disabling the following services: "Sense, WdBoot, WdFilter, WdNisDrv, WdNisSvc, WinDefend" which in turns prevents the MsMpEng.exe process from running.<br/>Source: [Schneegans](https://schneegans.de/windows/unattend-generator/)
   - ALL Windows Packages are removed except for Windows Security which is DISABLED. 
   <br/> Microsoft Edge and the Microsoft Store are both removed. (Edge might reappear after the latest update on Windows 10.)
   - Only Security updates are installed, others are delayed for 1 year (max period)
   - Includes better privacy settings and various other tweaks, view [CHANGELOG](https://github.com/memstechtips/UnattendedWinstall/blob/main/CHANGELOG.md) for a full list.
<br/>


## <ins>**Installing Windows with an Answer File**</ins>
In short, you need to include the `autounattend.xml` answer file on your Windows Installation Media so it can be read and executed during the Windows Setup. Here are a few ways to do it:

> [!NOTE]<br/>
> - The filename included on the root of the Windows Installation Media must be `autounattend.xml` or else it won't execute.
<br/>

### <ins>Method 1: Create a Bootable Windows Installation Media</ins> - [Video Tutorial](https://youtu.be/pDEZDD_gEbo)

1. Download your preferred `autounattend.xml` file and save it on your computer.
2. Create a [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) Bootable Installation USB drive with [Rufus](https://rufus.ie/en/) or the Media Creation Tool. 
> [!IMPORTANT]<br/>
> - Some users have reported issues with the Media Creation Tool when creating the Windows Installation USB. Use it at your own discretion. <br/>
> - When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience” as it creates another `autounattend.xml` file that might overwrite settings in the UnattendedWinstall file.
3. Copy the `autounattend.xml` file you downloaded in Step 1 to the root of the Bootable Windows Installation USB you created in Step 2.
4. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.
</br>

### <ins>Method 2: Create a Custom ISO File</ins> - [Video Tutorial](https://youtu.be/pDEZDD_gEbo?si=ChEGghEOLCyLSnp7&t=1117)

1. Download your preferred `autounattend.xml` file and save it on your computer.
2. Download the [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) ISO file depending on the version you want.
3. Download and Install [AnyBurn](https://anyburn.com/download.php)
   - In AnyBurn, select the “Edit Image File” option.
   - Navigate to and select the Official Windows ISO file you downloaded in Step 2.
   - Click on “Add” and select the `autounattend.xml` file you downloaded in Step 1 or just click and drag the `autounattend.xml` into the AnyBurn window.
   - Click on “Next,” then on “Create Now.” You should be prompted to overwrite the ISO file, click on “Yes.”
   - Once the process is complete, close AnyBurn.
4. Use the ISO file to Install Windows on a Virtual Machine OR use a program like [Rufus](https://rufus.ie/en/) or [Ventoy](https://github.com/ventoy/Ventoy) to create a bootable USB flash drive with the edited Windows ISO file.
> [!IMPORTANT]<br/>
> - When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience” as it creates another `autounattend.xml` file that might overwrite settings in the UnattendedWinstall file.
5. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.
</br>

### <ins>Method 3: Use Ventoy Auto Install Plugin</ins> - [Video Tutorial](https://youtu.be/4AGZQJTyCOs)

1. Download your preferred `autounattend.xml` file and save it on your computer.
2. Download the [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) ISO file, depending on the version you want.
3. Download and install [Ventoy](https://github.com/ventoy/Ventoy) to your desired USB flash drive. 
4. Prepare the folder structure:
    - In your newly created Ventoy USB disk, create the following folders: `ISO` and `Templates`. <br/> *They should be at the root of the drive.*
    - Inside of the `ISO` folder, create a new folder called `Windows`.
    - Copy your Windows ISO files in the `ISO\Windows` folder.
    - Copy your `autounattend.xml` into the `Templates` folder.
5. Start VentoyPlugson. Depending on your OS, the steps might differ.
    - On Windows, run the `VentoyPlugson.exe` file.
    - A new browser window should open up with a Ventoy web interface ready to go.
    - Select the `Auto Install Plugin` menu from the list.
    - Click on the `Add` button.
    - Select [parent] to make the whole Windows ISO folder benefit from the plugin.
    - In the Directory Path, paste in the absolute path to your `ISO` folder. </br> example: `F:\ISO\Windows` (Replace `F` with your drive letter.)
    - In the Template Path, paste in the absolute path to your `autounattend.xml` file. </br> example: `F:\Templates\autounattend.xml` (Replace `F` with your drive letter.) <br/> (PSA: If you have more `autounattend.xml` files, you can add them later on!)
    - Click on `OK` and you should see a message saying that the configuration has been saved successfully.
    - Close the VentoyPlugson browser window and stop the VentoyPlugson application.
6. Boot from the Ventoy USB drive in the computer where you want to install windows.
   - After selecting a Windows ISO to boot from, you will be prompted to boot with the `/Templates/autounattend.xml` file.
   - Select that option and the `autounattend.xml` will be automatically executed during installation.
</br>

## FAQ

### How do I get the same experience on an existing version of Windows?
  - Use the [Chris Titus Tech Windows Utility](https://github.com/ChrisTitusTech/winutil) - [Video Tutorial](https://youtu.be/pldFPTnOCGM)

### Can I use the answer file with an in-place Upgrade?
  - No.

### Windows is Updating Automatically, I thought it's Disabled?
  - Feature updates (bloatware updates) are delayed for a year. Security and Driver updates still function normally.


## Conclusion

I hope these Unattended Windows Answer files helps streamline the Windows installation process as much as it has for me. Feel free to join my [Discord Community](https://www.discord.gg/zWGANV8QAX) or leave Your feedback and suggestions in the [Discussions](https://github.com/memstechtips/UnattendedWinstall/discussions) as they are always welcome! Also, if you find these scripts useful, consider giving this repository a star ⭐ on GitHub and if you want to support the project, consider donating on [PayPal.](https://paypal.me/memstech)

Happy installing!

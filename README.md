# UnattendedWinstall

## Introduction

UnattendedWinstall leverages Microsoft's [Answer Files](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs?view=windows-11) (or Unattend files) to automate and customize Windows installations. It allows uninstallation of Windows Apps and Features and changes to Windows Settings during the Windows setup process.

### Why Use an Answer File?

- Provides transparency by allowing inspection of all changes in the answer file.
- Runs directly on official Windows ISOs from Microsoft, eliminating the need for unofficial sources.
- Utilizes a Microsoft-supported feature designed for streamlined mass deployment of Windows installations.
- Enables automated configuration across multiple devices, saving time and effort by eliminating repetitive manual setups. 

</br>

> [!NOTE]
> UnattendedWinstall has been tested and optimized for personal use. For those unsatisfied or interested in customizing further, consider creating your own answer file using: </br> - [Winhance Unattend Generator](https://github.com/memstechtips/Winhance) following [this video guide](https://youtu.be/lrq3ph3xi50). </br> - [Schneegans Unattend Generator](https://schneegans.de/windows/unattend-generator/) following [this video guide](https://youtu.be/WyLiJl-NQU8).

### Versions

[![Version 3 Release (Latest)](https://img.shields.io/badge/Version-3.0.0%20Latest-0078D4?style=for-the-badge&logo=github&logoColor=white)](https://github.com/memstechtips/UnattendedWinstall/releases/tag/v3.0.0)
[![Version 2 Release](https://img.shields.io/badge/Version-2.1.0-0078D4?style=for-the-badge&logo=github&logoColor=white)](https://github.com/memstechtips/UnattendedWinstall/releases/tag/v2.1.0)
[![Version 1 Release](https://img.shields.io/badge/Version-1.0.0-FFA500?style=for-the-badge&logo=github&logoColor=white)](https://github.com/memstechtips/UnattendedWinstall/releases/tag/v1.0.0)

### Support the Project

If UnattendedWinstall has been useful to you, consider supporting the project, it really does help!

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/memstechtips)
[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/memstech)

### Feedback and Community

If you have feedback, suggestions, or need help with UnattendedWinstall, please feel free to join the discussion on GitHub or our Discord community:

[![Join the Discussion](https://img.shields.io/badge/Join-the%20Discussion-2D9F2D?style=for-the-badge&logo=github&logoColor=white)](https://github.com/memstechtips/UnattendedWinstall/discussions)
[![Join Discord Community](https://img.shields.io/badge/Join-Discord%20Community-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://www.discord.gg/zWGANV8QAX)

## Requirements

- Windows 10 or Windows 11  
  - *(Tested on Windows 10 22H2 & Windows 11 23H2, 24H2 and 25H2)*
  - *(32-bit, 64-bit and arm64 is supported)*

## What Does UnattendedWinstall Do?

The UnattendedWinstall answer file comes with detailed descriptions for nearly all configurations and registry tweaks, which are available for inspection here on GitHub. For customization, download the answer file and open it in editors like [Cursor](https://www.cursor.com/) or [VSCode](https://code.visualstudio.com/).

### Key Features

- Ability to choose Windows Edition (Unless Windows setup detects key in UEFI BIOS)
- Bypasses Windows 11 system requirements
- Skips forced Microsoft account creation during Windows setup
- Removes all preinstalled bloatware apps except Notepad, Calculator, Paint and Snipping Tool.
  - Copilot, OneDrive and Edge are removed along with all other UWP apps.
  - Recall is disabled.
- Applies the following Optimizations:
  - Privacy & Security (Disables telemetry and ads)
  - Power Settings (Imports and applies the Winhance Power Plan for better performance)
  - Gaming & Performance (Applies settings and visual effects to improve performance, sets unneeded services to manual, disables unneeded scheduled tasks)
  - Windows Updates (Disables auto updates and configures Windows Update to notify of available security updates only)
  - Notifications (Disables all notifications except if related to privacy and security)
  - Sound (Disables startup sound during boot, sets audio ducking preference to 'Do Nothing')
- Applies the following Customizations:
  - Windows Theme (Sets Dark Mode by default, disables transparency effects)
  - Taskbar (Hides search, task view and widget icons, aligns to the left on Windows 11)
  - Start Menu (Unpins all items from start menu, Disables Bing search results in start)
  - Explorer (Applies Classic Context Menu, opens File Explorer to this PC, shows file extensions, hides Home and Gallery folders in Navigation Pane and much more)

> [!TIP]
> Use [Winhance](https://winhance.net/) once Windows is installed *(can be installed using the 'Install Winhance' desktop shortcut)* to install software, re-apply or revert settings and manage your Windows apps and settings.
>
> It can also be used to achieve the same experience UnattendedWinstall provides on an existing Windows installation without reinstalling Windows, see [this video](https://youtu.be/lrq3ph3xi50) for more info.

## Usage Instructions

To use an answer file, include `autounattend.xml` at the root of your Windows Installation Media to be executed during Windows setup.

> [!IMPORTANT]  
> Ensure the answer file is named `autounattend.xml`; otherwise, it won’t be recognized by the installer.

---

### Using Memory's WIMUtil in Winhance (Highly Preferred)

To use **WIMUtil**, follow these steps:

1. Download and install Winhance from [Winhance.net](https://winhance.net/) or [GitHub](https://github.com/memstechtips/Winhance/releases/latest).

2. Launch Winhance, click on the "Advanced Tools" navigation button (bottom left) and select WIMUtil.

Once launched, **WIMUtil** guides you through a wizard:

1. **Select or Download Windows ISO**
2. **Add Latest UnattendedWinstall Answer File Automatically, create one with Winhance or select your own file**
3. **Extract and Add Current Device Drivers to Installation Media**
4. **Create New ISO with Customizations Included**

Once the ISO file is created:

1. **Create a Bootable USB Flash Drive with [Ventoy](https://github.com/ventoy/Ventoy)**
2. **Copy the New ISO File to the Ventoy Flash Drive**
3. **Boot from the USB flash drive, choose your ISO & Install Windows**

For more info, check out the full [video guide](https://youtu.be/lrq3ph3xi50?t=3477).

---

### Other Methods
#### Method 1: Create a Bootable Windows Installation USB

- [Video Tutorial](https://youtu.be/pDEZDD_gEbo)

<details>
  <summary>Click to Show Instructions</summary>

  1. Download the `autounattend.xml` file and save it on your computer.
  2. Create a [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) Bootable Installation USB drive with [Rufus](https://rufus.ie/en/) or the Media Creation Tool.
  
     > **Important**  
     > - Some users have reported issues with the Media Creation Tool when creating the Windows Installation USB. Use it at your own discretion.  
     > - When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience,” as it creates another `autounattend.xml` file that might overwrite settings in the UnattendedWinstall file.

  3. Copy the `autounattend.xml` file you downloaded in Step 1 to the root of the Bootable Windows Installation USB you created in Step 2.
  4. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.

</details>

#### Method 2: Create a Custom ISO File

- [Video Tutorial](https://youtu.be/pDEZDD_gEbo?si=ChEGghEOLCyLSnp7&t=1117)

<details>
  <summary>Click to Show Instructions</summary>

  1. Download the `autounattend.xml` file and save it on your computer.
  2. Download the [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) ISO file depending on the version you want.
  3. Download and install [AnyBurn](https://anyburn.com/download.php)
     - In AnyBurn, select the “Edit Image File” option.
     - Navigate to and select the Official Windows ISO file you downloaded in Step 2.
     - Click on “Add” and select the `autounattend.xml` file you downloaded in Step 1, or just click and drag the `autounattend.xml` into the AnyBurn window.
     - Click on “Next,” then on “Create Now.” You should be prompted to overwrite the ISO file; click on “Yes.”
     - Once the process is complete, close AnyBurn.
  4. Use the ISO file to install Windows on a Virtual Machine OR use a program like [Rufus](https://rufus.ie/en/) or [Ventoy](https://github.com/ventoy/Ventoy) to create a bootable USB flash drive with the edited Windows ISO file.

  > **Important**  
  >
  > - When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience,” as it creates another `autounattend.xml` file that might overwrite settings in the UnattendedWinstall file.

  5. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.

</details>

#### Method 3: Use Ventoy Auto Install Plugin

- [Video Tutorial](https://youtu.be/4AGZQJTyCOs)

<details>
  <summary>Click to Show Instructions</summary>

  1. Download the `autounattend.xml` file and save it on your computer.
  2. Download the [Windows 10](https://www.microsoft.com/en-us/software-download/windows10) or [Windows 11](https://www.microsoft.com/en-us/software-download/windows11) ISO file, depending on the version you want.
  3. Download and install [Ventoy](https://github.com/ventoy/Ventoy) to your desired USB flash drive.
  4. Prepare the folder structure:
      - In your newly created Ventoy USB disk, create the following folders: `ISO` and `Templates`. </br> *They should be at the root of the drive.*
      - Inside of the `ISO` folder, create a new folder called `Windows`.
      - Copy your Windows ISO files in the `ISO\Windows` folder.
      - Copy your `autounattend.xml` into the `Templates` folder.
  5. Start VentoyPlugson. Depending on your OS, the steps might differ.
      - On Windows, run the `VentoyPlugson.exe` file.
      - A new browser window should open up with a Ventoy web interface ready to go.
      - Select the `Auto Install Plugin` menu from the list.
      - Click on the `Add` button.
      - Select [parent] to make the whole Windows ISO folder benefit from the plugin.
      - In the Directory Path, paste in the absolute path to your `Windows` folder. </br> example: `F:\ISO\Windows` (Replace `F` with your drive letter.)
      - In the Template Path, paste in the absolute path to your `autounattend.xml` file. </br> example: `F:\Templates\autounattend.xml` (Replace `F` with your drive letter.) </br> (PSA: If you have more `autounattend.xml` files, you can add them later on!)
      - Click on `OK` and you should see a message saying that the configuration has been saved successfully.
      - Close the VentoyPlugson browser window and stop the VentoyPlugson application.
  6. Boot from the Ventoy USB drive in the computer where you want to install windows.
     - After selecting a Windows ISO to boot from, you will be prompted to boot with the `/Templates/autounattend.xml` file.
     - Select that option and the `autounattend.xml` will be automatically executed during installation.

</details>

## FAQ

### How can I apply these settings to an existing Windows installation?

- Use [Winhance](https://winhance.net/), it contains the same settings as UnattendedWinstall. You can watch the full [Video Guide](https://youtu.be/lrq3ph3xi50) for more info.

### Can this answer file be used for an in-place upgrade?

- No, in-place upgrades do not support answer files.

### Why is Windows still updating automatically?

- Feature updates are delayed for a year; however, security and driver updates continue as usual. If you want to completely disable updates, use [Winhance](https://winhance.net/). You can watch the full [Video Guide](https://youtu.be/lrq3ph3xi50) for more info.

### Why don't I have internet after installing Windows?

<details>
  <summary>Click to Show Instructions</summary>
  </br>
  If you’re unable to connect to the internet after installation, it’s likely because your Wi-Fi or LAN (Ethernet) drivers are missing. Windows sometimes doesn’t include all necessary drivers for network adapters, especially if they’re specific to your device.

  To resolve this, follow these steps:

  1. **Download your network driver** from the manufacturer’s website on another computer with internet access. Look for Wi-Fi or LAN drivers specific to your device model.
  2. **Transfer the driver** to your Windows installation via USB drive.
  3. **Install the driver** on your Windows system and restart if necessary.

  After installation, you should be able to connect to the internet.

  > [!TIP] </br>
  > You can use WIMUtil in [Winhance](https://winhance.net/) to extract and add the drivers from your current operating system to the Windows installation media. These drivers should then be installed automatically during the Windows installation process, preventing any internet connection issues.

</details>

### How can I access the previous "IoT-LTSC-Like," "Standard," and "Core" versions of the file(s)?

  - You still have access to the previous files here: 
    - [Version 2.1.0 Release](https://github.com/memstechtips/UnattendedWinstall/releases/tag/v2.1.0)
    - [Version 1.0.0 Release](https://github.com/memstechtips/UnattendedWinstall/releases/tag/v1.0.0)

  > [!NOTE]  
  > For v1.0.0 you need to download the `Source Code.zip` file. Once extracted, you’ll have access to all the previous v1.0.0 files.

### How can I access the `UWScript.ps1` file that was in V2.1.0?

  - You still have access to the file here, under 'Assets' at the bottom of the page:  
    - [Version 2.1.0 Release](https://github.com/memstechtips/UnattendedWinstall/releases/tag/v2.1.0)

### How can I add my own Registry Tweaks to v3.0.0 of the `autounattend.xml` file?

<details>
  <summary>Click to Show Instructions</summary>
  </br>
  You can add your own registry entries or PowerShell code to v3.x.x of the XML file. Here's a brief explanation.

  #### System Wide Code

  For registry entries or PowerShell Code that can be applied system wide (HKEY_LOCAL_MACHINE or HKEY_CLASSES_ROOT), find this section of the file:


  `# ADD YOUR SYSTEM WIDE POWERSHELL SCRIPT CONTENTS BELOW`
  
  `# Start here`

  `# End here`

  Add the code between the `# Start here` and `# End here` lines.

  #### User Specific Code

  For registry entries or PowerShell Code that should be applied to the user profile (HKEY_CURRENT_USER), find this section of the file:


  `# ADD YOUR USER SPECIFIC POWERSHELL SCRIPT CONTENTS BELOW`
  
  `# Start here`

  `# End here`

  Add the code between the `# Start here` and `# End here` lines.

  > [!IMPORTANT]</br>
  > The code that is added to the file must be valid PowerShell code, or else the script will fail and no changes will be made to Windows.

</details>



# UnattendedWinstall

## Introduction

UnattendedWinstall leverages Microsoft's [Answer Files](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs?view=windows-11) (or Unattend files) to automate and customize Windows installations. It enables modifications to Windows Settings and Packages directly in the Windows ISO during setup.

### Why Use an Answer File?

#### Security

- Provides transparency by allowing inspection of all changes in the answer file.
- Runs directly on official Windows ISOs from Microsoft, eliminating the need for unofficial sources.
- Utilizes a Microsoft-supported feature designed for streamlined mass deployment of Windows installations.

#### Automation

- Enables automated configuration across multiple devices, saving time and effort by eliminating repetitive manual setups.

> **Note**  
> UnattendedWinstall has been tested and optimized for personal use. For those interested in customizing further, [create your own answer file](https://schneegans.de/windows/unattend-generator/) following [this video guide](https://youtu.be/WyLiJl-NQU8).

### Support the Project

If UnattendedWinstall has been useful to you, consider supporting the project, it really does help!

[![Support via PayPal](https://img.shields.io/badge/Support-via%20PayPal-yellow?logo=paypal)](https://paypal.me/memstech)

### Feedback and Community

If you have feedback, suggestions, or need help with UnattendedWinstall, please feel free to join the discussion on GitHub or our Discord community:

[![Join the Discussion](https://img.shields.io/badge/Join-the%20Discussion-blue?logo=github&logoColor=white)](https://github.com/memstechtips/UnattendedWinstall/discussions)
[![Join Discord Community](https://img.shields.io/badge/Join-Discord%20Community-5865F2?logo=discord&logoColor=white)](https://www.discord.gg/zWGANV8QAX)

## Requirements

- Windows 10 or Windows 11  
  - *(Tested on Windows 10 22H2 & Windows 11 24H2)*
  - *(32-bit, 64-bit and arm64 is supported)*

## What Does UnattendedWinstall Do?

The UnattendedWinstall answer file come with detailed descriptions for nearly all configurations and registry tweaks, which are available for inspection here on GitHub. For customization, download the answer file and open it in editors like [Cursor](https://www.cursor.com/) or [VSCode](https://code.visualstudio.com/).

### Sources and Contributions

<details>
  <summary>Click to Show</summary>

- **Base Answer File Generation**:
  - [Schneegans Unattend Generator](https://schneegans.de/windows/unattend-generator/)
- **Tweaks & Optimizations**:
  - [ChrisTitusTech WinUtil](https://github.com/ChrisTitusTech/winutil)
  - [FR33THY's Ultimate Windows Optimization Guide](https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide)
- **Additional Tweaks**:
  - [Tiny11Builder](https://github.com/ntdevlabs/tiny11builder)
  - [Ten Forums](https://www.tenforums.com/)
  - [Eleven Forum](https://www.elevenforum.com/)
  - [Winaero Tweaker](https://winaerotweaker.com/)

</details>

### Key Features

- Windows 10/11 Pro is installed by default
- Bypasses Windows 11 system requirements
- Disables Windows Defender services by default
  - *prompted to enable after Windows installation*
- Disables User Account Control by default
  - *prompted to enable after Windows installation*
- Allows execution of PowerShell scripts by default
- Skips forced Microsoft account creation during Windows setup
- Removes preinstalled bloatware apps except Microsoft Edge, Notepad and Calculator
  - Copilot and Recall is Disabled.
- Sets privacy-related registry keys to disable telemetry
- Limits Windows Update to install only security updates for one year
- Optimizes registry with various optimization and customization-related keys
  - *See the "Set-RecommendedHKLMRegistry" and "Set-RecommendedHKCURegistry" functions for more information*
- Disables unnecessary scheduled tasks
- Configures Windows services for optimal performance
- Enables the Ultimate Performance power plan

> **Note**  
> Use the `UWScript.ps1` file once Windows is installed to reapply or revert settings in case Windows Update resets some of the settings or if you encounter any issues.  
> It can also be used to achieve a similar experience to UnattendedWinstall on an existing Windows installation without reinstalling Windows.
>
> ---
>
> **Before Running the Script**
>
> Ensure you open PowerShell as an administrator. Additionally, set the execution policy to allow script execution by running the following command:
>
> ```powershell
> Set-ExecutionPolicy RemoteSigned
> ```
>
> Running PowerShell with elevated permissions and enabling script execution will ensure that `UWScript.ps1` can apply the necessary system changes.

## Usage Instructions

### Installing Windows with an Answer File

To use an answer file, include `autounattend.xml` at the root of your Windows Installation Media to be executed during Windows setup.

> **Note**  
> Ensure the answer file is named `autounattend.xml`; otherwise, it won’t be recognized by the installer.

> **Note**  
> You can back up your drivers prior to installation to ensure they’re readily available:
>
> <details>
>   <summary>Click to Show Instructions</summary>
>
> 1. **Create a folder named `Drivers` on your C: drive.**
>
> 2. **Backup your current Windows drivers to the `C:` drive** by running the following command in Command Prompt as Administrator:
>
>      ```bash
>      dism /online /export-driver /destination:C:\Drivers
>      ```
>
> 3. **Plug your USB drive/installation media into your computer.**
>
> 4. **Create a folder named `$WinpeDriver$` on your USB drive.**
>
> 5. **Copy the drivers you want to install automatically** from `C:\Drivers` to `D:\$WinpeDriver$` **assuming `D:` is your USB drive.**
>
> </details>

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
      - In the Directory Path, paste in the absolute path to your `Windows` folder. </br> example: `F:\ISO\Windows` (Replace `F` with your drive letter.)
      - In the Template Path, paste in the absolute path to your `autounattend.xml` file. </br> example: `F:\Templates\autounattend.xml` (Replace `F` with your drive letter.) <br/> (PSA: If you have more `autounattend.xml` files, you can add them later on!)
      - Click on `OK` and you should see a message saying that the configuration has been saved successfully.
      - Close the VentoyPlugson browser window and stop the VentoyPlugson application.
  6. Boot from the Ventoy USB drive in the computer where you want to install windows.
     - After selecting a Windows ISO to boot from, you will be prompted to boot with the `/Templates/autounattend.xml` file.
     - Select that option and the `autounattend.xml` will be automatically executed during installation.

</details>

## FAQ

### How can I apply these settings to an existing Windows installation?

- Run the `UWScript.ps1` file or use the [Chris Titus Tech Windows Utility](https://github.com/ChrisTitusTech/winutil) ([Video](https://youtu.be/pldFPTnOCGM)).

### Can this answer file be used for an in-place upgrade?

- No, in-place upgrades do not support answer files.

### Why is Windows still updating automatically?

- Feature updates are delayed for a year; however, security and driver updates continue as usual.

### Why don't I have internet after installing Windows?

<details>
  <summary>Click to Show Instructions</summary>

  If you’re unable to connect to the internet after installation, it’s likely because your Wi-Fi or LAN (Ethernet) drivers are missing. Windows sometimes doesn’t include all necessary drivers for network adapters, especially if they’re specific to your device.

  To resolve this, follow these steps:

  1. **Download your network driver** from the manufacturer’s website on another computer with internet access. Look for Wi-Fi or LAN drivers specific to your device model.
  2. **Transfer the driver** to your Windows installation via USB drive.
  3. **Install the driver** on your Windows system and restart if necessary.

  After installation, you should be able to connect to the internet.

</details>

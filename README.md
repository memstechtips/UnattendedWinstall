# Memory’s Tech Tips’ Unattended Windows Installation Scripts

## Overview
Microsoft allows you to add Answer Files (or Unattend files) to Windows ISO files, which can be used to modify Windows settings in the Windows Image (ISO) during the Windows Setup process.

If you’ve ever used Rufus to create Windows installation media, and you saw options like “Remove Windows 11 Hardware Requirements” and “Disable Privacy Questions,” they achieve that by including an Answer file in the installation media.

More info on Answer files can be found here: [Microsoft Docs on Answer Files](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs?view=windows-11)

I have created a few of these answer files that I use to automate and streamline my Windows installs, and that’s what I’m sharing here with you. These answer files work on both Windows 10 and Windows 11, and I’ve tested them on the Pro versions of Windows 10 22H2 and Windows 11 23H2 without any issues.

My motivation for this project is to get an “LTSC-like” or even better experience on the Pro and Home versions of Windows 10 and 11 without having to run a bunch of programs and scripts every time I do a fresh install of Windows. It’s already automated for me and saves me a ton of time.

The best thing about these answer files is that it’s very safe to use because you use the Official Windows 10 or 11 ISO directly from Microsoft, and you can see every single change it will make to the Windows Image by inspecting the answer file.

In addition to the tweaks I added to these answer files, they also contain elements and scripts from the following sources:
- Base Answer File generation: [Schneegans Unattend Generator](https://schneegans.de/windows/unattend-generator/)
- Windows Tweaks & Optimizations: [ChrisTitusTech WinUtil](https://github.com/ChrisTitusTech/winutil)
- Various Tweaks:
  - [Tiny11Builder](https://github.com/ntdevlabs/tiny11builder)
  - [Ten Forums](https://www.tenforums.com/)
  - [Eleven Forum](https://www.elevenforum.com/)
  - [Winaero Tweaker](https://winaerotweaker.com/)

I have taken the time to add descriptions to almost all of the tweaks in these unattended answer files, and you can use programs like VSCode, Notepad++, or Cursor (my favorite) to open the file and make changes to it:
- [VSCode](https://code.visualstudio.com/)
- [Notepad++](https://notepad-plus-plus.org/downloads/)
- [Cursor](https://www.cursor.com/)

If I have included something in the answer file you don’t want in your Windows installation, just edit the .xml file with one of these programs, delete the specific line of code, and save it again—hopefully, it still works.

Additionally, you can also add more tweaks or customizations, but only do this if you have the know-how. I will not provide any form of support for any changes you make to these files.

## Choosing an Answer File
It’s impossible for me to create a single answer file that will be perfect and please everybody, so I have a few versions you can choose from to get you started.

### LTSC-like
This version is the closest to the LTSC version of Windows in terms of what you get from the Windows experience. Obviously, it doesn’t have extended security updates like LTSC, but all of the bloat that’s been removed resembles that of the LTSC versions. It still includes Microsoft Edge and a few pre-installed apps that are included in the LTSC versions.

### Main
This version is the most debloated of all and removes almost every Windows package, including the removal of Microsoft Edge and the Microsoft Store. Windows Security is still included as I don’t recommend removing it and probably never will.
Also, because there is no browser preinstalled, I also include a Powershell Script on the Desktop called "LAUNCH-CTT-WINUTIL.ps1" - Make sure you are connected to the internet, then right click on this file and select Run with Powershell. 
It will launch the Chris Titus Tech Windows Utility and you can use that to install your browser of choice and any other software for that matter. 

### Memory's
This is the version I personally use. It doesn’t remove all of the Windows packages like in the Main version; some of them are kept, like Notepad, Calculator, Snipping Tool, etc. 
Microsoft Edge and the Microsoft Store are still removed because I don’t use them. Windows Security is included as I don’t recommend removing it and probably never will.
Also, because there is no browser preinstalled, I also include a Powershell Script on the Desktop called "LAUNCH-CTT-WINUTIL.ps1" - Make sure you are connected to the internet, then right click on this file and select Run with Powershell. 
It will launch the Chris Titus Tech Windows Utility and you can use that to install your browser of choice and any other software for that matter. 

## Usage Instructions
In short, you need to include the autounattended.xml answer file on your Windows Installation Media so it can be read and executed during the Windows Setup. Here are a few ways to do it.

If these instructions are unclear, maybe this video will help:

### Method 1: Create Bootable Windows Installation Media
1. Choose ONE of the autounattended.xml files I created and download it to your computer.
2. Create a Windows 10 or 11 Bootable Installation USB drive with the Media Creation Tool or Rufus, for example. (When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience”)
   - Windows 10: [Download Windows 10](https://www.microsoft.com/en-us/software-download/windows10)
   - Windows 11: [Download Windows 11](https://www.microsoft.com/en-us/software-download/windows11)
   - Rufus: [Rufus](https://rufus.ie/en/)
3. Copy the autounattended.xml file you downloaded in Step 1 to the root of the Bootable Windows Installation USB you created in Step 2.
4. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.

### Method 2: Create Custom ISO File
1. Choose ONE of the autounattended.xml files I created and download it to your computer.
2. Download the Windows 10 or Windows 11 ISO file depending on the version you want.
   - Windows 10: [Download Windows 10](https://www.microsoft.com/en-us/software-download/windows10)
   - Windows 11: [Download Windows 11](https://www.microsoft.com/en-us/software-download/windows11)
3. Download and Install AnyBurn: [AnyBurn](https://anyburn.com/download.php)
   - In AnyBurn, select the “Edit Image File” option.
   - Navigate to and select the Official Windows ISO file you downloaded in Step 2.
   - Click on “Add” and select the autounattended.xml file you downloaded in Step 1 or just click and drag the autounattended.xml into the AnyBurn window.
   - Click on “Next,” then on “Create Now.” You should be prompted to overwrite the ISO file, click on “Yes.”
   - Once the process is complete, close AnyBurn.
4. Use a program like Rufus or Ventoy to create a bootable USB flash drive with the edited Windows ISO file. (When using Rufus, don’t select any of the checkboxes in “Customize Your Windows Experience”)
   - Rufus: [Rufus](https://rufus.ie/en/)
   - Ventoy: [Ventoy](https://www.ventoy.net/)
5. Boot from the Windows Installation USB, do a clean install of Windows as normal, and the scripts will run automatically.

## Conclusion
I hope these unattended Windows setup scripts help streamline your Windows installation process as much as they have for me. Feel free to explore and customize the answer files to fit your needs. If you find these scripts useful, consider giving this repository a star ⭐ on GitHub. Your feedback and suggestions are always welcome!

Happy installing!

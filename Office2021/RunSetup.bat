@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v KeyManagementServiceName /t REG_SZ /d "192.168.11.115" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v KeyManagementServicePort /t REG_SZ /d "1688" /f 

if exist "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" (
  cscript //nologo "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" /unpkey:DRTFM
  cscript //nologo "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" /unpkey:6MWKP
  cscript //nologo "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" /unpkey:WFG99

)
if exist "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" (
  cscript //nologo "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" /unpkey:DRTFM
  cscript //nologo "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" /unpkey:6MWKP
  cscript //nologo "%ProgramFiles(x86)%\Microsoft Office\Office16\ospp.vbs" /unpkey:WFG99
)

pushd "%~dp0"
setup /configure "ConfigurationOffice2021.xml"
popd

reg add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d "0" /f
if exist "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE" (
  mklink "C:\Users\Public\Desktop\Excel 2021" "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
  mklink "C:\Users\Public\Desktop\Word 2021" "C:\Program Files\Microsoft Office\root\Office16\winword.EXE"
  mklink "C:\Users\Public\Desktop\Outlook 2021" "C:\Program Files\Microsoft Office\root\Office16\Outlook.EXE"
) else (
  echo "FEHLER Office konnte nicht installiert werden!"
  pause
)
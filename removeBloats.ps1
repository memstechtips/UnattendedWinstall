# List of pre-installed apps to remove except those that start with a '#'
$bloatApps = @(
	'Microsoft.Microsoft3DViewer';
	'Microsoft.BingSearch';
	'Microsoft.WindowsCalculator';
	'Microsoft.WindowsCamera';
	'Clipchamp.Clipchamp';
	'Microsoft.WindowsAlarms';
	'Microsoft.549981C3F5F10';
	'Microsoft.Windows.DevHome';
	'MicrosoftCorporationII.MicrosoftFamily';
	'Microsoft.WindowsFeedbackHub';
	'Microsoft.GetHelp';
	'microsoft.windowscommunicationsapps';
	'Microsoft.WindowsMaps';
	'Microsoft.ZuneVideo';
	'Microsoft.BingNews';
	'Microsoft.WindowsNotepad';
	'Microsoft.MicrosoftOfficeHub';
	'Microsoft.Office.OneNote';
	'Microsoft.OutlookForWindows';
	'Microsoft.Paint';
	'Microsoft.MSPaint';
	'Microsoft.People';
	'Microsoft.Windows.Photos';
	'Microsoft.PowerAutomateDesktop';
	'MicrosoftCorporationII.QuickAssist';
	'Microsoft.SkypeApp';
	'Microsoft.ScreenSketch';
	'Microsoft.MicrosoftSolitaireCollection';
	'Microsoft.MicrosoftStickyNotes';
	'MSTeams';
	'Microsoft.Getstarted';
	'Microsoft.Todos';
	'Microsoft.WindowsSoundRecorder';
	'Microsoft.BingWeather';
	'Microsoft.ZuneMusic';
	'Microsoft.WindowsTerminal';
	'Microsoft.Xbox.TCUI';
	'Microsoft.XboxApp';
	'Microsoft.XboxGameOverlay';
	'Microsoft.XboxGamingOverlay';
	'Microsoft.XboxIdentityProvider';
	'Microsoft.XboxSpeechToTextOverlay';
	'Microsoft.GamingApp';
	'Microsoft.YourPhone';
	'Microsoft.MicrosoftEdge';
	'Microsoft.MicrosoftEdge.Stable';
	'Microsoft.MicrosoftEdge_8wekyb3d8bbwe';
	'Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe';
	'Microsoft.MicrosoftEdgeDevToolsClient_1000.19041.1023.0_neutral_neutral_8wekyb3d8bbwe';
	'Microsoft.MicrosoftEdge_44.19041.1266.0_neutral__8wekyb3d8bbwe';
	'Microsoft.OneDrive';
	'Microsoft.MicrosoftEdgeDevToolsClient';
	'Microsoft.549981C3F5F10';
	'Microsoft.MixedReality.Portal';
	'Microsoft.Windows.Ai.Copilot.Provider';
	'Microsoft.WindowsMeetNow';
	'Microsoft.WindowsStore';
	'Microsoft.Wallet';
)

# List of capabilities to remove
$bloatWindowsCapabilities = @(
	'Browser.InternetExplorer',
	'MathRecognizer',
	'OpenSSH.Client',
	'Microsoft.Windows.PowerShell.ISE',
	'App.Support.QuickAssist',
	'App.StepsRecorder',
	'Microsoft.Windows.WordPad'
)

$logs = @{
	app  = "$env:USERPROFILE\Desktop\remove-bloatware-log.txt";
	more = "$env:USERPROFILE\Desktop\remove-capabilities-log.txt";
}

# Run as admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Host "Requesting administrative privileges..."
	$scriptPath = $MyInvocation.MyCommand.Path
	if (Get-Command pwsh -ErrorAction SilentlyContinue) {
		Start-Process pwsh -Verb RunAs -ArgumentList "-NoProfile", "-NoExit", "-ExecutionPolicy", "Bypass", "-File", `"$scriptPath`"
	}
	else {
		Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile", "-NoExit", "-ExecutionPolicy", "Bypass", "-File", `"$scriptPath`"
	}
	exit
}

Write-Host "WARNING: I will only ask once. This will remove everything from the list." -ForegroundColor Yellow
$prompt = Read-Host "Do you want to continue? (y/N)"
if ($prompt -eq '') { $prompt = "n" }
If ($prompt -eq 'y' -or $prompt -eq 'yes') {
	Write-Host "Get ready!" -ForegroundColor Blue
}
else {
	Write-Host "Exiting..." -ForegroundColor Yellow
	exit
}

Write-Host @"
█▀█ █▀█ █▀▀ ▄▄ █ █▄░█ █▀ ▀█▀ ▄▀█ █░░ █░░ █▀▀ █▀▄
█▀▀ █▀▄ ██▄ ░░ █ █░▀█ ▄█ ░█░ █▀█ █▄▄ █▄▄ ██▄ █▄▀
"@ -ForegroundColor Yellow

# If an app from the $bloatApps list is installed remove it.
$bloatApps | ForEach-Object {
	$app = $_
	try {
		$installedApp = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $app }

		if ($installedApp) {
			Write-Host "Attempting to remove $app..."
			Remove-AppxProvisionedPackage -PackageName $installedApp.PackageName -AllUsers -Online -ErrorAction Stop -LogLevel=1 -LogPath=$logs.more
			Write-Host "Removed: $app." -ForegroundColor Green
		}
		else {
			Write-Host "$app is not installed." -ForegroundColor Yellow
		}
	}
 catch {
		Write-Host "Failed to remove $app" -ForegroundColor Red | Write-Output >> $logs.apps
		Write-Host $_.Exception.Message -ForegroundColor Red
	}
}

Write-Host @"
█▀▄▀█ █▀█ █▀█ █▀▀
█░▀░█ █▄█ █▀▄ ██▄
"@ -ForegroundColor Yellow

# Get all installed capabilities
$installedCapabilities = Get-WindowsCapability -Online | Where-Object { $_.State -eq 'Installed' }

foreach ($capability in $bloatWindowsCapabilities) {
	# Find the installed capability that matches any of the item from $bloatWindowsCapabilities
	$matchingCapabilities = $installedCapabilities | Where-Object { $_.Name -like "$capability*" }

	if ($matchingCapabilities) {
		# If found remove it
		foreach ($match in $matchingCapabilities) {
			try {
				Write-Host "Attempting to remove $($match.Name)..."
				# $result = Start-Process -FilePath "dism.exe" -ArgumentList "/Online", "/Remove-Capability", "/CapabilityName:$($match.Name)", "/NoRestart", "/LogLevel=1", "/LogPath=$env:USERPROFILE\Desktop\removed-capability-log.txt" -NoNewWindow -Wait -PassThru
				$result = Start-Process -FilePath "dism.exe" -ArgumentList "/Online", "/Remove-Capability", "/CapabilityName:$($match.Name)", "/NoRestart", "/LogLevel=1", "/LogPath=$logs.app" -NoNewWindow -Wait -PassThru

				# Check if the process completed successfully
				if ($result.ExitCode -eq 0) {
					Write-Host "$($match.Name) removed successfully."
				}
				else {
					Write-Host "Failed to remove $($match.Name) with exit code $($result.ExitCode)." -ForegroundColor Red
				}
			}
			catch {
				Write-Host "Exception: Failed to remove $($match.Name)" -ForegroundColor Red
				Write-Host $_.Exception.Message -ForegroundColor Red
			}
		}
	}
 else {
		Write-Host "$capability is not installed." -ForegroundColor Yellow
	}
}

# TODO: add check if nothing was removed, only log this "Nothing was removed. Hence no logs will be created." -ForegroundColor Blue
Write-Host "Operation completed." -ForegroundColor Blue
Write-Host "If something was removed you can check the logs placed on your Desktop folder for more details." -ForegroundColor Yellow
Write-Host "Feel free to close this window now." -ForegroundColor Blue

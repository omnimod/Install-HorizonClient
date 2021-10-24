Param(
		[Parameter(Position=0,
		HelpMessage="Enter the path to the Horizon Client installation file")]
		[String] $FilePath = (Get-Location).ToString() + "\VMware-Horizon-Client-2106-8.3.0-18287501.exe",
		
		[Parameter(Position=1,
		HelpMessage="Specify additional arguments, check https://docs.vmware.com/en/VMware-Horizon-Client-for-Windows/2106/horizon-client-windows-installation/GUID-2DDF9C24-A1E9-4357-A832-2A5A19352D61.html for details")]	
		[String] $ArgumentList = "ADDLOCAL=ALL /silent /norestart",

		[Parameter(Position=2,
		HelpMessage="Specify if older Horizon Client should be updated")]
		[switch]$UpdateOldClients = $true,
	
		[Parameter(Position=3,
		HelpMessage="Specify Logfile location")]
		[String] $Logfile = "$env:windir\Temp\" + "horizon-client-autoinstall-script.txt"
	)

(Get-Date).DateTime.ToString() + " ============== Install-HorizonClient.ps1 ==============" | Out-File -Encoding utf8 $Logfile -Append

#Check for installer file accessibility and version
$FileVersion = (Get-Item $Filepath).VersionInfo.FileVersion

if ($FileVersion -ne $null) {
	(Get-Date).DateTime.ToString() + " Horizon Client installation file was found at $FilePath , Installer version: $FileVersion" | Out-File -Encoding utf8 $Logfile -Append
} else {
	(Get-Date).DateTime.ToString() + " Cannot access to Horizon Client installer at $FilePath Check for the installation file accessibility." | Out-File -Encoding utf8 $Logfile -Append
	break
}

#Check if Horizon Client is installed
$App = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall" | where {$_.GetValue("DisplayName") -eq "VMware Horizon Client"}

if ($App -ne $null) {
    $AppVersion = $App.GetValue("DisplayVersion")
	(Get-Date).DateTime.ToString() + " Horizon Client $AppVersion is installed." | Out-File -Encoding utf8 $Logfile -Append	
	
    if (($UpdateOldClients -eq $true) -and ($AppVersion -lt $FileVersion)) {
		(Get-Date).DateTime.ToString() + " Start Horizon Client installation." | Out-File -Encoding utf8 $Logfile -Append	
        Start-Process -FilePath $Filepath -ArgumentList $ArgumentList
    } else {
		(Get-Date).DateTime.ToString() + " Old Horizon Client update is disabled or current version is installed. Check for installed version." | Out-File -Encoding utf8 $Logfile -Append	
	}
} else {
	(Get-Date).DateTime.ToString() + " Horizon Client is not installed on this system. Start Horizon Client installation." | Out-File -Encoding utf8 $Logfile -Append
    Start-Process -FilePath $Filepath -ArgumentList $ArgumentList	
}


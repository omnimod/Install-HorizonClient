# Install-HorizonClient
PowerShell script for Horizon Client automatic installation.

Run with the following arguments to install VMware Horizon Client:

.\Install-HorizonClient.ps1 -FilePath "C:\Install\VMware-Horizon-Client-2106-8.3.0-18287501.exe"

Additional arguments:

-ArgumentList -List of parameters to run with the installer, "ADDLOCAL=ALL /silent /norestart" is used by default

-UpdateOldClients - Specify if older Horizon Client should be updated. $true is used by default.

-Logfile - Specify where to write logfile location for the script. C:\Windows\Temp\horizon-client-autoinstall-script.txt is used by default.

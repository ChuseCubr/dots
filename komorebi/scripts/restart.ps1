$Env:KOMOREBI_CONFIG_HOME = "$($Env:USERPROFILE)/.config/komorebi"
. "$Env:KOMOREBI_CONFIG_HOME/scripts/stop.ps1"
Start-ScheduledTask -TaskName "WMStart"

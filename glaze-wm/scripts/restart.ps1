$Env:GLAZEWM_CONFIG_HOME = "$($Env:USERPROFILE)\.glaze-wm"
. "$Env:GLAZEWM_CONFIG_HOME\scripts\stop.ps1"
Start-ScheduledTask -TaskName "GlazeWMStart"

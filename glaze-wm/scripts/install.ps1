$Env:GLAZEWM_CONFIG_HOME = "$($Env:USERPROFILE)\.glaze-wm"

$principal = New-ScheduledTaskPrincipal -UserId 'Chuse\Chase' -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan)

$startup_actions = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-windowstyle hidden -file `"$($Env:GLAZEWM_CONFIG_HOME)\scripts\startup.ps1`""
$startup_trigger = New-ScheduledTaskTrigger -AtLogOn -User 'Chuse\Chase'
$startup = New-ScheduledTask -Action $startup_actions -Principal $principal -Trigger $startup_trigger -Settings $settings
Register-ScheduledTask 'GlazeWMStart' -InputObject $startup

$stop_actions = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-windowstyle hidden -file `"$($Env:GLAZEWM_CONFIG_HOME)\scripts\stop.ps1`""
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan)
$stop = New-ScheduledTask -Action $stop_actions -Principal $principal -Settings $settings
Register-ScheduledTask 'GlazeWMStop' -InputObject $stop

$restart_actions = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-windowstyle hidden -file `"$($Env:GLAZEWM_CONFIG_HOME)\scripts\restart.ps1`""
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan)
$restart = New-ScheduledTask -Action $restart_actions -Principal $principal -Settings $settings
Register-ScheduledTask 'GlazeWMRestart' -InputObject $restart

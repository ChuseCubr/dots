Stop-Process -Name "komorebic" -ErrorAction SilentlyContinue
Stop-Process -Name "komorebi" -ErrorAction SilentlyContinue
Stop-ScheduledTask -TaskName "WMStart"

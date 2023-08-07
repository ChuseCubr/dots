$Env:KOMOREBI_CONFIG_HOME = "$($Env:USERPROFILE)/.config/komorebi"
$Env:YASB_INSTALL = "D:/repos/yasb"
$Env:YASB_CONFIG = "$($Env:USERPROFILE)/.yasb"

komorebic start -c "$($Env:KOMOREBI_CONFIG_HOME)/komorebi.json"
komorebic focus-follows-mouse enable --implementation windows

& "C:/Program Files/AutoHotkey/v2/AutoHotkey64_UIA.exe" "$($Env:KOMOREBI_CONFIG_HOME)/komorebi.ahk"

Start-Job -ScriptBlock {
  nvim.exe --clean --headless -l "$($Env:YASB_CONFIG)/komorebi_state/server.lua"
}

Start-Job -ScriptBlock {
  . "$($Env:YASB_INSTALL)/yasb_venv/Scripts/activate.ps1"
  python "$($Env:YASB_INSTALL)/src/main.py"
}

Read-Host -Prompt "Press any key to exit"

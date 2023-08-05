nvim.exe $args
Set-Location "$(nvim.exe -l `"$($env:USERSCRIPTS)/lua/_nvimcd.lua`")"

nvim.exe $args
Set-Location "$(nvim.exe --clean --headless -l `"$($env:USERSCRIPTS)/lua/_nvimcd.lua`")"

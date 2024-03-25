# Set-Alias nvim $env:USERSCRIPTS/_nvimcd.ps1
Set-Alias vim nvim
Set-Alias vi nvim
function lvim {
	$env:NVIM_APPNAME="lazyvim"
	nvim $args
	$env:NVIM_APPNAME="nvim"
}

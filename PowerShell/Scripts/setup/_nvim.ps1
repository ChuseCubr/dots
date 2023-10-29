Set-Alias vim nvim
Set-Alias vi nvim

function lvim {
	$env:NVIM_APPNAME=lazyvim
	nvim $args
}

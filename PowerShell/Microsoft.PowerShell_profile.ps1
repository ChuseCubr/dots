# PSReadline options
# Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistorySaveStyle SaveNothing

# Replace \ with / in tab autocompletion
Set-PSReadLineKeyHandler -Chord Tab -ScriptBlock {
	$content = ""
	$index = 0
	[Microsoft.PowerShell.PSConsoleReadLine]::MenuComplete()
	[Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref] $content, [ref] $index)
	[Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert($content.Replace('\','/'))
	[Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($index)
}

$env:USERSCRIPTS = "$($env:USERPROFILE)/Documents/PowerShell/Scripts"

# source stuff
. $env:USERSCRIPTS/setup/_nvim.ps1
. $env:USERSCRIPTS/setup/_scoop.ps1

Import-Module Get-Prompt

function prompt {
  return Get-Prompt
}

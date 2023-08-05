# Autocompletion for powershell.
#
# You need to either copy the content of this file to $PROFILE or call this
# script directly.
#

using namespace System.Management.Automation

Register-ArgumentCompleter -Native -CommandName 'lf' -ScriptBlock {
    param($wordToComplete)
    $completions = @(
        [CompletionResult]::new('-command ', '-command', [CompletionResultType]::ParameterName, 'command to execute on client initialization')
        [CompletionResult]::new('-config ', '-config', [CompletionResultType]::ParameterName, 'path to the config file (instead of the usual paths)')
        [CompletionResult]::new('-cpuprofile ', '-cpuprofile', [CompletionResultType]::ParameterName, 'path to the file to write the CPU profile')
        [CompletionResult]::new('-doc', '-doc', [CompletionResultType]::ParameterName, 'show documentation')
        [CompletionResult]::new('-last-dir-path ', '-last-dir-path', [CompletionResultType]::ParameterName, 'path to the file to write the last dir on exit (to use for cd)')
        [CompletionResult]::new('-log ', '-log', [CompletionResultType]::ParameterName, 'path to the log file to write messages')
        [CompletionResult]::new('-memprofile ', '-memprofile', [CompletionResultType]::ParameterName, 'path to the file to write the memory profile')
        [CompletionResult]::new('-remote ', '-remote', [CompletionResultType]::ParameterName, 'send remote command to server')
        [CompletionResult]::new('-selection-path ', '-selection-path', [CompletionResultType]::ParameterName, 'path to the file to write selected files on open (to use as open file dialog)')
        [CompletionResult]::new('-server', '-server', [CompletionResultType]::ParameterName, 'start server (automatic)')
        [CompletionResult]::new('-single', '-single', [CompletionResultType]::ParameterName, 'start a client without server')
        [CompletionResult]::new('-version', '-version', [CompletionResultType]::ParameterName, 'show version')
        [CompletionResult]::new('-help', '-help', [CompletionResultType]::ParameterName, 'show help')
    )

    if ($wordToComplete.StartsWith('-')) {
        $completions.Where{ $_.CompletionText -like "$wordToComplete*" } | Sort-Object -Property ListItemText
    }
}

function lfcd {
# Change working dir in powershell to last dir in lf on exit.
#
# You need to put this file to a folder in $ENV:PATH variable.
#
# You may also like to assign a key to this command:
#
#     Set-PSReadLineKeyHandler -Chord Ctrl+o -ScriptBlock {
#         [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
#         [Microsoft.PowerShell.PSConsoleReadLine]::Insert('lfcd.ps1')
#         [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
#     }
#
# You may put this in one of the profiles found in $PROFILE.
#

  $tmp = [System.IO.Path]::GetTempFileName()
    lf -last-dir-path="$tmp" $args
    if (Test-Path -PathType Leaf "$tmp") {
      $dir = Get-Content "$tmp"
        Remove-Item -Force "$tmp"
        if (Test-Path -PathType Container "$dir") {
          if ("$dir" -ne "$pwd") {
            cd "$dir"
          }
        }
    }
}

$prompt = ""
function Invoke-Starship-PreCommand
{
  $current_location = $executionContext.SessionState.Path.CurrentLocation
  if ($current_location.Provider.Name -eq "FileSystem")
  {
    $ansi_escape = [char]27
    $provider_path = $current_location.ProviderPath -replace "\\", "/"
    $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
  }
  $host.UI.RawUI.WindowTitle = Get-Location
  $host.ui.Write($prompt)
}
try
{
  Invoke-Expression (&starship init powershell)
} catch
{
}

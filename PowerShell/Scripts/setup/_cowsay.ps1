function afk([string]$Cow) {
  if ($Cow -eq ""){
    $Cow = "-"
  }
  if ($Cow -eq "r") {
    $CowPool = @("default", "tux", "stegosaurus", "turtle", "kitty")
    $Cow = $($CowPool | Get-Random)
  }
  cls && cowsay -f $Cow --bold "
   █████╗ ███████╗██╗  ██╗  
  ██╔══██╗██╔════╝██║ ██╔╝  
  ███████║█████╗  █████╔╝   
  ██╔══██║██╔══╝  ██╔═██    
  ██║  ██║██║     ██║  ██╗  
  ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝  
" -n
}

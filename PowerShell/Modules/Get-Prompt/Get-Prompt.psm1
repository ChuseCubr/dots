# new tab in same directory
# https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory#powershell-powershellexe-or-pwshexe

function locationSignal {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $out = ""
  if ($loc.Provider.Name -eq "FileSystem") {
    $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  return $out
}

# try to convert path to a relative path based on a given root folder
# if the path is above the root folder, returns null
function toRelativeLocation($root, $rootName) {
  $normalizedRoot = $root -replace "\\","/"
  $normalizedPwd = $pwd -replace "\\","/"

  # if current directory and target root directory (e.g., $HOME) are the same, just use root name
  if ($normalizedRoot -eq $normalizedPwd) {
    return $rootName
  }

  # if current directory is above the target root, return null
  if ($normalizedRoot | select-string $normalizedPwd) {
    return
  }

  # otherwise, get relative path
  $relativePath = resolve-path $pwd -relativebasepath $root -relative
  $path = $relativePath -replace "^\.","$rootName"
  $normalizedPath = $path -replace "\\","/"

  return $normalizedPath
}

# path relative to root of git project
function gitLocation() {
  $root = git rev-parse --show-toplevel 2>$null
  if ($root -eq $null) { return }

  $rootName = resolve-path $root | split-path -leaf

  return toRelativeLocation $root $rootName
}

# git tracking and file status
function gitStatus {
  $status = $(git status --short -b) -join "`n"

  # best summaries I could manage for now, will double check eventually(tm)
  $conflict = $status -match "\n(DD|AA|.?U)"
  $behind = $status -match "behind.*\]($|\n)"
  $ahead = $status -match "ahead.*\]($|\n)"
  $staged = $status -match "\n(D |A[^A]|[^DAU ?])"
  $unstaged = $status -match "\n.[^ ]"

  $out = ""
  if ($conflict) { $out += "!" }
  if ($behind) { $out += "v" }
  if ($ahead) { $out += "^" }
  if ($staged) { $out += "+" }
  if ($unstaged) { $out += "*" }

  return $out
}

# combined git info
function gitInfo {
  $root = git rev-parse --show-toplevel 2>$null
  if ($root -eq $null) { return }

  $out = ""
  $out += "`e[32m$(gitLocation)`e[0m "
  $out += "("
  $out += "`e[90m$(git branch --show-current)`e[0m"
  $status = gitStatus
  if ($status -ne "") {
    $out += " `e[35m$(gitStatus)`e[0m"
  }
  $out += ") "

  return $out
}

# if within home, relative/short path
# otherwise, absolute path
function location() {
  $root = $home
  $rootName = "~"

  $loc = toRelativeLocation $root $rootName

  if ($loc) {
    return $loc
  }

  return $pwd
}

function Get-Prompt {
  $gitInfo = gitInfo
  $out += "`n"
  $out += locationSignal
  $out += "[`e[36m$(git config --get user.email)`e[0m] "
  if ($gitInfo) {
    $out += $gitInfo
  } else {
    $out += "`e[32m$(location)`e[0m"
  }
  $out += "`n"
  $out += "`e[34m$('>' * ($nestedPromptLevel + 1))`e[0m "
  return $out
}

Export-ModuleMember -Function Get-Prompt

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\gruvbox.omp.json" | Invoke-Expression

function admin {
  if($args.Count -gt 0) {
    $argList = "& '" + $args + "'"
    Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
  } else {
    Start-Process "$psHome\powershell.exe" -Verb runAs
  }
}

Set-Alias -Name sudo -Value admin

function cd... { cd ..\.. }
function cd.... { cd ..\..\.. }

function ll { Get-ChildItem -Path $pwd -File }

function togit { cd C:\Users\devin\Documents\Github }

function editposh {
  nvim $profile
}

function refresh {
  & $profile
}

function find-file ($name) {
  ls -recurse -filter "*${name}*" -ErrorAction SilentContinue | foreach {
    $place_path = $_.directory
    echo "${place_path}\${_}"
  }
}

function unzip ($file) {
  echo("Extracting", $file, "to", $pwd)
  $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object{$_.FullName}
  Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function grep ($regex, $dir) {
  if ($dir) {
    ls $dir | select-string $regex
    return
  }
  $input | select-string $regex
}

function touch ($file) {
  "" | Out-File $file -Encoding ASCII
}

function which ($name) {
  Get-Command $name | Select-Object -ExpandProperty Definition
}

function pkill ($name) {
  ps $name -ErrorAction SilentContinue | kill
}

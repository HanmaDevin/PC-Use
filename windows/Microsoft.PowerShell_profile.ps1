oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\gruvbox.omp.json" | Invoke-Expression

function admin {
  if($args.Count -gt 0) {
    $argList = "& '" + $args + "'"
    Start-Process "$psHome\pwsh.exe" -Verb runAs -ArgumentList $argList
  } else {
    Start-Process "$psHome\pwsh.exe" -Verb runAs
  }
}

Set-Alias -Name sudo -Value admin

function lg { lazygit }

function c { clear }
function ll { Get-ChildItem -Path $pwd -File }
function q { exit }

neofetch

function .. { cd .. }
function ... { cd ..\.. }
function .3 { cd ..\..\.. }
function .4 { cd ..\..\..\.. }
function .5 { cd ..\..\..\..\.. }

function togit { cd C:\Users\devin\Documents\Github }
function gs { git status }
function ga { git add . }
function gp { git push }

function editposh { code $profile }

function deac { deactivate }
function startenv { .\bin\Activate.ps1 }
function createnv ($envPath) {
  python -m venv $pwd\$envPath
  cd $envPath
}

function find-file ($name) {
  ls -recurse -filter "*${name}*" -ErrorAction SilentContinue | foreach {
    $place_path = $_.directory
    echo "${place_path}\${_}"
  }
}

function unzip ($file, $des=$pwd) {
  echo("Extracting", $file, "to", $des)
  $fullFile = Get-ChildItem -Path $pwd -Filter .\$file | ForEach-Object{$_.FullName}
  Expand-Archive -Path $fullFile -DestinationPath $des
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

$packages = "WhatsApp","Debian","neofetch","VisualStudioCode","python","direnv","okular","ohmyposh","Bitwarden","steam","chrome","oracle.jdk.23","lazarus","git","7-zip"

foreach ($element in $packages) {
    winget install $element
}

.\windows\get-wallpaper.ps1
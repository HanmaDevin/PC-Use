$packages = "ajeetdsouza.zoxide","WhatsApp","Debian.Debian","GNU.Nano","lazygit","python","direnv","KDE.okular","ohmyposh","Valve.steam","Google.chrome","oracle.jdk.23","7-zip"

foreach ($element in $packages) {
    winget install $element
}

Install-Module PSColor -Scope CurrentUser

$packages = "ajeetdsouza.zoxide","WhatsApp","Debian.Debian","sharkdp.bat","GNU.Nano","lazygit","python","direnv","KDE.okular","ohmyposh","Valve.steam","Google.chrome","oracle.jdk.23","7-zip"

foreach ($element in $packages) {
    winget install $element
}

echo "Installing Powershell Modules..."

Install-Module PSColor -Scope CurrentUser

echo "Done!"

echo "Installing Wallpapers..."

.\windows\get-wallpaper.ps1

echo "Done!"

echo "Copying Powershell Profile..."

Copy-Item .\windows\Microsoft.PowerShell_profile.ps1 $PROFILE

echo "Done!"
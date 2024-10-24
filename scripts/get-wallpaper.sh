#! bin/bash

# installs wallpaper
if [[ ! -d "$HOME/Linux"]]; then
    git clone "https://github.com/HanmaDevin/Linux.git" "$HOME/Linux"
fi

if [[ ! -d "$HOME/Pictures/wallpapers" ]]; then
    mkdir -p "$HOME/Pictures/wallpapers"
fi

echo "Installing wallpapers..."
cp -a "$HOME/Linux/wallpapers/." "$HOME/Pictures/wallpapers"
echo "wallpapers installed!"
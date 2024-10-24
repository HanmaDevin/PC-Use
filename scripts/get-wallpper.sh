#! bin/bash

# Get the current wallpaper
if [[ ! -d "$HOME/Pictures/Wallpaper"]]; then
    mkdir -p "$HOME/Pictures/Wallpaper"
fi

# Get all wallpapers
echo "Copying all wallpapers to $HOME/Pictures/Wallpaper"

cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/Wallpaper"

echo "Finished!"
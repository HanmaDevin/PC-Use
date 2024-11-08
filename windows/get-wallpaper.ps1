New-Item -Path "$HOME\Pictures" -Name "wallpaper" -ItemType "directory"
Copy-Item -Path "$PWD\wallpaper\*" -Destination "$HOME\Pictures\wallpaper"

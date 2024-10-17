New-Item -Path "$HOME\Pictures" -Name "wallpaper" -ItemType "directory"
Copy-Item -Path "$HOME\Linux\wallpaper\*" -Destination "$HOME\Pictures\wallpaper"

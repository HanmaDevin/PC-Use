New-Item -Path "C:\$USER\Bilder" -Name "wallpaper" -ItemType "directory"
Copy-Item -Path "C:\$USER\Linux\wallpaper\*" -Destination "C:\$USER\Bilder\wallpaper"

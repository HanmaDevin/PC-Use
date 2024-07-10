#! /bin/bash

git clone "https://github.com/prasanthrangan/hyprdots"
bash "$HOME/hyprdots/Scripts/install.sh"

# import os information location
source /etc/os-release

packages=("git" "steam" "discord" "eza" "btop" "zsh" "neofetch" "ufw" "yazi" "neovim" "unzip" "zip" "fzf" "ntfs-3g" "fuse2" "wget" "curl" "gamemode" "mangohud" "zoxide" "bat" "bluez" "bluez-utils")

# variable $ID comes from the os information import
# check if array is not empty
if [[ ${#packages[@]} ]]; then
  # check for linux distro
  if [[ $ID == "fedora" ]]; then
    # loop through array
    for package in ${packages[@]}; do
      sudo dnf install $package
    done
  elif [[ $ID == "arch" ]]; then
    for package in ${packages[@]}; do
      sudo pacman -S $package
    done
  else
    for package in ${packages[@]}; do
      sudo apt install $package
    done
  fi
fi

read -p "Want to configure git? (y/n)" gitconfig

if [[ $gitconfig == "y" ]]; then
  read -p "What is your Github username?" username
  git config --global user.name "$username"
  read -p "What is your email?" useremail
  git config --global user.email "$useremail"
fi

read -p "Ready to add ssh-key? (y/n)" sshready

if [[ $sshready == "y" ]]; then
  echo "Do not change de default file location and name in the following!!!"
  read -p "what is your email account?" email
  ssh-keygen -t ed25519 -C $email
  ssh-add ~/.ssh/id_ed25519
  echo "Paste the following content in your ssh-key section in Github"
  echo $(cat ~/.ssh/id_ed25519.pub)
fi

read -p "Do you want to install Vencord? (y/n)" vencord

if [[ $vencord == "y" ]]; then
  sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
fi

# adding wallpapers
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Rosé Pine/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Synth Wave/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Decay Green/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Edge Runner/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Nordic Blue/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Tokyo Night/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Frosted Glass/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Graphite Mono/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Gruvbox Retro/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Material Sakura/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Catppuccin Latte/wallpapers/"
cp -a "$HOME/Linux/wallpaper/." "$HOME/.config/hyde/themes/Catppuccin Mocha/wallpapers/"

if [[ ! -d "$HOME/.config/neofetch/" ]]; then
  mkdir -p "$HOME/.config/neofetch/"
fi

read -p "Want to install google chrome with yay? (y/n)" google
if [[ "$google" == "y" ]]; then
  yay -S google-chrome
fi

# Adding neofetch theme to maschine
cp "$HOME/Linux/Neofetch-Theme/ozoz.txt" "$HOME/.config/neofetch/config.conf"

bash "$HOME/Linux/neovim.sh"

# adding hyprland config
cp "$HOME/Linux/dotfiles/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
cp "$HOME/Linux/dotfiles/keybindings.conf" "$HOME/.config/hypr/keybindings.conf"
cp "$HOME/Linux/dotfiles/zshrc" "$HOME/.zshrc"
cp "$HOME/Linux/dotfiles/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# configure firewall with ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status

# configure zsh prompt
p10k configure

# remove redundand programs
sudo pacman -R dolphin code fastfetch vim pokemon-colorscripts-git firefox

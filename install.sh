#! /bin/bash

# import os information location
source /etc/os-release

packages=("git" "steam" "discord" "lazygit" "eza" "texlive" "rofi" "btop" "zsh" "okular" "ttf-dejavu-nerd" "neofetch" "feh" "blueman" "" "libreoffice-still" "ufw" "yazi" "neovim" "unzip" "zip" "fzf" "ntfs-3g" "fuse2" "wget" "curl" "gamemode" "mangohud" "zoxide" "bat" "bluez" "bluez-utils" "kitty")

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

# installing yay
git clone "https://aur.archlinux.org/yay.git"
sleep 2
cd "$HOME/yay"
sleep 2
makepkg -si

# from AUR: isntalling bumblebee-status
git clone "https://aur.archlinux.org/bumblebee-status.git"
sleep 2
cd bumblebee-status
sleep 2
makepkg -sicr

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

if [[ ! -d "$HOME/.config/neofetch/" ]]; then
  mkdir -p "$HOME/.config/neofetch/"
fi

# installing software with yay
yay -S google-chrome
yay -S heroic-games-launcher-bin

# adding all configs
# Adding neofetch theme to maschine
cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

# adding i3 config
cp "$HOME/Linux/dotfiles/config" "$HOME/.config/i3/config"

# adding cursor
mkdir -p "$HOME/.icons/"
cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "$HOME/.icons/"

# adding cursor
sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

# adding fonts
sudo unzip "$HOME/Linux/Fonts/ProFont.zip" -d "/usr/share/fonts/"

# adding kitty config
cp "$HOME/Linux/dotfiles/diff.conf" "$HOME/.config/kitty/"
cp "$HOME/Linux/dotfiles/dracula.conf" "$HOME/.config/kitty/"
cp "$HOME/Linux/dotfiles/kitty.conf" "$HOME/.config/kitty/"

# adding rofi theme
cp "$HOME/Linux/dotfiles/config1.rasi" "$HOME/.config/rofi/config.rasi"

# adding neovim plugin
cp "$HOME/Linux/dotfiles/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

# adding yazi config
cp "$HOME/Linux/dotfiles/yazi.toml" "$HOME/.config/yazi/"

# configure firewall with ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status

# remove redundand programs
sudo pacman -R dolphin code fastfetch vim pokemon-colorscripts-git firefox nano

# run scripts
bash "$HOME/Linux/neovim.sh"
bash "$HOME/Linux/p10k-theme.sh"

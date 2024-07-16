#!/bin/bash

# import os information location
source /etc/os-release

packages=("git" "steam" "uthash" "pixman" "firefox" "picom" "discord" "iw" "python-pipx" "polybar" "maim" "xclip" "xdotool" "pavucontrol" "lightdm-webkit2-greeter" "lazygit" "eza" "texlive" "rofi" "btop" "zsh" "okular" "ttf-font-awesome" "neofetch" "feh" "blueman" "libreoffice-still" "ufw" "yazi" "neovim" "unzip" "zip" "fzf" "ntfs-3g" "fuse2" "wget" "curl" "gamemode" "mangohud" "zoxide" "bat" "bluez" "bluez-utils" "kitty")

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

if [[ ! -d "$HOME/.config/neofetch/" ]]; then
  mkdir -p "$HOME/.config/neofetch/"
fi

# adding all configs
# Adding neofetch theme to maschine
echo "Adding neofetch config"
sleep 2

cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

echo "Finished!"
sleep 2

echo "Adding ly conf"
sleep 2

if [[ ! -d "/etc/ly/" ]]; then
  sudo mkdir -p "/etc/ly/"
fi

sudo cp "$HOME/Linux/dotfiles/ly.conf" "/etc/ly/config.ini"

echo "Finished!"
sleep 2

# adding i3 config
echo "Adding i3 config"
sleep 2

cp "$HOME/Linux/dotfiles/config" "$HOME/.config/i3/config"

echo "Finished!"
sleep 2

echo "Adding picom config"
sleep 2

mkdir -p "$HOME/.config/picom/"
cp "$HOME/Linux/dotfiles/picom.conf" "$HOME/.config/picom/"

echo "Finished!"
sleep 2

echo "Adding polybar config"
sleep 2

mkdir -p "$HOME/.config/polybar/"
cp "$HOME/Linux/dotfiles/config.ini" "$HOME/.config/polybar/config.ini"
cp "$HOME/Linux/dotfiles/launch.sh" "$HOME/.config/polybar/"

echo "Finished!"
sleep 2

# adding cursor
echo "Adding cursor theme"
sleep 2

mkdir -p "$HOME/.icons/"
cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "$HOME/.icons/"

echo "Finished!"
sleep 2

# adding cursor
sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

# adding fonts
echo "Adding fonts"
sleep 2

sudo unzip "$HOME/Linux/Fonts/FiraCode.zip" -d "/usr/share/fonts/"

echo "Finished!"
sleep 2

echo "Adding btop config"
sleep 2

mkdir -p "$HOME/.config/btop/"
cp "$HOME/Linux/dotfiles/btop.conf" "$HOME/.config/btop/"

echo "Finished!"
sleep 2

# adding grub theme
echo "Adding Grub-Theme"
sleep 2

sudo cp -r "$HOME/Linux/Grub-Theme/dracula/" "/boot/grub/themes/"
sudo cp "$HOME/Linux/dotfiles/grub" "/etc/default/grub"
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Finished!"
sleep 2

echo "Adding cursor theme and size"
sleep 2

cp "$HOME/Linux/dotfiles/Xresources" "$HOME/.Xresources"
xrdb -merge "$HOME/.Xresources"

echo "Finished!"
sleep 2

# adding kitty config
echo "Adding kitty config"
sleep 2

mkdir -p "$HOME/.config/kitty/"
cp "$HOME/Linux/dotfiles/kitty.conf" "$HOME/.config/kitty/"
cp "$HOME/Linux/dotfiles/diff.conf" "$HOME/.config/kitty/"
cp "$HOME/Linux/dotfiles/dracula.conf" "$HOME/.config/kitty/"

echo "Finished!"
sleep 2

echo "Adding rofi theme"
sleep 2
# adding rofi theme
mkdir -p "$HOME/.config/rofi/"
cp "$HOME/Linux/dotfiles/config1.rasi" "$HOME/.config/rofi/config.rasi"

echo "Finished!"
sleep 2

# adding neovim plugin
echo "Adding neovim plugin"
sleep 2

mkdir -p "$HOME/.config/nvim/lua/plugins/"
cp "$HOME/Linux/dotfiles/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

echo "Finished!"
sleep 2

# adding yazi config
echo "Adding yazi config"
sleep 2

mkdir -p "$HOME/.config/yazi/"
cp "$HOME/Linux/dotfiles/yazi.toml" "$HOME/.config/yazi/"

echo "Finished!"
sleep 2

echo "Adding wallpaper"
sleep 2

mkdir -p ~/wallpaper/
cp -a "$HOME/Linux/wallpaper/." "$HOME/wallpaper/"

echo "Finished!"
sleep 2

echo "config firefox"
sleep 2

mkdir -p "$HOME/$(find .mozilla/firefox/*.default-release -maxdepth 0)/chrome"
cp -a "$HOME/Linux/firefox/." "$HOME/$(find .mozilla/firefox/*.default-release -maxdepth 0)/chrome"
mv "$HOME/$(find .mozilla/firefox/*.default-release -maxdepth 0)/chrome/user.js" "$HOME/$(find .mozilla/firefox/*.default-release -maxdepth 0)"

echo "Finished!"
sleep 2

echo "Adding i3-lock customization"
sleep 2

mkdir -p "$HOME/.config/i3-lock/"
cp -r "$HOME/Linux/i3lock-color/" "$HOME/"
bash "$HOME/i3lock-color/install-i3lock-color.sh"
cp "$HOME/Linux/dotfiles/lock.sh" "$HOME/.config/i3-lock/lock.sh"

echo "Finished!"
sleep 2

# configure firewall with ufw
echo "configure firewall"
sleep 2

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
sudo ufw status

echo "Finished!"
sleep 2

# remove redundand programs
sudo pacman -R dolphin code fastfetch vim pokemon-colorscripts-git nano vim xterm

# run scripts
echo "running neovim.sh"
sleep 2

bash "$HOME/Linux/neovim.sh"
bash "$HOME/Linux/yay.sh"
bash "$HOME/Linux/p10k-theme.sh"

echo "Finished!"
echo "Good Bye!"
sleep 2

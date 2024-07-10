#! /bin/bash

# import os information location
source /etc/os-release

packages=("git" "steam" "discord" "eza" "waybar" "hyprpaper" "btop" "zsh" "neofetch" "yazi" "neovim" "unzip" "fzf" "ntfs-3g" "fuse2" "wget" "curl" "gamemode" "mangohud" "zoxide" "bat" "bluez" "bluez-utils" "alacritty")

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

read -p "Do you want to install oh-my-zsh? (y/n)" ohmyzsh

if [[ "$ohmyzsh" == "y" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

read -p "Do you want to install zsh-plugins (y/n)" zshplugins

if [[ $zshplugins == "y" ]]; then
  if [[ -d "~/zsh-plugins" ]]; then
    rm -r ~/zsh-plugins
  fi
  cd ~
  mkdir zsh-plugins
  cd zsh-plugins
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  sleep 1
  git clone https://github.com/zsh-users/zsh-autosuggestions.git
  sleep 1
  echo "source ~/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.zshrc
  echo "source ~/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>~/.zshrc
fi

read -p "Do you want to install Vencord? (y/n)" vencord

if [[ $vencord == "y" ]]; then
  sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
fi

echo "Moving dotfiles to system"
sleep 1

if [[ ! -d "$HOME/.config/neofetch/" ]]; then
  mkdir -p "$HOME/.config/neofetch/"
fi

# installing yay

git clone "https://aur.archlinux.org/yay.git"
cd "$HOME/yay"
makepkg -si

read -p "Want to install google chrome with yay? (y/n)" google
if [[ "$google" == "y" ]]; then
  yay -S google-chrome
fi

# Adding neofetch theme to maschine
cp "$HOME/Linux/Neofetch-Theme/ozoz.txt" "$HOME/.config/neofetch/config.conf"

bash "$HOME/Linux/neovim.sh"

bash "$HOME/Linux/p10k-theme.sh"

if [[ ! -d "$HOME/.config/alacritty/" ]]; then
  mkdir -r "$HOME/.config/alacritty/"
fi

# adding alacritty
cp "$HOME/Linux/dotfiles/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# adding waybar
if [[ ! -d "$HOME/.config/waybar/" ]]; then
  mkdir -r "$HOME/.config/waybar/"
fi

cp "$HOME/Linux/dotfiles/waybar/*" "$HOME/.config/waybar/"

# adding wallpaper
mkdir -p "$HOME/Pictures/wallpaper/"
cp "$HOME/Linux/wallpaper/*" "$HOME/Pictures/wallpaper/"

# adding hyprland config
cp "$HOME/Linux/dotfiles/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
cp "$HOME/Linux/dotfiles/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"

# adding sddm theme
mkdir -p "/usr/share/sddm/themes/"
cp -a "$HOME/Linux/sddm-themes/sugar-candy/." "/usr/share/sddm/themes/"
cp "$HOME/Linux/sddm.conf" "/etc/sddm.conf"

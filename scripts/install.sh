#! /bin/sh

echo "What package manager do you use?"
echo "(1) apt"
echo "(2) dnf"
echo "(3) pacman"

read answer

case $answer in
1)
  packages=("zip" "openrgb" "fish" "unzip" "wget" "curl" "neovim" "lazygit" "eza" "fastfetch" "btop" "gamemode" "mangohud" "zoxide" "fzf" "bat" "kitty")

  for package in "${packages[@]}"; do
    sudo apt install -y "$package"
  done

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

  # adding all configs
  echo "Adding btop config"
  sleep 2

  if [[ ! -d "$HOME/.config/btop/" ]]; then
    mkdir -p "$HOME/.config/btop/"
  fi
  cp "$HOME/Linux/btop/btop.conf" "$HOME/.config/btop/"

  echo "Finished!"
  sleep 2

  echo "Adding kitty config"
  sleep 2

  if [[ ! -d "$HOME/.config/kitty/" ]]; then
    mkdir -p "$HOME/.config/kitty/"
  fi

  cp -a "$HOME/Linux/kitty/." "$HOME/.config/kitty"

  echo "Finished!"
  sleep 2

  read -p "Use (1) fish or (2) zsh? " shell
  if [[ "$shell" -eq 2 ]]; then
    echo "adding zshrc"
    sleep 2

    bash "$HOME/Linux/scripts/p10k-theme.sh"
    cp "$HOME/Linux/zsh/debianzshrc" "$HOME/.zshrc"

    echo "Finished!"
    sleep 2
  elif [[ "$shell" -eq 1 ]]; then
    echo "adding fish config"
    sleep 2

    cp "$HOME/Linux/fish/debian.fish" "$HOME/.config/fish/config.fish"

    echo "Finished!"
    sleep2
  fi

  # adding neovim plugin
  echo "Adding neovim plugin"
  sleep 2

  echo "Runnung neovim script"
  sleep 2

  bash "$HOME/Linux/scripts/neovim.sh"

  if [[ ! -d "$HOME/.config/nvim/lua/plugins/" ]]; then
    mkdir -p "$HOME/.config/nvim/lua/plugins/"
  fi

  cp "$HOME/Linux/neovim/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

  echo "Finished!"
  sleep 2

  echo "Adding wallpaper"
  sleep 2

  if [[ ! -d "$HOME/Pictures/wallpaper" ]]; then
    mkdir -p "$HOME/Pictures/wallpaper"
  fi

  cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/wallpaper/"

  echo "Finished!"
  sleep 2

  echo "Adding font and cursor"
  sleep 2

  sudo cp "$HOME/Linux/Fonts/MesloLGS NF Regular.ttf" "/usr/share/fonts/"
  sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

  echo "Finished!"
  sleep 2
  ;;

2)
  packages=("zip" "openrgb" "fish" "unzip" "wget" "curl" "neovim" "lazygit" "eza" "fastfetch" "btop" "gamemode" "mangohud" "zoxide" "fzf" "bat" "kitty")

  for package in "${packages[@]}"; do
    sudo dnf install -y "$package"
  done

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

  # adding all configs
  # Adding neofetch theme to maschine
  echo "Adding neofetch config"
  sleep 2

  if [[ ! -d "$HOME/.config/neofetch/" ]]; then
    mkdir -p "$HOME/.config/neofetch/"
  fi

  cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

  echo "Finished!"
  sleep 2

  echo "Adding kitty config"
  sleep 2

  if [[ ! -d "$HOME/.config/kitty/" ]]; then
    mkdir -p "$HOME/.config/kitty/"
  fi

  cp -a "$HOME/Linux/kitty/." "$HOME/.config/kitty"

  echo "Finished!"
  sleep 2

  read -p "Use (1) fish or (2) zsh? " shell
  if [[ "$shell" -eq 2 ]]; then
    echo "adding zshrc"
    sleep 2

    bash "$HOME/Linux/scripts/p10k-theme.sh"
    cp "$HOME/Linux/zsh/fedorazshrc" "$HOME/.zshrc"

    echo "Finished!"
    sleep 2
  elif [[ "$shell" -eq 1 ]]; then
    echo "adding fish config"
    sleep 2

    cp "$HOME/Linux/fish/fedora.fish" "$HOME/.config/fish/config.fish"

    echo "Finished!"
    sleep2
  fi

  echo "Adding btop config"
  sleep 2

  if [[ ! -d "$HOME/.config/btop/" ]]; then
    mkdir -p "$HOME/.config/btop/"
  fi
  cp "$HOME/Linux/btop/btop.conf" "$HOME/.config/btop/"

  echo "Finished!"
  sleep 2

  # adding neovim plugin
  echo "Adding neovim plugin"
  sleep 2

  echo "Runnung neovim script"
  sleep 2

  bash "$HOME/Linux/scripts/neovim.sh"

  if [[ ! -d "$HOME/.config/nvim/lua/plugins/" ]]; then
    mkdir -p "$HOME/.config/nvim/lua/plugins/"
  fi

  cp "$HOME/Linux/neovim/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

  echo "Finished!"
  sleep 2

  read -p "Use (1) fish or (2) zsh? " shell
  if [[ "$shell" -eq 2 ]]; then
    echo "adding zshrc"
    sleep 2

    bash "$HOME/Linux/scripts/p10k-theme.sh"
    cp "$HOME/Linux/zsh/fedorazshrc" "$HOME/.zshrc"
  
    sudo chsh -s /usr/bin/zsh

    echo "Finished!"
    sleep 2
  elif [[ "$shell" -eq 1 ]]; then
    echo "adding fish config"
    sleep 2

    cp "$HOME/Linux/fish/fedora.fish" "$HOME/.config/fish/config.fish"

    sudo chsh -s /usr/bin/fish

    echo "Finished!"
    sleep2
  fi

  echo "Adding wallpaper"
  sleep 2

  if [[ ! -d "$HOME/Pictures/wallpaper" ]]; then
    mkdir -p "$HOME/Pictures/wallpaper"
  fi

  cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/wallpaper/"

  echo "Finished!"
  sleep 2

  echo "Adding font and cursor"
  sleep 2

  sudo cp "$HOME/Linux/Fonts/MesloLGS NF Regular.ttf" "/usr/share/fonts/"
  sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

  echo "Finished!"
  sleep 2
  ;;

3)
  packages=("zip" "fish" "gcc" "openrgb" "unzip" "wget" "curl" "neovim" "lazygit" "eza" "fastfetch" "btop" "gamemode" "mangohud" "zoxide" "fzf" "bat" "discord" "steam" "kitty")

  for package in "${packages[@]}"; do
    sudo pacman -S --noconfirm "$package"
  done

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

  # adding all configs
  # Adding neofetch theme to maschine
  echo "Adding neofetch config"
  sleep 2

  if [[ ! -d "$HOME/.config/neofetch/" ]]; then
    mkdir -p "$HOME/.config/neofetch/"
  fi

  cp "$HOME/Linux/Neofetch-Theme/config.conf" "$HOME/.config/neofetch/config.conf"

  echo "Finished!"
  sleep 2

  echo "Adding kitty config"
  sleep 2

  if [[ ! -d "$HOME/.config/kitty/" ]]; then
    mkdir -p "$HOME/.config/kitty/"
  fi

  cp -a "$HOME/Linux/kitty/." "$HOME/.config/kitty"

  echo "Finished!"
  sleep 2

  read -p "Use (1) fish or (2) zsh? " shell
  if [[ "$shell" -eq 2 ]]; then
    echo "adding zshrc"
    sleep 2

    bash "$HOME/Linux/scripts/p10k-theme.sh"
    cp "$HOME/Linux/zsh/archzshrc" "$HOME/.zshrc"
  
    sudo chsh -s /usr/bin/zsh

    echo "Finished!"
    sleep 2
  elif [[ "$shell" -eq 1 ]]; then
    echo "adding fish config"
    sleep 2

    cp "$HOME/Linux/fish/arch.fish" "$HOME/.config/fish/config.fish"

    sudo chsh -s /usr/bin/fish

    echo "Finished!"
    sleep2
  fi

  echo "Adding btop config"
  sleep 2

  if [[ ! -d "$HOME/.config/btop/" ]]; then
    mkdir -p "$HOME/.config/btop/"
  fi
  cp "$HOME/Linux/btop/btop.conf" "$HOME/.config/btop/"

  echo "Finished!"
  sleep 2

  # adding neovim plugin
  echo "Adding neovim plugin"
  sleep 2

  echo "Runnung neovim script"
  sleep 2

  bash "$HOME/Linux/scripts/neovim.sh"

  if [[ ! -d "$HOME/.config/nvim/lua/plugins/" ]]; then
    mkdir -p "$HOME/.config/nvim/lua/plugins/"
  fi

  cp "$HOME/Linux/neovim/lazygit.lua" "$HOME/.config/nvim/lua/plugins/"

  echo "Finished!"
  sleep 2

  echo "adding zshrc"
  sleep 2

  read -p "Are you using manjaro-kde? (y/n)" manjaro

  if [[ "$manjaro" == "y" ]]; then
    cp "$HOME/Linux/zsh/manjaro-zshrc" "$HOME/.zshrc"
  else
    cp "$HOME/Linux/zsh/archzshrc" "$HOME/.zshrc"
  fi

  echo "Finished!"
  sleep 2

  echo "Adding wallpaper"
  sleep 2

  if [[ ! -d "$HOME/Pictures/wallpaper" ]]; then
    mkdir -p "$HOME/Pictures/wallpaper"
  fi

  cp -a "$HOME/Linux/wallpaper/." "$HOME/Pictures/wallpaper/"

  echo "Finished!"
  sleep 2

  echo "Adding font and cursor"
  sleep 2

  sudo cp "$HOME/Linux/Fonts/MesloLGS NF Regular.ttf" "/usr/share/fonts/"
  sudo cp -r "$HOME/Linux/Cursor/Bibata-Modern-Ice/" "/usr/share/icons/"

  echo "Finished!"
  sleep 2
  ;;

*)
  echo "Do not know what to do, Bye!!"
  exit 223
  ;;
esac

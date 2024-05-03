#!/bin/bash

source /etc/os-release

echo "Welcome to my after linux gnome installation configurater script"
sleep 1

read -a packages -p "What packages do you want to install?"

if [[ $ID == "fedora" ]]; then
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

echo "Do you have git installed? (y/n)"

read git_installed

if [[ $ID == "fedora" ]]; then
    sudo dnf install git
elif [[ $ID == "arch" ]]; then
    sudo pacman -S git
else 
    sudo apt install git
fi
sleep 1

echo "Ready to add ssh-key? (y/n)"
read sshready

if [[ $sshready == "y" ]]; then
    echo "Do not change de default file location and name in the following!!!"
    read -p "what is your email account?" email
    ssh-keygen -t ed25519 -C $email
    ssh-add ~/.ssh/id_ed25519
fi

echo "Paste the following content in your ssh-key section in Github"
echo $(cat ~/.ssh/id_ed25519.pub)

echo "Do you want to install oh-my-zsh? (y/n)"
read ohmyzsh

if [[ $ohmyzsh == "y" ]]; then 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

sleep 1

echo "Do you want to install zsh-plugins (y/n)"

read zshplugins

if [[ $zshplugins == "y" ]]; then
    mkdir ~/zsh-plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-plugins 
    echo "source ~/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/zsh-plugins
    echo "source ~/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
fi

sleep 1

echo "Do you want to spice up nano? (y/n)
read spiceup

if [[ $spiceup == "y" ]]; then
    cd ~
    rm ~/.nanorc
    touch .nanorc
    echo -e "# Non-default settings\n
        set atblanks        # wrap line at blanks.\n
        set cutfromcursor   # CTRL+K cuts from cursor position to end of line.\n
        set nohelp          # Disable the help information (CTRL+G to view the help screen).\n
        set softwrap        # Enable softwrap of lines.\n
        set tabsize 4       # Sets tab-to-spaces size to 4.\n
        set tabstospaces    # Converts TAB key press to spaces.\n
        include "/usr/share/nano/*.nanorc" # Enables the syntax highlighting.\n
        set speller "aspell -x -c"         # Sets what spelling utility to use.\n
        set constantshow    # Displays useful information e.g. line number and position in the bottom bar.\n
        set linenumbers     # Lines are numbered.\n
        set casesensitive   # Case insensitive search.\n
        set historylog      # Save the last 100 history searches for later use.\n
        set positionlog     # Saves the cursor position between editing sessions.\n
        set zap             # Allows you to highlight text (CTRL+SHIFT+ARROW) and delete it with backspace.\n
        set autoindent      # A new line will have the same number of leading spaces as the previous one.\n
        set indicator       # Displays a scroll bar on the right that shows the position and size of the current view port.\n
        set minibar         # Displays file name and other information in the bottom bar. Removes top bar.\n

        # Shortcut key bindings
        bind ^C copy main       # CTRC+C - Copy
        bind ^V paste all       # CTRL+V - Past
        bind ^F whereis all     # CTRL+F - Find
        bind ^S savefile main   # CTRL+S - Save " >> ~/.nanorc
fi

echo "Thank you for using my script! :)"
sleep 1

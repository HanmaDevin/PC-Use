#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo "Adding zshrc"
sleep 2

cp "$HOME/Linux/dotfiles/zshrc" "$HOME/.zshrc"

echo "Finished!"
sleep 2

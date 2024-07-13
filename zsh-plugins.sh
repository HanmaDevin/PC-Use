#!/bin/bash

echo "Adding zsh plugins"
sleep 2

git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git"
git clone "https://github.com/zsh-users/zsh-autosuggestions.git"

echo "Adding zshrc"
sleep 2

cp "$HOME/Linux/dotfiles/zshrc" "$HOME/.zshrc"

echo "Finished!"
sleep 2

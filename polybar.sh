#! /bin/bash

git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
cd "$HOME/polybar-themes/"
chmod +x "$HOME/polybar-themes/setup.sh"
bash "$HOME/polybar-themes/setup.sh"

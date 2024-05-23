# Bash Scripts

## About

I am learning bash scripting and in here i want to graduatly add usefull scripts for myself and anybody else.

## Scripts

The after linux installation script walks you through a few steps to get your system with basic developer tools running.
First you can install what ever packages you want to install. Then you can setup git and create a beautiful terminal.
There is also a useful nano and vim configuration which can be added. At the end you can install Vencord, a useful tool for Discord.
With Vencord you can customize Discord with a bunch of plugins.

### Neovim

The ***neovim.sh*** script-file helps you to quickly setup an IDE in your terminal.
The commands to use the IDE are:

* CTRL + P: find files
* CTRL + S: find everything
* CTRL + N, ENTER: navigate workingtree
* SHIFT + K: get Function overview in popup window
* CTRL + D: go to definition
* CTRL + L: format

You need to install *stylua*, *rubocop*, *prettier*, *eslint_d*, *black*, *isort* and *lua_language_server* in the Mason plugin within neovim with the ```:Mason``` command. Then search for the package with 
```/package```, press Enter and then 'i' to install it.

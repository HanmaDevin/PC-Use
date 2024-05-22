vim.cmd("set tabstop=2")
vim.cmd("filetype indent on")
vim.cmd("set number")
vim.cmd("filetype on")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


local opts = {}

require("lazy").setup("plugins")
local builtin = require("telescope.builtin")

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left', {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "python", "c", "java"},
  highlight = {enable = true}, 
  indent = {enable = true},
})

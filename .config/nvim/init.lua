require('config/autocmds')
require('plugins/init')

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.cmd("syntax on")
vim.opt.hlsearch = true

vim.cmd("colorscheme vim")
vim.opt.background = "dark"
vim.opt.termguicolors = false
vim.opt.laststatus = 2

-- Clipboard
vim.opt.clipboard = "unnamedplus"

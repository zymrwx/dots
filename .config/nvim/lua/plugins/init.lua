local vim = vim
local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('https://github.com/nvim-treesitter/nvim-treesitter')
Plug('https://github.com/h-hg/fcitx.nvim')

vim.call('plug#end')

require('plugins/nvim-treesitter')

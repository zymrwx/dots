local languages = { 'markdown',
                    'markdown_inline',
                    'diff',
                    'make',
                    'c',
                    'bash',
                    'python',
                    'lua',
                    'java',
}

require'nvim-treesitter'.install(languages)

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function() vim.treesitter.start() end,
})

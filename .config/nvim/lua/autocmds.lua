vim.api.nvim_set_hl(0, 'TrailingSpace', { ctermbg = 'gray', bg = 'gray' })

local group = vim.api.nvim_create_augroup('TrailingSpace', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  callback = function()
    vim.api.nvim_set_hl(0, 'TrailingSpace', { ctermbg = 'gray', bg = 'gray' })
  end,
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinNew' }, {
  group = group,
  callback = function()
    vim.fn.matchadd('TrailingSpace', [[\s\+$]])
  end,
})

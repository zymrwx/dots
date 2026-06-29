vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "/tmp/qutebrowser-editor-*",
  group = vim.api.nvim_create_augroup("qutebrowser", { clear = true }),
  callback = function() vim.bo.filetype = "markdown" end,
})


vim.api.nvim_set_hl(0, 'TrailingSpace', { ctermbg = 'gray', bg = 'gray' })
local augroup = vim.api.nvim_create_augroup('TrailingSpace', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'TrailingSpace', { ctermbg = 'gray', bg = 'gray' })
  end,
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinNew' }, {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.fn.matchadd('TrailingSpace', '\\s\\+$')
  end,
})

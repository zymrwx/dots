vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "/tmp/qutebrowser-editor-*",
  group = vim.api.nvim_create_augroup("qutebrowser", { clear = true }),
  callback = function() vim.bo.filetype = "markdown" end,
})

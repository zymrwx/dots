highlight TrailingSpace ctermbg=gray guibg=gray
augroup TrailingSpace
  autocmd!
  autocmd ColorScheme * highlight TrailingSpace ctermbg=gray guibg=gray
  " Match on startup and when new windows are created
  autocmd VimEnter,WinNew * call matchadd('TrailingSpace', '\s\+$')
augroup END

augroup dvtmeditor
    autocmd!
    autocmd BufRead,BufNewFile /tmp/dvtm-editor.*
        \ setlocal nonumber norelativenumber laststatus=0 syntax=OFF
augroup END


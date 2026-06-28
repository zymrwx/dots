augroup dvtmeditor
    autocmd!
    autocmd BufRead,BufNewFile /tmp/dvtm-editor.* setlocal nonumber
    autocmd BufRead,BufNewFile /tmp/dvtm-editor.* setlocal norelativenumber
    autocmd BufRead,BufNewFile /tmp/dvtm-editor.* setlocal laststatus=0
    autocmd BufRead,BufNewFile /tmp/dvtm-editor.* syntax off
augroup END

augroup dvtmeditor
    autocmd!
    autocmd BufRead,BufNewFile /tmp/dvtm-editor.*
        \ setlocal nonumber norelativenumber laststatus=0 syntax=OFF
augroup END


autocmd! BufNewFile,BufRead *.txt call s:structured_text()


function! s:structured_text()
    execute 'setfiletype text'
    execute 'setlocal syntax=sh'
endfunction


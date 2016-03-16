function cplane#sct#events#AutoTagON()
    execute 'augroup SctAutoTag'
    execute 'autocmd!'
    execute 'autocmd BufEnter *.ttcn3,*.ttcn  :call cplane#sct#tags#UpdateIfNeeded()'
    execute 'augroup END'
endfunction

function cplane#sct#events#AutoTagOFF()
    execute 'augroup SctAutoTag'
    execute 'autocmd!'
    execute 'augroup END'
    execute 'augroup! SctAutoTag'
endfunction

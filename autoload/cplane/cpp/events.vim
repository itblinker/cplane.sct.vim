function cplane#cpp#events#AutoTagON()
    execute 'augroup CppAutoTag'
    execute 'autocmd!'
    execute 'autocmd BufEnter *.cpp,*.hpp,*.c,*.h :call cplane#cpp#tags#UpdateIfNeeded()'
    execute 'augroup END'
endfunction

function cplane#cpp#events#AutoTagOFF()
    execute 'augroup CppAutoTag'
    execute 'autocmd!'
    execute 'augroup END'
    execute 'augroup! CppAutoTag'
endfunction

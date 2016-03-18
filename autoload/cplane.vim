"{{{ autotag
function cplane#AutoTagON()
    call cplane#cpp#events#AutoTagON()
    call cplane#sct#events#AutoTagON()
endfunction


function cplane#AutoTagOFF()
    call cplane#cpp#events#AutoTagOFF()
    call cplane#sct#events#AutoTagOFF()
endfunction
"}}}

"{{{ retag
function cplane#Retag()
    let l:filetype = &filetype
    if(filetype ==# 'cpp')
        call cplane#cpp#tags#Update()
    elseif (l:filetype == 'ttcn')
        call cplane#sct#tags#Update()
    endif
endfunction
"}}}

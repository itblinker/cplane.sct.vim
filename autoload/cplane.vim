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

function cplane#GetVariant()
    return g:cplane#cache#variant
endfunction


function cplane#EchoVariant()
    execute 'echo ''variant in use: '.g:cplane#cache#variant.''''
endfunction


function cplane#SaveVariant(p_variant)
    try
        call maktaba#ensure#IsString(a:p_variant, 'variant must be string')
        call maktaba#ensure#IsTrue(has_key(g:variants, a:p_variant), 'variant '.a:p_variant.' it is not supported')
    catch
        return
    endtry
    execute 'echomsg ''saving variant'''
    let g:cplane#cache#variant = a:p_variant
endfunction

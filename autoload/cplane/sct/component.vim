let s:components = [
            \ {'name': g:rrom, 'key_dir': 'RROM'},
            \ {'name': g:uec, 'key_dir': 'UEC'},
            \ {'name': g:enbc, 'key_dir': 'ENBC'},
            \ {'name': g:cellc, 'key_dir': 'CELLC'},
            \ {'name': g:tupc, 'key_dir': 'TUPC'},
            \ {'name': g:mcec, 'key_dir': 'MCEC'},
            \ {'name': g:common, 'key_dir': 'Common'}
            \ ]

"{{{ funcitons
function cplane#sct#component#GetNameFromBuffer()
    let l:path = maktaba#path#Split(expand('%:p:h'))

    for item in s:components
        if(index(l:path, item.key_dir) >= 0)
            return item.name
        endif
    endfor

    return g:cplane#component#None
endfunction


function cplane#sct#component#IsSupported(p_name)
    for item in s:components
        if (a:p_name ==# item.name)
            return 1
        endif
    endfor

    return 0
endfunction


function cplane#sct#component#Cache(p_name)
    try
        call maktaba#ensure#IsString(a:p_name)
        call maktaba#ensure#IsTrue(cplane#sct#component#IsSupported(a:p_name))
    catch
        call maktaba#error#Shout('component name is not supported')
        return
    endtry

    let g:cplane#sct#cache#component = a:p_name

endfunction


function cplane#sct#component#IsCacheOutdated(p_component)
    if ! (a:p_component ==# g:cplane#sct#cache#component)
        return 1
    else
        return 0
    endif
endfunction


function cplane#sct#component#IsCacheHasNotBeenInitialized()
    if(g:cplane#sct#cache#component ==# g:cplane#component#None)
        return 1
    else
        return 0
    endif
endfunction
"}}}

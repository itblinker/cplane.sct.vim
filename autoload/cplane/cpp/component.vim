let s:components = [
            \ {'name': g:rrom, 'key_dir': 'SC_RROM'},
            \ {'name': g:uec, 'key_dir': 'SC_UEC'},
            \ {'name': g:enbc, 'key_dir': 'SC_ENBC'},
            \ {'name': g:cellc, 'key_dir': 'SC_CELLC'},
            \ {'name': g:tupc, 'key_dir': 'SC_TUPC'},
            \ {'name': g:mcec, 'key_dir': 'SC_MCEC'},
            \ {'name': g:common, 'key_dir': 'SC_Common'},
            \ {'name': g:lom, 'key_dir': 'SC_LOM'}
            \ ]


function cplane#cpp#component#IsSupported(p_name)
    for item in s:components
        if (a:p_name ==# item.name)
            return 1
        endif
    endfor

    return 0
endfunction


function cplane#cpp#component#Cache(p_name)
    try
        call maktaba#ensure#IsString(a:p_name)
        call maktaba#ensure#IsTrue(cplane#cpp#component#IsSupported(a:p_name))
    catch
        call maktaba#error#Shout('component name is not supported')
        return
    endtry

    let g:cplane#cpp#cache#component = a:p_name

endfunction


function cplane#cpp#component#GetNameFromBuffer()
    let l:path = maktaba#path#Split(expand('%:p:h'))

    for item in s:components
        if(index(l:path, item.key_dir) >= 0)
            return item.name
        endif
    endfor

    return g:cplane#component#None
endfunction


function cplane#cpp#component#IsCacheOutdated(p_component)
    if ! (a:p_component ==# g:cplane#cpp#cache#component)
        return 1
    else
        return 0
    endif
endfunction


function cplane#cpp#component#IsCacheHasNotBeenInitialized()
    if(g:cplane#cpp#cache#component ==# g:cplane#component#None)
        return 1
    else
        return 0
    endif
endfunction


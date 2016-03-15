let s:components = [
            \ {'name': g:rrom, 'dir': 'SC_RROM'},
            \ {'name': g:uec, 'dir': 'SC_UEC'},
            \ {'name': g:enbc, 'dir': 'SC_ENBC'},
            \ {'name': g:cellc, 'dir': 'SC_CELLC'},
            \ {'name': g:tupc, 'dir': 'SC_TUPC'},
            \ {'name': g:mcec, 'dir': 'SC_MCEC'},
            \ {'name': g:common, 'dir': 'SC_Common'},
            \ {'name': g:lom, 'dir': 'SC_LOM'}
            \ ]

function cplane#cpp#component#UpdateCacheAndRetagIfNeedeed()
    let l:newOne = cplane#cpp#component#GetNameFromBuffer()
    if (l:newOne ==# g:cplane#component#None)
        return
    endif

    if (cplane#cpp#component#IsCacheOutdated(l:newOne))
        if cplane#cpp#component#IsCacheHasNotBeenInitialized()
            call cplane#cpp#component#Cache(l:newOne)
            call cplane#cpp#tags#Do(l:newOne)
            return
        endif

        if ! (l:newOne ==# g:common)
            call cplane#cpp#component#Cache(l:newOne)
            call cplane#cpp#tags#Do(l:newOne)
        endif
    endif

endfunction


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
        if(index(l:path, item.dir) >= 0)
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


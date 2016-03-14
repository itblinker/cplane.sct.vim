function cplane#cpp#UpdateComponent()

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

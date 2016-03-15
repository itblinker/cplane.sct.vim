let s:common_sacks = [
            \ getcwd().'/lteDo'
            \ ]

let s:parameters = {
            \ g:rrom   : [getcwd().'/C_Application/SC_RROM'],
            \ g:uec    : [getcwd().'/C_Application/SC_UEC'],
            \ g:enbc   : [getcwd().'/C_Application/SC_ENBC'],
            \ g:cellc  : [getcwd().'/C_Application/SC_CELLC'],
            \ g:tupc   : [getcwd().'/C_Application/SC_TUP'],
            \ g:mcec   : [getcwd().'/C_Application/SC_MCEC'],
            \ g:lom    : [getcwd().'/C_Application/SC_LOM'],
            \ g:common : [getcwd().'/C_Application/SC_Common']
            \ }

let s:find_arg = ' -name ''*.cpp'' -o -name ''*.hpp'' -o -name ''*.h'' -o -name ''*.c'' '
let s:tempFileToStoreSources = '.cache.gtags.cpp.sources'

"{{{ functions
"{{{ One-Time Path Validation
    "{{{ validation methods

    function s:getListOfPathsForComponent(p_component)
        if (a:p_component ==# g:common)
            return s:parameters[g:common]
        else
            return s:parameters[a:p_component] + s:parameters[g:common]
        endif
    endfunction


    function s:validatePath(p_path)
        call maktaba#ensure#IsDirectory(a:p_path)
    endfunction


    function s:validateListOfPaths(p_listOfPaths)
        for path in a:p_listOfPaths
            call s:validatePath(path)
        endfor
    endfunction


    function s:validatePaths()
        for key in keys(s:parameters)
            call s:validateListOfPaths(s:getListOfPathsForComponent(key))
        endfor

        call s:validateListOfPaths(s:common_sacks)
    endfunction

    "}}}
call s:validatePaths()
"}}}


function cplane#cpp#tags#Do(p_component)

    call cplane#cpp#tags#RemovePreviousListFile()

    let l:listOfAllNeededPaths = s:getListOfPathsForComponent(a:p_component) + s:common_sacks
    for path in l:listOfAllNeededPaths
        execute 'Start! find '.path.' '.s:find_arg.' >> '.s:tempFileToStoreSources
    endfor

    execute 'Start -wait=''error'' gtags -f '.s:tempFileToStoreSources
    execute 'Start -wait=''error'' rm -f '.s:tempFileToStoreSources
endfunction


function cplane#cpp#tags#RemovePreviousListFile()
    if filereadable(s:tempFileToStoreSources)
        execute 'Start -wait rm -f'.s:tempFileToStoreSources
    endif
endfunction


function cplane#cpp#tags#Update()
    let l:currentOne = cplane#cpp#component#GetNameFromBuffer()
    try
        call maktaba#ensure#IsTrue(cplane#cpp#component#IsSupported(l:currentOne))
        call cplane#cpp#tags#Do(l:currentOne)
    catch
        call maktaba#error#Shout('cplane.vim: cann''t tag the component resolved as %s', l:currentOne)
    endtry
endfunction


function cplane#cpp#tags#UpdateIfNeeded()
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
"}}}

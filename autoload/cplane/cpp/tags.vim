let s:symlinksDir = [
            \ getcwd().'/C_Application/OpenGrok',
            \  ]

let s:common_sacks = [
            \ getcwd().'/lteDo/gencode',
            \ getcwd().'/lteDo/C_Application'
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


let s:tempFileToStoreSources = '.cache.gtags.cpp.sources'
"let s:find_arg_with_UTs = ' -name ''*.cpp'' -o -name ''*.hpp'' -o -name ''*.h'' -o -name ''*.c'' '

let s:find_arg_with_UTs = ' -type f \( -iname ''*.cpp'' -o -iname ''*.hpp'' -o -iname ''*.h'' -o -iname ''*.c'' \) '
let s:find_arg_without_UTs = ' -type f \( -iname ''*.cpp'' -o -iname ''*.hpp'' -o -iname ''*.h'' -o -iname ''*.c'' \) \! -path ''*Test_module*'' '

function s:getFindArguments()
    if (g:tag_cpp_with_tests == 1)
        return s:find_arg_with_UTs
    else
        return s:find_arg_without_UTs
    endif
endfunction

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
        try
            call maktaba#ensure#IsDirectory(a:p_path)
        catch
            call maktaba#error#Shout('cplane.vim, taggin: cannot find path: '.a:p_path)
        endtry
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
        call s:validateListOfPaths(s:symlinksDir)
    endfunction

    "}}}
call s:validatePaths()
"}}}
"{{{ helpers

function s:execute(p_component)

    call s:removePreviousListOfFiles()
    call s:createListOfFilesToTag(a:p_component)
    call s:appendFilesFromSymlinksToTagginList(s:symlinksDir)

    execute 'Start -wait=''error'' gtags -f '.s:tempFileToStoreSources
endfunction


function s:createListOfFilesToTag(p_component)
    let l:listOfAllNeededPaths = s:getListOfPathsForComponent(a:p_component) + s:common_sacks
    for path in l:listOfAllNeededPaths
        let l:cmd = 'Start! find '.path.' '.s:getFindArguments().' >> '.s:tempFileToStoreSources
        execute l:cmd
    endfor
endfunction


function s:appendFilesFromSymlinksToTagginList(p_listOfPaths)
    for path in a:p_listOfPaths
        let l:cmd = 'Start! find -L '.path.' '.s:getFindArguments().' >> '.s:tempFileToStoreSources
        execute l:cmd
    endfor
endfunction


function s:removePreviousListOfFiles()
    if filereadable(s:tempFileToStoreSources)
        execute 'Start -wait rm -f '.s:tempFileToStoreSources
    endif
endfunction
"}}}

function cplane#cpp#tags#Update()
    let l:currentOne = cplane#cpp#component#GetNameFromBuffer()
    try
        call maktaba#ensure#IsTrue(cplane#cpp#component#IsSupported(l:currentOne))
        call s:execute(l:currentOne)
    catch
        call maktaba#error#Shout('cplane.vim: cann''t tag the sources for component resolved as %s (check if is buffer is from ../C_Application/.. or ../C_Test/.. )', l:currentOne)
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
            call s:execute(l:newOne)
            return
        endif

        if ! (l:newOne ==# g:common)
            call cplane#cpp#component#Cache(l:newOne)
            call s:execute(l:newOne)
        endif
    endif

endfunction

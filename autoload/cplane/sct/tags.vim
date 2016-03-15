let s:component_sack = {
            \ g:rrom  : [getcwd().'/lteDo/gencode/RROM'],
            \ g:uec   : [getcwd().'/lteDo/gencode/UEC'],
            \ g:enbc  : [getcwd().'/lteDo/gencode/ENBC'],
            \ g:cellc : [getcwd().'/lteDo/gencode/CELLC'],
            \ g:tupc  : [getcwd().'/lteDo/gencode/TUPC'],
            \ g:mcec  : [getcwd().'/lteDo/gencode/MCEC']
            \ }

let s:common_sacks = [
            \ getcwd().'/lteDo/gencode/constants',
            \ getcwd().'/C_Test/cplane_k3/src/Common'
            \ ]

let s:parameters = {
            \ g:rrom   : [getcwd().'/C_Test/cplane_k3/src/TestTargets/RROM'],
            \ g:uec    : [getcwd().'/C_Test/cplane_k3/src/TestTargets/UEC'],
            \ g:enbc   : [getcwd().'/C_Test/cplane_k3/src/TestTargets/ENBC'],
            \ g:cellc  : [getcwd().'/C_Test/cplane_k3/src/TestTargets/CELLC'],
            \ g:tupc   : [getcwd().'/C_Test/cplane_k3/src/TestTargets/TUPC'],
            \ g:mcec   : [getcwd().'/C_Test/cplane_k3/src/TestTargets/MCEC'],
            \ g:common : [getcwd().'/C_Test/cplane_k3/src/Common']
            \ }

let s:find_arg = ' \( ! -regex ''.*/\..*'' \) -type f -name ''*.ttcn3'' '
let s:tempFileToStoreSources = '.cache.ctags.sct.sources'
let s:ctagFile = getcwd().'/.ttcn3.ctags'

"{{{ functions
"{{{ One-Time Path Validation
    "{{{ validation methods

    function s:getListOfPathsForComponent(p_component)
        if (a:p_component ==# g:common)
            return s:parameters[g:common]
        else
            return s:parameters[a:p_component] + s:component_sack[a:p_component]
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


function cplane#sct#tags#Do(p_component)

    call cplane#sct#tags#RemovePreviousListFile()

    let l:listOfAllNeededPaths = s:getListOfPathsForComponent(a:p_component) + s:common_sacks
    for path in l:listOfAllNeededPaths
        execute 'Start! find '.path.' '.s:find_arg.' >> '.s:tempFileToStoreSources
    endfor

    execute 'Start -wait=''error'' ctags-with-ttcn -f '.s:ctagFile.' --language-force=ttcn -L '.s:tempFileToStoreSources
    execute 'set tag='.s:ctagFile

endfunction


function cplane#sct#tags#RemovePreviousListFile()
    if filereadable(s:tempFileToStoreSources)
        execute 'Start -wait rm -f'.s:tempFileToStoreSources
    endif
endfunction



function cplane#sct#tags#Update()
    let l:currentOne = cplane#sct#component#GetNameFromBuffer()
    try
        call maktaba#ensure#IsTrue(cplane#sct#component#IsSupported(l:currentOne))
        call cplane#sct#tags#Do(l:currentOne)
    catch
        call maktaba#error#Shout('cplane.vim: cann''t tag the component resolved as %s', l:currentOne)
    endtry
endfunction


function cplane#sct#tags#UpdateIfNeeded()
    let l:newOne = cplane#sct#component#GetNameFromBuffer()
    if (l:newOne ==# g:cplane#component#None)
        return
    endif

    if (cplane#sct#component#IsCacheOutdated(l:newOne))
        if cplane#sct#component#IsCacheHasNotBeenInitialized()
            call cplane#sct#component#Cache(l:newOne)
            call cplane#sct#tags#Do(l:newOne)
            return
        endif

        if ! (l:newOne ==# g:common)
            call cplane#sct#component#Cache(l:newOne)
            call cplane#sct#tags#Do(l:newOne)
        endif
    endif

endfunction

"}}}

let s:component_sack = {
            \ g:rrom  : 'RROM'  : [getcwd().'/lteDo/gencode/RROM'],
            \ g:uec   : 'UEC'   : [getcwd().'/lteDo/gencode/UEC'],
            \ g:enbc  : 'ENBC'  : [getcwd().'/lteDo/gencode/ENBC'],
            \ g:cellc : 'CELLC' : [getcwd().'/lteDo/gencode/CELLC'],
            \ g:tupc  : 'TUPC'  : [getcwd().'/lteDo/gencode/TUPC'],
            \ g:mcec  : 'MCEC'  : [getcwd().'/lteDo/gencode/MCEC']
            \ }

let s:common_sacks = [
            \ getcwd().'./lteDo/gencode/constants',
            \ getcwd().'./C_Test/cplane_k3/src/Common'
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

let s:find_arg = ' -name ''*.ttcn'' -o -name ''*.ttcn3'' '
let s:tempFileName = '.cache.ctags.sct.sources'

"{{{ One-Time Path Validation
    "{{{ validation methods

    function s:getListOfPaths(p_component)
        return s:parameters[a:p_component] + s:component_sack[a:p_component]
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
            call s:validateListOfPaths(s:getListOfPaths(key))
        endfor

        call s:validateListOfPaths(s:common_sacks)
    endfunction

    "}}}
call s:validatePaths()
"}}}


function cplane#sct#tags#Do(p_component)

    let l:paths = []
    if (a:p_component ==# g:common)
        let l:paths = s:getListOfPaths(g:common) + s:common_sacks
    else
        let l:paths = s:getListOfPaths(a:p_component) + s:getListOfPaths(g:common) + s:common_sacks
    endif

    for path in l:paths
        execute 'Start! find '.path.' '.s:find_arg.' >> '.s:tempFileName
    endfor

    "execute 'Start -wait=''error'' ctags-with-ttcn '.s:tempFileName
    execute 'Start -wait=''error'' rm -f '.s:tempFileName

    "TODO : clear older tags & setup new ones

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



let s:sacks = [
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
let s:tempFileName = 'gtags.sources'

"{{{ One-Time Path Validation
    "{{{ validation methods
    function s:getListOfPaths(p_component)
        return s:parameters[a:p_component]
    endfunction

    function s:validateListOfPaths(p_listOfPaths)
        for path in a:p_listOfPaths
            call maktaba#ensure#IsDirectory(path)
        endfor
    endfunction

    function s:validateParameters()
        let l:keys = keys(s:parameters)

        for key in l:keys
            call s:validateListOfPaths(s:getListOfPaths(key))
        endfor
    endfunction
    "}}}
call s:validateParameters()
"}}}


function cplane#cpp#tags#Do(p_component)

    let l:paths = s:getListOfPaths(a:p_component) + s:getListOfPaths(g:common) + s:sacks
    for path in l:paths
        execute 'Start! find '.path.' '.s:find_arg.' >> '.s:tempFileName
    endfor

    execute 'Start -wait=''error'' gtags -f '.s:tempFileName
    execute 'Start -wait=''error'' rm -f '.s:tempFileName
endfunction


let s:sacks = [getcwd().'/lteDo']

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
    echo 'TAGGING on '.a:p_component

    for path in s:getListOfPaths(a:p_component)
    endfor
endfunction


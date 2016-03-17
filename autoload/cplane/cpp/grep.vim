let s:parameters = {
            \ g:rrom   : getcwd().'/C_Application/SC_RROM',
            \ g:uec    : getcwd().'/C_Application/SC_UEC',
            \ g:enbc   : getcwd().'/C_Application/SC_ENBC',
            \ g:cellc  : getcwd().'/C_Application/SC_CELLC',
            \ g:tupc   : getcwd().'/C_Application/SC_TUP',
            \ g:mcec   : getcwd().'/C_Application/SC_MCEC',
            \ g:lom    : getcwd().'/C_Application/SC_LOM',
            \ g:common : getcwd().'/C_Application/SC_Common'
            \ }

let s:arg_common = ' -inHr '
let s:arg_include =' --include=*.cpp --include=*.hpp --include=*.c --include=*.h --include=*.mk '
let s:arg_exclude = ' --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.bzr '

let s:arguments = s:arg_common.s:arg_include.s:arg_exclude

"{{{ helpers
function s:getPath(p_component)
    if(has_key(s:parameters, a:p_component))
        return s:parameters[a:p_component]
    else
        return ''
    endif
endfunction


function s:getCmd(p_pattern, p_path)
    return 'grep! '.s:arguments.' -e '''.a:p_pattern.''' '.a:p_path
endfunction
"}}}

function cplane#cpp#grep#Execute(p_pattern)
    let l:sc = cplane#cpp#component#GetNameFromBuffer()
    let l:path = s:getPath(l:sc)

    if len(l:path)
        execute s:getCmd(a:p_pattern, l:path)
    else
        execute 'echo ''code grep error! unknown component source'' '
    endif
endfunction

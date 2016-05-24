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
let s:arg_exclude = ' --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.bzr --exclude-dir=*Test_module*'

let s:grepFlags = s:arg_common.s:arg_include.s:arg_exclude

"{{{ helpers
function s:getPath(p_component)
    if(has_key(s:parameters, a:p_component))
        return s:parameters[a:p_component]
    else
        return ''
    endif
endfunction

"}}}

function cplane#cpp#fgrep#Execute(p_pattern)
    let l:sc = cplane#cpp#component#GetNameFromBuffer()
    let l:path = s:getPath(l:sc)

    if len(l:path)
        execute manager#utils#GetFGrepCmd(a:p_pattern, l:path, s:grepFlags)
    else
        execute 'echo ''code grep error! unknown component source'' '
    endif
endfunction


function cplane#cpp#fgrep#from(...)
    if a:0 == 2
        execute manager#utils#GetFGrepCmd(a:1, a:2, s:grepFlags)
    else
        execute manager#utils#GetFGrepCmd(a:1, getcwd(), s:grepFlags)
    endif
endfunction

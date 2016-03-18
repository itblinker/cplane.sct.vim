let s:parameters = {
            \ g:rrom   : getcwd().'/C_Test/cplane_k3/src/TestTargets/RROM',
            \ g:uec    : getcwd().'/C_Test/cplane_k3/src/TestTargets/UEC',
            \ g:enbc   : getcwd().'/C_Test/cplane_k3/src/TestTargets/ENBC',
            \ g:cellc  : getcwd().'/C_Test/cplane_k3/src/TestTargets/CELLC',
            \ g:tupc   : getcwd().'/C_Test/cplane_k3/src/TestTargets/TUPC',
            \ g:mcec   : getcwd().'/C_Test/cplane_k3/src/TestTargets/MCEC',
            \ g:common : getcwd().'/C_Test/cplane_k3/src/Common'
            \ }

let s:path_CTest = getcwd().'/C_Test'

let s:arg_common = ' -inHr '
let s:arg_include =' --include=*.ttcn3'
let s:arg_exclude = ' --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.bzr '

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

function cplane#sct#grep#Execute(p_pattern)
    let l:sc = cplane#sct#component#GetNameFromBuffer()
    let l:path = s:getPath(l:sc)

    if len(l:path)
        execute manager#utils#GetFGrepCmd(a:p_pattern, l:path, s:grepFlags)
    else
        execute 'echo ''code grep error! unknown component source'' '
    endif
endfunction

function cplane#sct#grep#CTests(p_pattern)
    execute manager#utils#GetFGrepCmd(a:p_pattern, s:path_CTest, s:grepFlags)
endfunction

let s:parameters = {
            \ g:rrom   : getcwd().'/C_Test/cplane_k3/src/TestTargets/RROM',
            \ g:uec    : getcwd().'/C_Test/cplane_k3/src/TestTargets/UEC',
            \ g:enbc   : getcwd().'/C_Test/cplane_k3/src/TestTargets/ENBC',
            \ g:cellc  : getcwd().'/C_Test/cplane_k3/src/TestTargets/CELLC',
            \ g:tupc   : getcwd().'/C_Test/cplane_k3/src/TestTargets/TUPC',
            \ g:mcec   : getcwd().'/C_Test/cplane_k3/src/TestTargets/MCEC',
            \ g:common : getcwd().'/C_Test/cplane_k3/src/Common'
            \ }

let s:arg_common = ' -inHr '
let s:arg_include =' --include=*.ttcn3'
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

function cplane#sct#grep#Execute(p_pattern)
    let l:sc = cplane#sct#component#GetNameFromBuffer()
    let l:path = s:getPath(l:sc)

    if len(l:path)
        execute s:getCmd(a:p_pattern, l:path)
    else
        execute 'echo ''code grep error! unknown component source'' '
    endif
endfunction


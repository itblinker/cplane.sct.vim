let s:sc_script = {
            \ g:rrom   : 'sct_rrom.sh',
            \ g:uec    : 'sct_uec.sh',
            \ g:enbc   : 'sct_enbc.sh',
            \ g:cellc  : 'sct_cellc.sh',
            \ g:tupc   : 'sct_tupc.sh',
            \ g:mcec   : 'sct_mcec.sh'
            \ }

let s:script_path = getcwd().'/lteTools/scbm/bin'
let s:logs_top_dir = getcwd().'/logs/SCTs'

let s:common_flags = ' -basket ALL '
let s:compilation_flags = ' -k3conly '.s:common_flags
let s:build_flags = ' -keeplogs -keepk3log '.s:common_flags

"{{{ local functions
function s:getPathToLogsTopDir(p_variant)
    return s:logs_top_dir.'/'.a:p_variant
endfunction

function s:getBin(p_component)
    return s:script_path.'/'.s:sc_script[a:p_component]
endfunction


function s:getPathToLogs(p_testcaseName)
    return s:getPathToLogsTopDir(cplane#variant#Get()).'/'.a:p_testcaseName
endfunction


function s:getTestCaseFromCursorLine()
    let l:words = split(getline('.'))

    if( (len(l:words) >= 2) && (l:words[0] == 'testcase') )
        return strpart(l:words[1], 0, len(l:words[1]) - 2)
    else
        return ''
    endif
endfunction


function s:getCompilationFlags()
    return s:compilation_flags.'-logdir '.s:getPathToLogsTopDir(cplane#variant#Get())
endfunction


function s:getBuildAndRunFlags()
    return s:build_flags.'-logdir '.s:getPathToLogsTopDir(cplane#variant#Get())
endfunction


function s:compile(p_testcase)
    let l:SC = cplane#sct#component#GetNameFromBuffer()
    execute 'Dispatch '.s:getBin(l:SC).' -tcs '.a:p_testcase.s:getCompilationFlags()
endfunction


function s:buildAndRun(p_testcase)
    let l:SC = cplane#sct#component#GetNameFromBuffer()
    execute 'Dispatch '.s:getBin(l:SC).' -tcs '.a:p_testcase.s:getBuildAndRunFlags()
endfunction
"}}}


function cplane#sct#testcase#CompileFromCursorLine()
    let l:testcase = s:getTestCaseFromCursorLine()
    if(len(l:testcase))
        call s:compile(l:testcase)
    else
        execute 'echo ''compilation failed: move cursor on line with testcase name'' '
    endif
endfunction


function cplane#sct#testcase#BuildAndRunFromCursorLine()
    let l:testcase = s:getTestCaseFromCursorLine()
    if(len(l:testcase))
        call s:buildAndRun(l:testcase)
        "call cplane#sct#k3post#Do(cplane#sct#component#GetNameFromBuffer(), s:getPathToLogs(l:testcase) )
    else
        execute 'echo ''build and run failed: move cursor on line with testcase name'' '
    endif
endfunction


function cplane#sct#testcase#ProcessTestCaseLogsFromCursorLine()
    call cplane#sct#k3post#Do(cplane#sct#component#GetNameFromBuffer(), s:getPathToLogs(s:getTestCaseFromCursorLine()) )
endfunction

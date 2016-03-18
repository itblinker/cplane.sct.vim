let s:sc_script = {
            \ g:rrom   : 'sct_rrom.sh',
            \ g:uec    : 'sct_uec.sh',
            \ g:enbc   : 'sct_enbc.sh',
            \ g:cellc  : 'sct_cellc.sh',
            \ g:tupc   : 'sct_tupc.sh',
            \ g:mcec   : 'sct_mcec.sh'
            \ }

let s:variantsMap = {
            \ g:fsmr3_fdd  : 'fsmr3',
            \ g:fsmr3_tdd  : 'tddfsmr3',
            \ g:fsmr4_fdd  : 'fsmr4',
            \ g:fsmr4_tdd  : 'tddfsmr4'
            \ }

let s:lastTestCase = ''

let s:script_path = getcwd().'/lteTools/scbm/bin'
let s:logs_top_dir = getcwd().'/logs/SCTs'

let s:common_flags = ' -basket ALL '
let s:compilation_flags = ' -k3conly '.s:common_flags
let s:build_flags = ' -keeplogs -keepk3log '.s:common_flags
" variant

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


function s:getDynamicCompilationFlags()
    return ' -variant '.s:getVariant().' -logdir '.s:getPathToLogsTopDir(cplane#variant#Get())
endfunction


function s:getCompilationFlags()
    return s:compilation_flags.s:getDynamicCompilationFlags()
endfunction


function s:getBuildAndRunFlags()
    return s:build_flags.s:getDynamicCompilationFlags()
endfunction


function s:getVariant()
    call maktaba#ensure#IsTrue(has_key(s:variantsMap, cplane#variant#Get()))
    return s:variantsMap[cplane#variant#Get()]
endfunction

function s:storeParametersForK3(p_testcase, p_logPath)
    call add(g:cplane#cache#k3parameters, [a:p_testcase, a:p_logPath])
endfunction

function s:fetchParametersForK3()
    return g:cplane#cache#k3parameters
endfunction

function s:eraseUsedK3Parameters()
    let g:cplane#cache#k3parameters = []
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
        let s:lastTestCase = l:testcase
        call s:compile(l:testcase)
    else
        execute 'echo ''compilation failed: move cursor on line with testcase name'' '
    endif
endfunction


function cplane#sct#testcase#CompileLastOne()
    if len(s:lastTestCase)
        call s:compile(l:lastTestCase)
    else
        execute 'echo ''compilation failed: no previous compile tests'' '
    endif
endfunction


function cplane#sct#testcase#BuildAndRunFromCursorLine()
    let l:testcase = s:getTestCaseFromCursorLine()
    if(len(l:testcase))
        call s:storeParametersForK3(cplane#sct#component#GetNameFromBuffer(), s:getPathToLogs(l:testcase))
        call s:buildAndRun(l:testcase)
    else
        execute 'echo ''build and run failed: move cursor on line with testcase name'' '
    endif
endfunction


function cplane#sct#testcase#ProcessBuildedTestCases()
    for data in s:fetchParametersForK3()
        call cplane#sct#k3post#Do(data[0], data[1])
    endfor
    call s:eraseUsedK3Parameters()
endfunction

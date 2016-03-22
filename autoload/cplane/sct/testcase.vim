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

let s:script_path = getcwd().'/lteTools/scbm/bin'
let s:logs_top_dir = getcwd().'/logs/SCTs'

let s:common_flags = ' -basket ALL '
let s:compilation_flags = ' -k3conly '.s:common_flags
let s:build_flags = ' -keeplogs -keepk3log '.s:common_flags

"{{{ cache - last compialtion
let s:lastTestCaseData = {}

function s:fetchLastCompile()
    return s:lastTestCaseData
endfunction

function s:storeDataOfLastCompilation(p_testcase, p_variant)
    let s:lastTestCaseData = {'testcase': a:p_testcase, 'variant': a:p_variant}
endfunction
"}}}
"{{{ local functions
function s:getPathToLogsTopDir(p_variant)
    return s:logs_top_dir.'/'.a:p_variant
endfunction

function s:getBin(p_component)
    return s:script_path.'/'.s:sc_script[a:p_component]
endfunction


function s:getPathToLogs(p_variant, p_testcaseName)
    return s:getPathToLogsTopDir(a:p_variant.'/'.a:p_testcaseName)
endfunction


function s:cutOffBraces(p_string)
    let l:copy = a:p_string
    let l:copy = substitute(l:copy, ')', '', 'g')
    let l:copy = substitute(l:copy, '(', '', 'g')
    return l:copy
endfunction


function s:getTestCaseFromCursorLine()
    let l:words = split(getline('.'))

    if( (len(l:words) >= 2) && (l:words[0] == 'testcase') )
        return s:cutOffBraces(l:words[1])
    else
        return ''
    endif
endfunction


function s:getDynamicCompilationFlags(p_variant)
    return ' -variant '.s:getVariant(a:p_variant).' -logdir '.s:getPathToLogsTopDir(a:p_variant)
endfunction


function s:getCompilationFlags(p_variant)
    return s:compilation_flags.s:getDynamicCompilationFlags(a:p_variant)
endfunction


function s:getBuildAndRunFlags(p_variant)
    return s:build_flags.s:getDynamicCompilationFlags(a:p_variant)
endfunction


function s:getVariant(p_variant)
    call maktaba#ensure#IsTrue(has_key(s:variantsMap, a:p_variant))
    return s:variantsMap[a:p_variant]
endfunction


function s:storeParametersForK3(p_component, p_logPath, p_testcase)
    call add(g:cplane#cache#k3parameters, [a:p_component, a:p_logPath, a:p_testcase])
endfunction

function s:fetchParametersForK3()
    return g:cplane#cache#k3parameters
endfunction

function s:eraseUsedK3Parameters()
    let g:cplane#cache#k3parameters = []
endfunction


function s:compile(p_testcase, p_variant)
    let l:SC = cplane#sct#component#GetNameFromBuffer()
    execute 'Dispatch '.s:getBin(l:SC).' -tcs '.a:p_testcase.s:getCompilationFlags(a:p_variant)
endfunction

"{{{ 'backup existing logs'
let s:cache_logs_backup_current_id = {}
let s:cache_logs_backup_prefix = '.backup.'


function s:getBackupDestinationDirProposal(p_logPath)
    if(has_key(s:cache_logs_backup_current_id, a:p_logPath))
        let s:cache_logs_backup_current_id[a:p_logPath] += 1
    else
        let s:cache_logs_backup_current_id[a:p_logPath] = 0
    endif

    return a:p_logPath.s:cache_logs_backup_prefix.string(s:cache_logs_backup_current_id[a:p_logPath])
endfunction


function s:getBackupDestinationDir(p_logPath)
    let l:dirProposal = s:getBackupDestinationDirProposal(a:p_logPath)
    while isdirectory(l:dirProposal)
        let l:dirProposal = s:getBackupDestinationDirProposal(a:p_logPath)
    endwhile

    return l:dirProposal
endfunction


function s:backupPreviousLogs(p_logPath)
    if isdirectory(a:p_logPath)
        call system('mv -f '.a:p_logPath.' '.s:getBackupDestinationDir(a:p_logPath))
    endi
endfunction
"}}}

function s:buildAndRun(p_testcase, p_variant)
    let l:SC = cplane#sct#component#GetNameFromBuffer()


    execute 'Dispatch '.s:getBin(l:SC).' -tcs '.a:p_testcase.s:getBuildAndRunFlags(a:p_variant)
endfunction

"{{{ get variant from user
function s:isVariantValid(p_variant)
   if (index(values(s:variantsMap), a:p_variant) >= 0)
       return 1
   else
       return 0
   endif
endfunction


function s:GetVariantFromUser(p_info)
    let l:valid = 0
    while l:valid == 0
        let l:variant = input(a:p_info.' '.'[fsmr3][fsmr4][tddfsmr3][tddfsmr4] ? : ')
        let l:valid = s:isVariantValid(l:variant)
    endwhile
    return l:variant
endfunction
"}}}
"}}}

function cplane#sct#testcase#EchoParametersForKeptTestcase()
    let l:data = s:fetchLastCompile()
    if len(l:data)
        execute 'echo ''testcase: '.l:data.testcase.' | variant: '.l:data.variant.''''
    else
        execute 'echo ''data has not been stored! please compile/build some testcase first'''
    endif
endfunction


function cplane#sct#testcase#CompileFromCursorLine()
    let l:testcase = s:getTestCaseFromCursorLine()

    if(len(l:testcase))
        let l:variant = s:GetVariantFromUser('compile')
        call s:compile(l:testcase, l:variant)

        call s:storeDataOfLastCompilation(l:testcase, l:variant)
    else
        execute 'echo ''compilation failed: move cursor on line with testcase name'' '
    endif
endfunction


function cplane#sct#testcase#CompileLastOne()
    if len(s:fetchLastCompile())
        call s:compile(s:fetchLastCompile().testcase, s:fetchLastCompile().variant)
    else
        execute 'echo ''compilation failed: there is no  previous compile/build'' '
    endif
endfunction


function cplane#sct#testcase#BuildAndRunFromCursorLine()
    let l:testcase = s:getTestCaseFromCursorLine()

    if(len(l:testcase))
        let l:variant = s:GetVariantFromUser('run')
        let l:logPath = s:getPathToLogs(l:variant, l:testcase)

        call s:backupPreviousLogs(l:logPath)
        call s:buildAndRun(l:testcase, l:variant)
        call s:storeParametersForK3(cplane#sct#component#GetNameFromBuffer(), l:logPath, l:testcase)

        call s:storeDataOfLastCompilation(l:testcase, l:variant)
    else
        execute 'echo ''build and run failed: move cursor on line with testcase name'' '
    endif
endfunction


function cplane#sct#testcase#BuildAndRunLastOne()
    if len(s:fetchLastCompile())
        let l:variant = s:fetchLastCompile().variant
        let l:testcase = s:fetchLastCompile().testcase
        let l:logPath = s:getPathToLogs(l:variant, l:testcase)

        call s:backupPreviousLogs(l:logPath)
        call s:buildAndRun(l:testcase, l:variant)
        call s:storeParametersForK3(cplane#sct#component#GetNameFromBuffer(), l:logPath, l:testcase)
    else
        execute 'echo ''build & run failed: there is no  previous compile/build'' '
    endif
endfunction


function cplane#sct#testcase#ProcessBuildedTestCases()
    let l:logsToProcess = s:fetchParametersForK3()

    if len(l:logsToProcess)
        for data in s:fetchParametersForK3()
            call cplane#sct#k3post#Do(data[0], data[1], data[2])
        endfor
        call s:eraseUsedK3Parameters()
    else
        execute 'echo ''pool of testcases to process by k3 post processor is empty, run testcase first'' '
    endif
endfunction


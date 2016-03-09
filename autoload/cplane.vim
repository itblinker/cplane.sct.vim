function cplane#CompileTestcaseFromCursorLine()
    let l:splittedCurrentLine = split(getline('.'))

    if( (len(l:splittedCurrentLine) >= 2) && (l:splittedCurrentLine[0] == 'testcase') )
        call cplane#Compile()
    else
        echo 'TTCN Compilation cann''t be started - put cursor on line with testcase name'
    endif
endfunction

function cplane#Compile()
    call cplane#BackupCompilatinCommand()
    call cplane#ReCompileBackupedTestCase()
endfunction

function cplane#BackupCompilatinCommand()
    let g:cplane_last_compilation_command = cplane#GetCompilationCommand()
endfunction

function cplane#PrintBackupedCompilationCommand()
    echo 'ttcn#cplane: last compilation command is: '.g:cplane_last_compilation_command
endfunction

function cplane#GetTestCaseName()
    let l:testCaseNameFunction = split(getline('.'))[1]
    return strpart(l:testCaseNameFunction, 0, len(l:testCaseNameFunction) - 2)
endfunction

function cplane#GetTtcnBin()
    return getcwd().g:cplane_local_sct_script_relative_top_path.cplane#GetComponentSpecificScriptName()
endfunction

function cplane#GetLogsDir()
    return getcwd().'/logs/SCTs/'.g:cplane_sct_current_variant
endfunction

function cplane#GetTestCaseLogsDir()
    return cplane#GetLogsDir.'/'.cplane#GetTestCaseName()
endfunction

function cplane#GetComponentSpecificScriptName()
    let l:splittedPath = maktaba#path#Split(expand('%:p:h'))
    for l:item in g:cplane_component_database
        if(index(l:splittedPath, l:item.sct_top_dir) >= 0)
            return l:item.sct_script
        endif
    endfor
endfunction

function cplane#GetCompilationCommand()
    return 'Dispatch '.cplane#GetTtcnBin().' -tcs '.cplane#GetTestCaseName().' -basket ALL -k3conly -variant '.g:cplane_sct_current_variant
endfunction

function cplane#GetRunCommand()
    return 'Dispatch '.cplane#GetTtcnBin().' -tcs '.cplane#GetTestCaseName().' -basket ALL -keeplogs -keepk3log -variant '.g:cplane_sct_current_variant.' -logdir '.cplane#GetLogsDir()
endfunction

function cplane#ReCompileBackupedTestCase()
    if(len(g:cplane_last_compilation_command))
        execute 'silent! 'g:cplane_last_compilation_command
    else
        echo 'there isn''t any valid last compilation command'
    endif
endfunction

function cplane#RunLastTestCase()
    if(len(g:cplane_last_run_command))
        execute g:cplane_last_run_command
    else
        echo 'there isn''t any valid last run command'
    endif
endfunction

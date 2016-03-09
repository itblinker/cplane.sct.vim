function cplane#sct#CompileTestCaseFromCursorLine()
    let l:splittedCurrentLine = split(getline('.'))

    if( (len(l:splittedCurrentLine) >= 2) && (l:splittedCurrentLine[0] == 'testcase') )
        call cplane#sct#private#Compile()
    else
        echo 'TTCN Compilation cann''t be started - put cursor on line with testcase name'
    endif
endfunction



function cplane#sct#ReCompilationBackupedTestCase()
    call cplane#sct#private#LaunchBackupedCompilationCommand()
endfunction



function cplane#sct#PrintCompilationLastCommand()
    echo g:cplane#sct#cache#last#CompilationAndRunCommand
endfunction



function cplane#sct#SctCompileAndRunFromCursorLine()
    let l:splittedCurrentLine = split(getline('.'))

    if( (len(l:splittedCurrentLine) >= 2) && (l:splittedCurrentLine[0] == 'testcase') )
        call cplane#sct#private#CompileAndRun()
    else
        echo 'TTCN Compilation cann''t be started - put cursor on line with testcase name'
    endif
endfunction



function cplane#sct#ReCompilationAndRunBackupedTestCase()
    call cplane#sct#private#LaunchBackupedCompilationAndRunCommand()
endfunction


function cplane#sct#PrintCompilationAndRunLastCommand()
    echo g:cplane#sct#cache#last#CompilationAndRunCommand
endfunction


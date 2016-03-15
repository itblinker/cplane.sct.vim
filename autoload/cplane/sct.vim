let s:components = [
            \ {'name': g:rrom, 'dir_key': 'RROM'},
            \ {'name': g:uec, 'dir_key': 'UEC'},
            \ {'name': g:enbc, 'dir_key': 'ENBC'},
            \ {'name': g:cellc, 'dir_key': 'CELLC'},
            \ {'name': g:tupc, 'dir_key': 'TUPC'},
            \ {'name': g:mcec, 'dir_key': 'MCEC'},
            \ {'name': g:common, 'dir_key': 'Common'}
            \ ]


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



function cplane#sct#SctRunFromCursorLine()
    let l:splittedCurrentLine = split(getline('.'))

    if( (len(l:splittedCurrentLine) >= 2) && (l:splittedCurrentLine[0] == 'testcase') )
        call cplane#sct#private#Run()
    else
        echo 'TTCN Compilation cann''t be started - put cursor on line with testcase name'
    endif
endfunction

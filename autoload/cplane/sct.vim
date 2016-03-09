function cplane#sct#CompileTestCaseFromCursorLine()
    let l:splittedCurrentLine = split(getline('.'))

    if( (len(l:splittedCurrentLine) >= 2) && (l:splittedCurrentLine[0] == 'testcase') )
        call cplane#sct#private#Compile()
    else
        echo 'TTCN Compilation cann''t be started - put cursor on line with testcase name'
    endif

endfunction


function cplane#sct#ReCompilationBackupedTestCase()
    echo 'not implemented ye'
endfunction




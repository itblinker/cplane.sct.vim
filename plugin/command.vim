"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command SCTCompileFromCursorLine : call cplane#sct#CompileTestCaseFromCursorLine()
command SCTCompileReRunLastCommand : call cplane#sct#ReCompilationBackupedTestCase()
command SCTCompilePrintLastCommand : call cplane#sct#PrintCompilationLastCommand()

command SCTBuildAndRunFromCursorLine : call cplane#sct#SctCompileAndRunFromCursorLine()
command SCTBuildAndRunReRunLastCommand : call cplane#sct#ReCompilationAndRunBackupedTestCase()
command SCTBuildAndRunPrintLastCommand : call cplane#sct#PrintCompilationLastCommand()

" TODO fill and provide method / command to change variant
"command SCTRunFromCursorLine : call 
"command SCTRunReRunLastCommand : call
"command SCTRunPrintLastCommand : call 

"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command SctCompileFromCursorLine : call cplane#sct#CompileTestCaseFromCursorLine()
command SctReCompileLastOne : call cplane#sct#ReCompilationBackupedTestCase()
command SctPrintLastCompilationCommand : call cplane#sct#PrintCompilationLastCommand()

command SctCompileAndRunFromCursorLine : call cplane#sct#SctCompileAndRunFromCursorLine()
command SctReCompileAndRunLastOne : call cplane#sct#ReCompilationAndRunBackupedTestCase()
command SctPrintLastCompilationAndRunCommand : call cplane#sct#PrintCompilationLastCommand()



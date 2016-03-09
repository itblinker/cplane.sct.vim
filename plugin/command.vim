"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command SctCompileFromCursorLine : call cplane#sct#CompileTestCaseFromCursorLine()
command SctReCompileLastOne : call cplane#sct#ReCompilationBackupedTestCase()

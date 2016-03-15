"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command SctCompileFromCursorLine :call cplane#sct#testcase#CompileFromCursorLine()
command SctRunFromCursorLine :call cplane#sct#testcase#BuildAndRunFromCursorLine()

command UpSack : execute 'Start -wait=''error'' make upSack'
command ReTagCppForCurrentComponent : call cplane#cpp#tags#Update()
command ReTagTtcnForCurrentComponent : call cplane#sct#tags#Update()





" TODO fill and provide method / command to change variant
" run / compile should run my filtering script
" caching only testcase name
"command SCTRunFromCursorLine : call
"command SCTRunReRunLastCommand : call
"command SCTRunPrintLastCommand : call
"
"TODO: coalescence run: no logs, toggle detector, config from variant,
" coalescence (compile for all architecture and run coalescence for all of
" them)

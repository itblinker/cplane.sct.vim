"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command -nargs=1 CplaneMakeForBothFsmr : call cplane#cpp#make#MakeForBothFsmr(<f-args>)

command CplaneAutoTagON  : call cplane#AutoTagON()
command CplaneAutoTagOFF : call cplane#AutoTagOFF()

command -nargs=1 CplaneFGrepCApplication : call cplane#cpp#fgrep#CApplication(<f-args>)
command -nargs=1 CplaneFGrepCTests : call cplane#sct#fgrep#CTests(<f-args>)

command CplaneEchoSctRunnerKeptData : call cplane#sct#testcase#EchoParametersForKeptTestcase()

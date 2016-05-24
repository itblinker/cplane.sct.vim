"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}
"{{{ gtag file selection UT/noUT
let g:tag_cpp_with_tests = 0
function s:toggleTaggingUT()
    if (g:tag_cpp_with_tests == 1)
        let g:tag_cpp_with_tests = 0
    else
        let g:tag_cpp_with_tests = 1
    endif
endfunction
"}}}


command CplaneGenSack : call cplane#GenSack()

command -nargs=1 CplaneMakeFsmr3 : call cplane#cpp#make#MakeFsmr3(<f-args>)
command -nargs=1 CplaneMakeFsmr4 : call cplane#cpp#make#MakeFsmr4(<f-args>)

command CplaneGtagUTsToggle : call s:toggleTaggingUT()
command CplaneAutoTagON  : call cplane#AutoTagON()
command CplaneAutoTagOFF : call cplane#AutoTagOFF()

command -nargs=* -complete=file  CplaneSniffKeywordCpp : call cplane#cpp#fgrep#from(<f-args>)
command -nargs=* -complete=file  CplaneSniffKeywordTtcn  : call cplane#sct#fgrep#from(<f-args>)

command -nargs=1 CplaneSniffComponentCodeBase  : call cplane#RFgrepInComponent(<f-args>)

command CplaneEchoSctRunnerKeptData : call cplane#sct#testcase#EchoParametersForKeptTestcase()

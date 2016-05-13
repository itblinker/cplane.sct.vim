"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command GenSack : call cplane#GenSack()

command -nargs=1 MakeFsmr3 : call cplane#cpp#make#MakeFsmr3(<f-args>)
command -nargs=1 MakeFsmr4 : call cplane#cpp#make#MakeFsmr4(<f-args>)

command AutoTagON  : call cplane#AutoTagON()
command AutoTagOFF : call cplane#AutoTagOFF()

command -nargs=* -complete=file  RFCppGrepFromPath : call cplane#cpp#fgrep#from(<f-args>)
command -nargs=* -complete=file  RFTtcnGrepFromPath  : call cplane#sct#fgrep#from(<f-args>)

command -nargs=1 RFGrepCplaneComponent  : call cplane#RFgrepInComponent(<f-args>)

command EchoSctRunnerKeptData : call cplane#sct#testcase#EchoParametersForKeptTestcase()

let g:tag_cpp_with_tests = 0
function s:toggleTaggingUT()
    if (g:tag_cpp_with_tests == 1)
        let g:tag_cpp_with_tests = 0
    else
        let g:tag_cpp_with_tests = 1
    endif
endfunction

command GtagUTsToggle : call s:toggleTaggingUT()

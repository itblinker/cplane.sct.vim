let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
  finish
endif

let g:cplane#sct#cache#last#CompilationCommand = ''
let g:cplane#sct#cache#last#CompilationAndRunCommand = ''

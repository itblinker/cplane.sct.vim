"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

"autocmd BufEnter *.ttcn3 :call cplane#sct#
autocmd BufEnter *.cpp,*.hpp,*.c,*.h :call cplane#cpp#UpdateComponent()


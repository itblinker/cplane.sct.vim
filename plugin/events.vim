"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

autocmd BufEnter *.cpp,*.hpp,*.c,*.h :call cplane#cpp#tags#UpdateIfNeeded()
autocmd BufEnter *.ttcn,*.ttcn3      :call cplane#sct#tags#UpdateIfNeeded()

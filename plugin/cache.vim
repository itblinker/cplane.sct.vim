"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

let g:cplane#component#None = ''
let g:cplane#cpp#cache#component = g:cplane#component#None


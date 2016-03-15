"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

nnoremap <F5>  :SctCompileFromCursorLine<CR>
nnoremap <F10> :SctRunFromCursorLine<CR>

"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

vnoremap <leader>G :call cplane#cpp#grep#Execute(manager#utils#GetFromVisualSelection())<CR>



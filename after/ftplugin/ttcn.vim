execute 'nnoremap <buffer> <F5>  :call cplane#sct#testcase#CompileFromCursorLine()<CR>'
execute 'nnoremap <buffer> <F7>  :call cplane#sct#testcase#BuildAndRunFromCursorLine()<CR>'
execute 'nnoremap <buffer> <F9>  :call cplane#sct#testcase#ProcessTestCaseLogsFromCursorLine()<CR>'

execute 'nnoremap <buffer> <C-]> :UniteWithCursorWord '.manager#plugin#unite#GetPreviewCommonSubSettings().' -immediately tag<CR>'
execute 'vnoremap <buffer> <leader>G :call cplane#sct#grep#Execute(manager#utils#GetFromVisualSelection())<CR>'

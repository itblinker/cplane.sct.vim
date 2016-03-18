
execute 'nnoremap <buffer> <F5>  :call cplane#sct#testcase#CompileLastOne()<CR>'

execute 'nnoremap <buffer> <F6>  :call cplane#sct#testcase#CompileFromCursorLine()<CR>'
execute 'nnoremap <buffer> <F7>  :call cplane#sct#testcase#BuildAndRunFromCursorLine()<CR>'
execute 'nnoremap <buffer> <F8>  :call cplane#sct#testcase#ProcessBuildedTestCases()<CR>'

execute 'nnoremap <buffer> <C-]> :UniteWithCursorWord '.manager#plugin#unite#GetPreviewCommonSubSettings().' -immediately tag<CR>'

execute 'vnoremap <buffer> <leader>G :call cplane#sct#fgrep#Execute(manager#utils#GetFromVisualSelection())<CR>'

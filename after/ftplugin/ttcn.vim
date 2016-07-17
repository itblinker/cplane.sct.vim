
execute 'nnoremap <buffer> <F3>  :call cplane#sct#testcase#CompileFromCursorLine()<CR>'
execute 'nnoremap <buffer> <F4>  :call cplane#sct#testcase#CompileLastOne()<CR>'

execute 'nnoremap <buffer> <F6>  :call cplane#sct#testcase#BuildAndRunFromCursorLine()<CR>'
execute 'nnoremap <buffer> <F7>  :call cplane#sct#testcase#BuildAndRunLastOne()<CR>'

execute 'nnoremap <buffer> <F9>  :call cplane#sct#testcase#ProcessBuildedTestCases()<CR>'

execute 'nnoremap <buffer> <F2> : call cplane#Retag()<CR>'

execute 'nnoremap <buffer> <C-]> :UniteWithCursorWord '.manager#plugin#unite#GetPreviewCommonSubSettings().' -immediately tag<CR>'
execute 'vnoremap <buffer> <leader>G :call cplane#sct#fgrep#Execute(manager#utils#GetFromVisualSelection())<CR>'

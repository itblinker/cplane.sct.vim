execute 'nnoremap <buffer> <F5>  :call cplane#sct#testcase#CompileFromCursorLine()<CR>'
execute 'nnoremap <buffer> <F10> :call cplane#sct#testcase#BuildAndRunFromCursorLine<CR>'

execute 'nnoremap <buffer> <C-]> :UniteWithCursorWord '.manager#plugin#unite#GetPreviewCommonSubSettings().' -immediately tag<CR>'

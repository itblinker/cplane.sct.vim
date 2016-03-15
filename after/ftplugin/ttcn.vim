nnoremap <buffer> <F5> :call cplane#sct#CompileTestCaseFromCursorLine()<CR>
"nnoremap <buffer> <F6> :call cplane#sct#SctRunFromCursorLine()
"nnoremap <buffer> <F6> :call cplane#sct#ReCompilationBackupedTestCase()<CR>

execute 'nnoremap <buffer> <C-]> :UniteWithCursorWord '.manager#plugin#unite#GetPreviewCommonSubSettings().' -immediately tag<CR>'

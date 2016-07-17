
execute 'vnoremap <buffer> <leader>G :call cplane#cpp#fgrep#Execute(manager#utils#GetFromVisualSelection())<CR>'
execute 'nnoremap <buffer> <F2> : call cplane#Retag()<CR>'

execute 'nnoremap <buffer> <F5> : call cplane#cpp#make#MakeFsmr3(cplane#cpp#make#getCachedMakeTarget())<CR>'


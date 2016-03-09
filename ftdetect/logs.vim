function! s:DetectK3rFile()
    if getline(1) =~ '^\d\{8}T\d\{6}\.\d\{6}\|'
         set filetype=k3r
         set syntax=k3r
    endif
endfunction

au BufNewFile,BufRead *.log call s:DetectK3rFile()
au BufNewFile,BufRead *.k3.log set filetype=k3p

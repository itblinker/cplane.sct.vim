"{{{ autotag
function cplane#AutoTagON()
    call cplane#cpp#events#AutoTagON()
    call cplane#sct#events#AutoTagON()
endfunction


function cplane#AutoTagOFF()
    call cplane#cpp#events#AutoTagOFF()
    call cplane#sct#events#AutoTagOFF()
endfunction
"}}}


function cplane#GenSack()
    execute 'Start! -wait=''error'' make genSack'
endfunction


"{{{ retag
function cplane#Retag()
    let l:filetype = &filetype

    if(filetype ==# 'cpp')
        call cplane#GenSack()
        call cplane#cpp#tags#Update()
        return
    elseif (l:filetype ==# 'ttcn')
        call cplane#GenSack()
        call cplane#sct#tags#Update()
        return
    else
        execute 'echo ''retag cannot be performed outside from cpp/ttcn files'''
    endif
endfunction


function cplane#RFgrepInComponent(p_pattern)
    let l:filetype = &filetype

    if (l:filetype ==# 'cpp')
        call cplane#cpp#fgrep#Execute(a:p_pattern)
        return
    elseif (l:filetype ==# 'ttcn')
        call cplane#sct#fgrep#Execute(a:p_pattern)
        return
    else
        execute 'echo ''component fgrep  cannot be performed outside from cpp/ttcn files'''
    endif
endfunction

"}}}

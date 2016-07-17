let s:configs =
            \ {
            \ 'fsmr3':    '.config_fsmr3',
            \ 'fsmr4':    '.config_fsmr4',
            \ 'fsmr3tdd': '.config_tddfsmr3',
            \ 'fsmr4tdd': '.config_tddfsmr4'
            \ }


function s:builder(p_target, p_config)
    execute 'Make '.a:p_target.' CFG='.a:p_config
endfunction

function s:svnGreenUpdater(p_target)
    let l:revision = system('green '.a:p_target)
    echomsg 'revision is '.l:revision
    call system('svn up -r '.l:revision)
endfunction

let s:cache_last_make_target =''

function s:cacheMakeTarget(p_target)
    let s:cache_last_make_target = a:p_target
endfunction

function cplane#cpp#make#getCachedMakeTarget()
    return s:cache_last_make_target
endfunction

function cplane#cpp#make#MakeFsmr3(p_target)
    call s:cacheMakeTarget(a:p_target)
    call s:builder(a:p_target, s:configs.fsmr3)
endfunction

function cplane#cpp#make#MakeFsmr4(p_target)
    call s:cacheMakeTarget(a:p_target)
    call s:builder(a:p_target, s:configs.fsmr4)
endfunction


function cplane#cpp#make#SvnGreenUpAndMakeFsmr3(p_target)
    try
        call s:svnGreenUpdater(a:p_target)
        call s:builder(a:p_target, s:configs.fsmr3)
    catch
        call maktaba#error#Shout('up and/or build failed! repeat with valid parameters')
    endtry

endfunction


function cplane#cpp#make#SvnGreenUpAndMakeFsmr4(p_target)
    try
        call s:svnGreenUpdater(a:p_target)
        call s:builder(a:p_target, s:configs.fsmr4)
    catch
        call maktaba#error#Shout('up and/or build failed! repeat with valid parameters')
    endtry

endfunction

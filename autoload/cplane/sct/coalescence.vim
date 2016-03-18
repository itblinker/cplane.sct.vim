let s:configMap = {
            \ g:fsmr3_fdd  : 'fsmr3',
            \ g:fsmr3_tdd  : 'tddfsmr3',
            \ g:fsmr4_fdd  : 'fsmr4',
            \ g:fsmr4_tdd  : 'tddfsmr4'
            \ }

function s:getSensitiveFlags(p_config)
    let l:flags = '--retries 1 --failed-limit 2'
endfunction

function s:executor(p_sc, flags)

function cplane#sct#coalescence#ExecuteForCurrentConfig(F)
    if (len(cplane#sct#component#GetNameFromBuffer()))
    
    else
        execute 'echo ''coalescence must be run from sct (path matters)'''
    endif
endfunction


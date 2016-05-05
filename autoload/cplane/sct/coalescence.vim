let s:configMap = {
            \ g:fsmr3_fdd  : '.config_fsmr3',
            \ g:fsmr3_tdd  : '.config_tddfsmr3',
            \ g:fsmr4_fdd  : '.config_fsmr4',
            \ g:fsmr4_tdd  : '.configtddfsmr4'
            \ }


function s:getSensitiveFlags(p_variant)
    let l:flags = '--retries 1 --failed-limit 2 --config '.s:configMap[a:p_variant]'
endfunction


function s:executor(p_sc, p_variant, flags)
    try
        call maktaba#ensure#IsTrue(has_key(s:configMap, a:p_variant))

        let l:cmd = 'run_sct '.a:p_sc.s:getSensitiveFlags(a:p_variant)
    catch
        execute 'echo ''variant '.a:p_variant.' it is not supported'
    endtry
endfunction


function cplane#sct#coalescence#ExecuteForCurrentConfig(p_variant)
    let l:sc = cplane#sct#coalescence#ExecuteForCurrentConfig()
    if len(l:sc)
    else
        execute 'echo ''coalescence must be run from target specific path'''
    endif
endfunction

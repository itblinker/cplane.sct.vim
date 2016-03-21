let s:configs = [
            \ '.config_fsmr3',
            \ '.config_fsmr4'
            \ ]

            "\ '.config_tddfsmr3',
            "\ '.config_tddfsmr4'


function cplane#cpp#make#MakeForBothFsmr(p_target)
    for cf in s:configs
        execute 'Make '.a:p_target.' CFG='.cf
    endfor
endfunction

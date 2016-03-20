let s:variants = {
            \ g:fsmr3_fdd : '.config_fsmr3',
            \ g:fsmr3_tdd : '.config_tddfsmr3',
            \ g:fsmr4_fdd : '.config_fsmr4',
            \ g:fsmr4_tdd : '.config_tddfsmr4'
            \ }

"{{{ helpers
function s:getVariantsList()
    let l:variants = []
    for k in keys(s:variants)
        call add(l:variants, k)
    endfor
    return l:variants
endfunction

function s:printError(p_input)
    return 'Given variant '.a:p_input.'it is not supported'
endfunction
"}}}

function cplane#variant#Get()
    return g:cplane#cache#variant
endfunction


function cplane#variant#Echo()
    execute 'echo ''variant in use: '.cplane#variant#Get().''''
endfunction


function cplane#variant#Set(p_variant)
    try
        call maktaba#ensure#IsString(a:p_variant)
        call maktaba#ensure#IsTrue(has_key(s:variants, a:p_variant))
        let g:cplane#cache#variant = a:p_variant
    catch
        execute 'echo '''.s:printError(a:p_variant).''''
    endtry
endfunction



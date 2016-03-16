"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

let g:rrom = 'rrom'
let g:uec = 'uec'
let g:enbc = 'enbc'
let g:cellc = 'cellc'
let g:tupc = 'tupc'
let g:mcec = 'mcec'
let g:lom = 'lom'
let g:common = 'common'

let g:fsmr3_fdd = 'fsmr3'
let g:fsmr4_fdd = 'fsmr4'
let g:fsmr3_tdd = 'tddfsmr3'
let g:fsmr4_tdd = 'tddrsmr4'

let g:variants = {
            \ g:fsmr3_fdd : {'local_script' : 'fsmr3', 'coalescence': '.config_fsmr3'},
            \ g:fsmr3_tdd : {'local_script' : 'tddfsmr3', 'coalescence': '.config_tddfsmr3'},
            \ g:fsmr4_fdd : {'local_script' : 'fsmr4', 'coalescence': '.config_fsmr4'},
            \ g:fsmr4_tdd : {'local_script' : 'tddfsmr4', 'coalescence': '.config_tddfsmr4'}
            \ }

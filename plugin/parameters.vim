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
let g:fsmr4_tdd = 'tddfsmr4'

"TODO : exchange all places of g:cache#variant by get and set

"{{{ CACHE

"{{{ cache for tagging
let g:cplane#component#None = ''
let g:cplane#cpp#cache#component = g:cplane#component#None
let g:cplane#sct#cache#component = g:cplane#component#None
"}}}

"{{{ cache for variant
let g:cplane#Emtpy = ''
let g:cplane#cache#variant = g:fsmr3_fdd
"}}}

"}}}


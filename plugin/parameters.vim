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

let g:cplane#sct#components#supported = [g:rrom, g:uec, g:enbc, g:cellc, g:tupc, g:mcec, g:common]

let g:cplane#sct#components#key_dirs = [
            \ {'name': g:rrom, 'dir_key': 'RROM'},
            \ {'name': g:uec, 'dir_key': 'UEC'},
            \ {'name': g:enbc, 'dir_key': 'ENBC'},
            \ {'name': g:cellc, 'dir_key': 'CELLC'},
            \ {'name': g:tupc, 'dir_key': 'TUPC'},
            \ {'name': g:mcec, 'dir_key': 'MCEC'},
            \ {'name': g:common, 'dir_key': 'Common'}
            \ ]



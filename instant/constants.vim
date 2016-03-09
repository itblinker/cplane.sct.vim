"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}
let g:cplane_component_database =  [ {'name': 'rrom', 'sct_top_dir': 'RROM', 'sct_script': 'sct_rrom.sh'},
                                   \ {'name': 'uec',  'sct_top_dir': 'UEC',  'sct_script': 'sct_uec.sh'},
                                   \ {'name': 'enbc', 'sct_top_dir': 'ENBC', 'sct_script': 'sct_enbc.sh'},
                                   \ {'name': 'cellc','sct_top_dir': 'CELLC','sct_script': 'sct_cellc.sh'},
                                   \ {'name': 'tupc', 'sct_top_dir': 'TUPC', 'sct_script': 'sct_tupc.sh'},
                                   \ {'name': 'mcec', 'sct_top_dir': 'MCEC', 'sct_script': 'sct_mcec.sh'}
                                   \ ]

let g:cplane_local_sct_script_relative_top_path = '/lteTools/scbm/bin/'
let g:cplane_local_sct_script_command_run = '-keeplogs -keep3klog -logdir'

let g:cplane_sct_variants = ['fsmr3', 'fsmr4', 'fzc', 'fzm', 'tddfsmr3', 'tddfsmr4', 'tddfzc', 'tddfzm' ]
let g:cplane_sct_current_variant = 'fsmr3'

let g:cplane_last_compilation_command = ''
let g:cplane_last_run_command = ''

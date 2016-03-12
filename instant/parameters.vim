let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
  finish
endif

let g:cplane_sct_component_database =  [ {'sct_top_dir': 'RROM', 'sct_script': 'sct_rrom.sh'},
                                       \ {'sct_top_dir': 'UEC',  'sct_script': 'sct_uec.sh'},
                                       \ {'sct_top_dir': 'ENBC', 'sct_script': 'sct_enbc.sh'},
                                       \ {'sct_top_dir': 'CELLC','sct_script': 'sct_cellc.sh'},
                                       \ {'sct_top_dir': 'TUPC', 'sct_script': 'sct_tupc.sh'},
                                       \ {'sct_top_dir': 'MCEC', 'sct_script': 'sct_mcec.sh'}
                                       \ ]

let g:cplane_sct_local_script_relative_path = '/lteTools/scbm/bin/'
let g:cplane_sct_logs_dir_relative_path = '/logs/SCTs/'

let g:cplane_sct_variant_in_use = 'fsmr3'
let g:cplane_sct_variants_supported = ['fsmr3', 'fsmr4', 'fzc', 'fzm', 'tddfsmr3', 'tddfsmr4', 'tddfzc', 'tddfzm' ]

let g:cplane_sct_common_parameters_subcommands = ' -basket ALL'
let g:cplane_sct_compilation_parameters_subcommand = ' -k3conly'
let g:cplane_sct_compile_and_run_parameters_subcommand = ' -keeplogs -keepk3log'
let g:cplane_sct_run_only_parameters_subcommand = ' -keeplogs -keepk3log -noappbuild'

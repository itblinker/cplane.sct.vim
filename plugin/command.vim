"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command CplaneUpSack : execute 'Start -wait=''error'' make upSack'

command CplaneRetag : call cplane#Retag()

command CplaneAutoTagON  : call cplane#AutoTagON()
command CplaneAutoTagOFF : call cplane#AutoTagOFF()

command -nargs=1 CplaneGrepCApplication : call cplane#cpp#grep#CApplication(<f-args>)
command -nargs=1 CplaneGrepCTests : call cplane#sct#grep#CTests(<f-args>)

command CplaneVariantEcho : call cplane#EchoVariant()
command -nargs=1 CplaneVariantSave call cplane#SaveVariant(<f-args>)

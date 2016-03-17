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

command CplaneVariantEcho : call cplane#EchoVariant()
command -nargs=1 CplaneVariantSave call cplane#SaveVariant(<f-args>)

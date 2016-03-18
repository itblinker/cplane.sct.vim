"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command CplaneUpSack : execute 'Start -wait=''error'' make upSack'
command -nargs=1 CplaneMakeComponentForFsmVariants : call cplane#cpp#make#BuildComponentTargetForFsmVariants(<f-args>)

command CplaneRetag : call cplane#Retag()

command CplaneAutoTagON  : call cplane#AutoTagON()
command CplaneAutoTagOFF : call cplane#AutoTagOFF()

command -nargs=1 CplaneFGrepCApplication : call cplane#cpp#fgrep#CApplication(<f-args>)
command -nargs=1 CplaneFGrepCTests : call cplane#sct#fgrep#CTests(<f-args>)

command -nargs=1 CplaneVariantSave call cplane#SaveVariant(<f-args>)

command CplaneEchoFsmVariant : call cplane#EchoVariant()

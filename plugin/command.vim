"{{{ source guard
let [s:plugin, s:enter] = maktaba#plugin#Enter(expand('<sfile>:p'))
if !s:enter
    finish
endif
"}}}

command CplaneUpSack : execute 'Start -wait=''error'' make upSack'

command CplaneCppReTagCurrentComponent : call cplane#cpp#tags#Update()
command CplaneReTagTtcnCurrentComponent : call cplane#sct#tags#Update()

command CplaneCppAutoTagON  : call cplane#cpp#events#AutoTagON()
command CplaneCppAutoTagOFF : call cplane#cpp#events#AutoTagOFF()

command CplaneTtcnAutoTagON  : call cplane#sct#events#AutoTagON()
command CplaneTtcnAutoTagOFF : call cplane#sct#events#AutoTagOFF()

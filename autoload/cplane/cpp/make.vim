let s:targetMap = {
            \ g:rrom   : 'ptRROM',
            \ g:uec    : 'ptUEC',
            \ g:enbc   : 'ptENBC',
            \ g:cellc  : 'ptCELLC',
            \ g:tupc   : 'ptTUPC',
            \ g:mcec   : 'ptMCEC',
            \ }

function cplane#cpp#make#BuildComponentTargetForFsmVariants(p_sc)
    try
        call maktaba#ensure#IsTrue(has_key(tolower(s:targetMap), a:p_sc))
    catch
        execute 'echo ''cplane component target unknown!'''
    endtry

   execute 'Make '.s:targetMap[a:p_sc].' A=linux'
   execute 'Copen!'

   execute 'Make '.s:targetMap[a:p_sc].' A=linux64'
   execute 'Copen!'
endfunction

function cplane#cpp#make#UpSack()
    execute 'Make upSack'
endfunction


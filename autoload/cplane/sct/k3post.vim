let s:sc = {  g:rrom  : 'RROM',
            \ g:uec   : 'UEC',
            \ g:enbc  : 'ENBC',
            \ g:cellc : 'CELLC',
            \ g:tupc  : 'TUPC',
            \ g:mcec  : 'MCEC'
            \ }

"{{{ local functions
function s:getDestDir(p_logPath)
    "let l:p = a:p_logPath.'/postproc'
    "execute 'echo '' '.l:p.' '' '

    return a:p_logPath.'/postproc'
endfunction


function s:getDestDirForSplit(p_logPath)
    "let l:p = s:getDestDir(a:p_logPath).'/split'
    "execute 'echo '' '.l:p.' '' '

    return s:getDestDir(a:p_logPath).'/split'
endfunction


function s:clearAndPrepareDirs(p_logPath)
    let l:dDir = s:getDestDir(a:p_logPath)
    let l:sDir = s:getDestDirForSplit(a:p_logPath)

    if(isdirectory(l:dDir))
        execute 'Start rm -rf '.l:sDir
        execute 'Start rm -rf '.l:dDir
    endif

    execute 'Start mkdir -p '.l:dDir
    execute 'Start mkdir -p '.l:sDir
endfunction


function s:areLogsAvailable(p_logPath)
    return isdirectory(a:p_logPath)
endfunction


function s:getK3log(p_sc, p_logPath)
    return a:p_logPath.'/'.s:sc[a:p_sc].'_SCT.log'
endfunction


function s:getCmd(p_sc, p_logPath)
   return 'Start k3post.py '.s:getK3log(a:p_sc, a:p_logPath).' '
endfunction

function s:processing(p_sc, p_path)
    let l:dDir = s:getDestDir(a:p_path)
    let l:sDir = s:getDestDirForSplit(a:p_path)

    call s:clearAndPrepareDirs(a:p_path)

    execute s:getCmd(a:p_sc, a:p_path).' --force-tree --no-functions --no-user-logs --no-wait-for --no-timestamps --no-content --out='.l:dDir.'/flow'
    execute s:getCmd(a:p_sc, a:p_path).' --force-tree --no-functions --user-logs --no-wait-for --no-timestamps --no-content --out='.l:dDir.'/logs.flow'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --no-user-logs --no-wait-for --no-timestamps --content --out='.l:dDir.'/flow.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --user-logs --no-wait-for --no-timestamps --content --out='.l:dDir.'/logs.flow.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --no-user-logs --wait-for --timestamps --content --out='.l:dDir.'/flow.time.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --user-logs --wait-for --timestamps --content --out='.l:dDir.'/logs.flow.time.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --functions --no-function-indent --user-logs --wait-for --timestamps --out='.l:dDir.'/_k3_full_'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --functions --no-function-indent --user-logs --wait-for --timestamps --split-log --out='.l:sDir.'/out'

endfunction

"}}}

function cplane#sct#k3post#Do(p_component, p_logPath)
    if s:areLogsAvailable(a:p_logPath)
        call s:processing(a:p_component, a:p_logPath)
    else
        echom 'there are no logs, run testcase first!'
    endif
endfunction


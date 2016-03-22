let s:sc = {  g:rrom  : 'RROM',
            \ g:uec   : 'UEC',
            \ g:enbc  : 'ENBC',
            \ g:cellc : 'CELLC',
            \ g:tupc  : 'TUPC',
            \ g:mcec  : 'MCEC'
            \ }

"{{{ local functions
function s:getDestDir(p_logPath)
    return a:p_logPath.'/postproc'
endfunction


function s:getFileWithBinaryLogs(p_logPath, p_testcaseName)
    return a:p_logPath.'/'.a:p_testcaseName.'.out'
endfunction

function s:copyLogFilesToDestinationDirectory(p_logPath, p_testcase)
    let l:dDir = s:getDestDir(a:p_logPath)
    let l:binaryLogFile = s:getFileWithBinaryLogs(a:p_logPath, a:p_testcase)

    call system('cp '.a:p_logPath.'/'.'*_SCT.k3.txt '.l:dDir.'/SCT.k3.log')
    call system('cp '.a:p_logPath.'/'. a:p_testcase.'.out '.l:dDir.'/Binary.k3.log')
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

function s:processing(p_sc, p_path, p_testcase)
    let l:dDir = s:getDestDir(a:p_path)
    let l:sDir = s:getDestDirForSplit(a:p_path)

    call s:clearAndPrepareDirs(a:p_path)

    execute s:getCmd(a:p_sc, a:p_path).' --force-tree --no-functions --no-user-logs --no-wait-for --no-timestamps --no-content --out='.l:dDir.'/flow'
    execute s:getCmd(a:p_sc, a:p_path).' --force-tree --no-functions --no-user-logs --no-wait-for --timestamps --no-content --out='.l:dDir.'/flow.time'
    execute s:getCmd(a:p_sc, a:p_path).' --force-tree --no-functions --user-logs --no-wait-for --no-timestamps --no-content --out='.l:dDir.'/logs.flow'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --no-user-logs --no-wait-for --no-timestamps --content --out='.l:dDir.'/flow.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --user-logs --no-wait-for --no-timestamps --content --out='.l:dDir.'/logs.flow.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --no-user-logs --wait-for --timestamps --content --out='.l:dDir.'/flow.time.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --no-functions --user-logs --wait-for --timestamps --content --out='.l:dDir.'/logs.flow.time.messages'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --functions --no-function-indent --user-logs --wait-for --timestamps --out='.l:dDir.'/_k3_full_'
    execute s:getCmd(a:p_sc, a:p_path).'--force-tree --functions --no-function-indent --user-logs --wait-for --timestamps --split-log --out='.l:sDir.'/out'

    call s:copyLogFilesToDestinationDirectory(a:p_path, a:p_testcase)

endfunction

"}}}

function cplane#sct#k3post#Do(p_component, p_logPath, p_testcase)
    if s:areLogsAvailable(a:p_logPath)
        call s:processing(a:p_component, a:p_logPath, a:p_testcase)
    else
        echom 'there are no sct logs needed by k3post-processor, run testcase first!'
    endif
endfunction


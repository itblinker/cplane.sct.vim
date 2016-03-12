function cplane#sct#private#GetBin()
    return getcwd().g:cplane_sct_local_script_relative_path.cplane#sct#private#GetScriptName()
endfunction



function cplane#sct#private#GetScriptName() abort
    let l:splittedPath = maktaba#path#Split(expand('%:p:h'))
    for l:item in g:cplane_sct_component_database
        if(index(l:splittedPath, l:item.sct_top_dir) >= 0)
            return l:item.sct_script
        endif
    endfor

    throw maktaba#error#Message('Cplane:Sct', 'cannot map component -> script name')
endfunction



function cplane#sct#private#Compile()
    call cplane#sct#private#BackupCompilationCommand()
    call cplane#sct#private#LaunchBackupedCompilationCommand()
endfunction


function cplane#sct#private#CompileAndRun()
    call cplane#sct#private#BackupCompilationAndRunCommand()
    call cplane#sct#private#LaunchBackupedCompilationAndRunCommand()
endfunction


function cplane#sct#private#Run()
    call cplane#sct#private#BackupRunCommand()
    call cplane#sct#private#LaunchBackupedRunCommand()
endfunction


function cplane#sct#private#GetTestCaseName()
    let l:testCaseNameFunction = split(getline('.'))[1]
    return strpart(l:testCaseNameFunction, 0, len(l:testCaseNameFunction) - 2)
endfunction



function cplane#sct#private#GetVariantSubcommand()
    return ' -variant '.g:cplane_sct_variant_in_use
endfunction



function cplane#sct#private#GetCommonCommand()
    return 'Dispatch '.cplane#sct#private#GetBin().' -tcs '.cplane#sct#private#GetTestCaseName().g:cplane_sct_common_parameters_subcommands.cplane#sct#private#GetVariantSubcommand()
endfunction



function cplane#sct#private#GetCompilationCommand()
    return cplane#sct#private#GetCommonCommand().g:cplane_sct_compilation_parameters_subcommand
endfunction


function cplane#sct#private#GetRunSubCommand()
    return cplane#sct#private#GetCommonCommand().cplane#sct#private#GetSubcommandForDestinationLogDir()
endfunction


function cplane#sct#private#GetCompilationAndRunCommand()
    return cplane#sct#private#GetRunSubCommand().g:cplane_sct_compile_and_run_parameters_subcommand
endfunction


function cplane#sct#private#GetRunOnlyCommand()
    return cplane#sct#private#GetRunSubCommand().g:cplane_sct_run_only_parameters_subcommand
endfunction


function cplane#sct#private#GetSubcommandForDestinationLogDir()
    return ' -logdir '.cplane#sct#private#GetLogsDirectory()
endfunction



function cplane#sct#private#GetLogsDirectory()
    return getcwd().g:cplane_sct_logs_dir_relative_path.g:cplane_sct_variant_in_use
endfunction



function cplane#sct#private#BackupCompilationCommand()
    let g:cplane#sct#cache#last#CompilationCommand = cplane#sct#private#GetCompilationCommand()
endfunction



function cplane#sct#private#BackupCompilationAndRunCommand()
    let g:cplane#sct#cache#last#CompilationAndRunCommand = cplane#sct#private#GetCompilationAndRunCommand()
endfunction



function cplane#sct#private#LaunchBackupedCompilationCommand()
    if(len(g:cplane#sct#cache#last#CompilationCommand))
        execute 'silent! '.g:cplane#sct#cache#last#CompilationCommand
    else
        echo 'there isn''t any valid last compilation command'
    endif
endfunction



function cplane#sct#private#LaunchBackupedCompilationAndRunCommand()
    if(len(g:cplane#sct#cache#last#CompilationAndRunCommand))
        execute 'silent! '.g:cplane#sct#cache#last#CompilationAndRunCommand
    else
        echo 'there isn''t any valid last compilation command'
    endif
endfunction

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if exists("b:undo_ftplugin")
	let b:undo_ftplugin = "setlocal fo< com< tw< commentstring<"
		\ . "| unlet b:match_ignorecase b:match_words b:match_skip"
endif



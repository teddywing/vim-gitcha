if exists('g:no_plugin_maps') || exists('g:no_gitcha_maps')
	finish
endif

if !hasmapto('<Plug>GitchaCompleteSHA')
	imap <buffer> <C-x><C-s> <Plug>GitchaCompleteSHA
endif

inoremap <buffer> <expr> <Plug>GitchaCompleteSHA gitcha#StartGitSHACompletion()

let b:undo_ftplugin = 'iunmap <buffer> <C-x><C-s>'

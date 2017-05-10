if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1


if exists('g:no_plugin_maps') || exists('g:no_gitcha_maps')
	finish
endif

" if !hasmapto('<Plug>GitchaCompleteSHA')
" 	imap <buffer> <C-x><C-s> <Plug>GitchaCompleteSHA
" endif

" inoremap <buffer> <Plug>GitchaCompleteSHA <C-r>=gitcha#StartGitSHACompletion()<CR>
" inoremap <buffer> <Plug>GitchaCompleteSHA <C-r>=gitcha#GitSHAComplete()<CR>
" inoremap <buffer> <C-x><C-s> <C-r>=gitcha#GitSHAComplete()<CR>
inoremap <C-x><C-s> <C-r>=gitcha#GitSHAComplete()<CR>

let b:undo_ftplugin = 'iunmap <buffer> <C-x><C-s>'

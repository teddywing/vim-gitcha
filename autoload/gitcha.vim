" Save user-defined completefunc so it can be restored after running this
" custom completion function
let s:old_completefunc = &completefunc

" Completion for Git SHAs in the current repository
function! gitcha#GitSHAComplete(findstart, base)
	if a:findstart
		" locate the start of the word
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && line[start - 1] =~ '\a'
			let start -= 1
		endwhile
		return start
	endif

	" Restore user completion function
	let &completefunc = s:old_completefunc

	" Match Git SHAs in the current repository
	let matches = []
	let revs = system('git rev-list --all')
	for m in split(revs)
		if m =~ '^' . a:base
			call add(matches, m)
		endif
	endfor

	return matches
endfunction

" Allow mappings to initiate completion
function! gitcha#StartGitSHACompletion()
	set completefunc=gitcha#GitSHAComplete
	return "\<C-x>\<C-u>"
endfunction
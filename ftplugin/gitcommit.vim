function! GitSHAComplete(findstart, base)
	if a:findstart
		" locate the start of the word
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && line[start - 1] =~ '\a'
			let start -= 1
		endwhile
		return start
	endif

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

set completefunc=GitSHAComplete

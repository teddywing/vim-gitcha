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
	let revs = system('git rev-list --all --pretty=oneline --no-abbrev-commit')

	for m in s:BuildMatchDictionary(revs)
		if m['word'] =~ '^' . a:base
			call add(matches, m)
		endif
	endfor

	return matches
endfunction

" Takes rev-list output from:
"   $ git rev-list --all --pretty=oneline --no-abbrev-commit
"
" Creates a dictionary to be used for matching that uses commit SHAs for the
" completion word and the commit subject as extra text.
function! s:BuildMatchDictionary(rev_list)
	let matches = []
	let commits = split(a:rev_list, '\n')

	for commit in commits
		let separator = stridx(commit, ' ')
		let sha = strpart(commit, 0, separator)
		let subject = strpart(commit, separator + 1)

		call add(matches, {
			\ 'word': sha,
			\ 'abbr': strpart(sha, 0, 10),
			\ 'menu': subject
		\ })
	endfor

	return matches
endfunction

" Allow mappings to initiate completion
function! gitcha#StartGitSHACompletion()
	set completefunc=gitcha#GitSHAComplete
	return "\<C-x>\<C-u>"
endfunction

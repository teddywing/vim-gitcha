" Save user-defined 'completeopt's so they can be restored after running this
" custom completion function
let s:old_completeopt = &completeopt

" Completion for Git SHAs in the current repository
function! gitcha#GitSHAComplete()
	let line = getline('.')
	let start = col('.')
	while start > 0 && line[start - 2] =~ '[0-9a-f]'
		let start -= 1
	endwhile

	" Match Git SHAs in the current repository
	let matches = []
	let revs = system('git rev-list --all --pretty=oneline --no-abbrev-commit')
	let base = line[start - 1 : col('.') - 1]

	for m in s:BuildMatchDictionary(revs)
		if m['word'] =~ '^' . base
			call add(matches, m)
		endif
	endfor

	set completeopt=menu,menuone,preview

	call complete(start, matches)

	let &completeopt = s:old_completeopt

	return ''
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

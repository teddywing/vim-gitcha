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

	    " find months matching with "a:base"
	    let res = []
	    for m in split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec")
	      if m =~ '^' . a:base
		call add(res, m)
	      endif
	    endfor
	    return res
endfunction
set completefunc=GitSHAComplete

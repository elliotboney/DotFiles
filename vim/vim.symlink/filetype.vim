
	" my filetype file
	if exists("did_load_filetypes")
	  finish
	endif
	augroup filetypedetect
	  au! BufRead,BufNewFile *.completion		setfiletype sh
	  au! BufRead,BufNewFile *.xyz		setfiletype drawing
	  au! BufRead,BufNewFile *.function* setfiletype sh
	  au! BufRead,BufNewFile *256dark setfiletype dircolors
	augroup END

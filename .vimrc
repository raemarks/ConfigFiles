set nocompatible
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'
Plugin 'nsf/gocode'
Plugin 'jnwhiteh/vim-golang'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'Rip-Rip/clang_complete'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin indent on     " required!

autocmd FileType go let g:SuperTabDefaultCompletionType="<c-x><c-o>"

"
set shell=bash

" let mapleader=","
" map <Leader>tr :NERDTreeToggle<CR>
colorscheme molokai
"colorscheme ir_black


set nocompatible               " be iMproved
set bs=2
set guioptions=aegit
set autoindent
set smartindent
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set showmatch
set nu

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·,nbsp:‿ " show these hidden characters
set list    " show the characters above

if &t_Co > 1
	syntax on
	syntax enable
	set hlsearch
endif
fixdel

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

if &term ==? "xterm"
	set t_Sb=^[4%dm
	set t_Sf=^[3%dm
	set ttymouse=xterm2
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		" autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		autocmd BufReadPost *
					\ if line("'\"") > 0 && line("'\"") <= line("$") |
					\   exe "normal g`\"" |
					\ endif

	augroup END

	au BufRead,BufNewFile *.c,*.h set tabstop=8
	au BufRead,BufNewFile *py,*pyw set tabstop=8
	"au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
	au BufRead *.py,*pyw set shiftwidth=4
	au BufRead,BufNewFile *.py,*.pyw set expandtab
	fu Select_c_style()
		if search('^\t', 'n', 150)
			set shiftwidth=8
			set noexpandtab
		el 
			set shiftwidth=4
			set expandtab
		en
	endf

	"au BufRead *.c,*.h call Select_c_style()
	au BufRead,BufNewFile Makefile* set noexpandtab



	" Use the below highlight group when displaying bad whitespace is desired.
	highlight BadWhitespace ctermbg=red guibg=red

	" Display tabs at the beginning of a line in Python mode as bad.
	au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
	" Make trailing whitespace be flagged as bad.
	au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

	" Wrap text after a certain number of characters
	" Python: 79 
	" C: 79
	au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

	" Turn off settings in 'formatoptions' relating to comment formatting.
	" - c : do not automatically insert the comment leader when wrapping based on
	"    'textwidth'
	" - o : do not insert the comment leader when using 'o' or 'O' from command mode
	" - r : do not insert the comment leader when hitting <Enter> in insert mode
	" Python: not needed
	" C: prevents insertion of '*' at the beginning of every line in a comment
	"au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

	" Use UNIX (\n) line endings.
	" Only used for new files so as to not force existing files to change their
	" line endings.
	" Python: yes
	" C: yes
	au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix


	" Ignore indents caused by parentheses in FreeBSD style.
	function! IgnoreParenIndent()
		let indent = cindent(v:lnum)

		if indent > 4000
			if cindent(v:lnum - 1) > 4000
				return indent(v:lnum - 1)
			else
				return indent(v:lnum - 1) + 4
			endif
		else
			return (indent)
		endif
	endfun

	" Follow the FreeBSD style(9).
	function! FreeBSD_Style()
		setlocal cindent
		setlocal cinoptions=(4200,u4200,+0.5s,*500,:0,t0,U4200,l1
		setlocal indentexpr=IgnoreParenIndent()
		setlocal indentkeys=0{,0},0),:,0#,!^F,o,O,e
		setlocal noexpandtab
		setlocal shiftwidth=8
		setlocal tabstop=8
		setlocal textwidth=80
		set colorcolumn=80
	endfun

	autocmd Filetype html,c,cpp,go,python set colorcolumn=80
	autocmd Filetype c,cpp call FreeBSD_Style()
	autocmd BufRead,BufNewFile *.h call FreeBSD_Style()

	command W w
	command Q q
	command WQ wq
	command Wq wq

	map <MiddleMouse> <Nop>
	imap <MiddleMouse> <Nop>

	command -bang -nargs=? QFix call QFixToggle(<bang>0) 
	function! QFixToggle(forced) 
		if exists("g:qfix_win") && a:forced == 0 
			cclose 
			unlet g:qfix_win 
		else 
			botright cope
			let g:qfix_win = bufnr("$") 
		endif 
	endfunction

	map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+ias --extra=+q .<CR>
	set tags+=./

	highlight OverLength ctermbg=red ctermfg=white guibg=#592929
	match OverLength /\%81v.\+/


	let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
	let s:minfontsize = 6
	let s:maxfontsize = 20
	function! AdjustFontSize(amount)
		if has("gui_gtk2") && has("gui_running")
			let fontname = substitute(&guifont, s:pattern, '\1', '')
			let cursize = substitute(&guifont, s:pattern, '\2', '')
			let newsize = cursize + a:amount
			if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
				let newfont = fontname . newsize
				let &guifont = newfont
			endif
		else
			echoerr "You need to run the GTK2 version of Vim to use this function."
		endif
	endfunction

	function! LargerFont()
		call AdjustFontSize(1)
	endfunction
	command! LargerFont call LargerFont()

	function! SmallerFont()
		call AdjustFontSize(-1)
	endfunction
	command! SmallerFont call SmallerFont()

endif " has("autocmd")
set guifont=Source\ Code\ Pro\ 11

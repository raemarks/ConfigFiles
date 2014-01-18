set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'
 Bundle 'nsf/gocode'
 Bundle 'jnwhiteh/vim-golang'
 Bundle 'scrooloose/nerdtree'
 Bundle 'ervandew/supertab'
 Bundle 'Rip-Rip/clang_complete'
 Bundle 'kien/ctrlp.vim'
 Bundle 'vim-scripts/DoxygenToolkit.vim'

 autocmd FileType go let g:SuperTabDefaultCompletionType="<c-x><c-o>"
 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..
 set shell=bash

 let mapleader=","
 map <Leader>tr :NERDTreeToggle<CR>
colorscheme molokai 
"colorscheme ir_black 

set guioptions=aegit

set shiftwidth=4
set tabstop=4

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

set nu


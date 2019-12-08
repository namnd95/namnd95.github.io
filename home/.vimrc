set background=light
set nocompatible
filetype off

"Load Plugin {{{
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-fugitive'

call vundle#end()
"}}}

"Configure plugin {{{

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

"lightline
set laststatus=2
set t_Co=256

"}}}

filetype plugin indent on

" Customised file type
au BufRead,BufNewFile *.inp             setfiletype inp

syntax on
set nu
" set mouse=a
set tabstop=8
set autoindent
set hlsearch
set clipboard=unnamed,unnamedplus
set autoread
set colorcolumn=80

"Other common shortcut for other IDE
nnoremap <C-S-O> :CtrlP <CR>

"Common shortcut
inoremap <F4> <ESC>:q<CR>
nnoremap <F4> :q<CR>

inoremap <F2> <ESC>:w<CR>
nnoremap <F2> :w<CR>

function! My_Tab_Completion()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-P>"
	else
	        return "\<Tab>"
endfunction
inoremap <Tab> <C-R>=My_Tab_Completion()<CR>

"file.inp
function! INPUTSET()
	nnoremap <buffer> <C-F9> :!./file <file.inp <cr>
endfunction

"C++
function! CPPSET()
	nnoremap <buffer> <A-F9> :w<cr> :!g++ -std=c++0x -Wall -g % -o file <cr>
	nnoremap <buffer> <C-F9> :!./file <file.inp <cr>

	"Syntastic
	let g:syntastic_cpp_compiler = 'g++'
	let g:syntastic_cpp_compiler_options = '-std=c++0x'
	
	"Topcoder
	nnoremap <buffer> <A-F8> :w<cr> :!g++ -std=c++0x % -o ../file <cr> :!./../file <cr>
endfunction

"PAS
function! PASSET()
	:set expandtab
	:set tabstop=2
	let g:syntastic_pas_compiler = 'fpc'
	let g:syntastic_pas_checkers = ['fpc']
	inoremap <buffer> <C-F9> <ESC> <C-F9>
	inoremap <buffer> <F9> <ESC> <F9>
	inoremap <buffer> <F5> <ESC> <F5>
	nnoremap <buffer> <F9> :w<cr> :!fpc -g % -o"file" <cr>
	nnoremap <buffer> <C-F9> :!./file <file.inp <cr>
	nnoremap <buffer> <F5> :w<cr> :!fpc -g % -o"file" <cr> :!./file <file.inp <cr>
endfunction

function! PYSET()
	:set tabstop=4
	:set expandtab
	nnoremap <buffer> <F5> :w<cr> :!python % <cr>
	nnoremap <buffer> <A-F9> :w<cr> :!autopep8 --in-place --aggressive --aggressive % <cr> 
	nnoremap <buffer> <C-F9> :w<cr> :!python % <cr>
endfunction

"Java
function! JAVASET()
	:set expandtab
	:set tabstop=4
	nnoremap <buffer> <A-F9> :w<cr> :!javac % <cr> 
	nnoremap <buffer> <C-F9> :!java Main <file.inp <cr>
	nnoremap <buffer> <F5> :!java %:r <cr>
endfunction

"Octave
function! OCTAVESET()
	set tabstop=2 expandtab
endfunction

autocmd FileType cpp 	call CPPSET()
autocmd FileType pascal 	call PASSET()
autocmd FileType inp 	call INPUTSET()
autocmd FileType python 	call PYSET()
autocmd FileType java 	call JAVASET()
autocmd FileType matlab call OCTAVESET()
autocmd FileType  call OCTAVESET()


set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jnwhiteh/vim-golang'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ctrlp.vim'
Plugin 'ack.vim'
Plugin 'surround.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-abolish'

" This requires installation of additional software: gocode
" Enables autocompletion in go (omni-completion)
Plugin 'nsf/gocode', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on

" No backups and swap files """
set noswapfile
set nobackup
"""""""""""""""""""""""""""""""

" Disable bell """"""""""
set noeb vb t_vb=
au GUIEnter * set vb t_vb=
"""""""""""""""""""""""""

scriptencoding utf-8
set encoding=utf-8

" Abreviacions útils """"""""""""
iabbrev ##p #!/usr/bin/python<cr># -*- coding: utf-8 -*-

"""""""""""""""""""""""""""""""""
" Go plugins **************
autocmd FileType go compiler go
autocmd FileType go autocmd BufWritePre <buffer> Fmt
"""""""""""""""""""""""""""

" Change to buffer open in tab if error """""
set swb=usetab
"""""""""""""""""""""""""""""""""""""""""""""

" Shortcut per nova línia en blanc """"""
map <F3> O<ESC>
"""""""""""""""""""""""""""""""""""""""""

" Shortcut per grep """"""""""""
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
""""""""""""""""""""""""""""""""

" Comentaris amb F1 (comentar) i F2 (descomentar)
autocmd FileType go,c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <F1> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <F2> :<C-B>silent <C-E>s/\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
""""""""""""""""""""""""""""""""

" Ctrl-l per eliminar highlighting """"""""""""""
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"""""""""""""""""""""""""""""""""""""""""""""""""

" Autocompletion """""""""""""""
set completeopt=longest,menu
""""""""""""""""""""""""""""""""

" AutoWrite, quan fem :make es graven els canvis """"""""
set autowrite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Various
set background=dark     " Colors més vius perquè tenim un background obscur
set wildmenu            " Millora de l'autocompletion (tab)
set incsearch           " Cerca incremental
set hidden              " Canviem de buffer sense haver de desar
set autoread            " Carregar automàticament fitxers modificats externament
set hls                 " Highlight search

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Enable use of the mouse for all modes
set mouse=a

" Display line numbers on the left
set number

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. 
set shiftwidth=4
set tabstop=4

" Characters for visualizing "invisible" chars:
" (enable with :set list)
:set listchars=tab:»\ ,eol:¬
":set list

" Encryption method
if v:version >= 703
    set cryptmethod=blowfish
endif

" Enable syntax highlighting 
syntax on

" Status line
set statusline=%f%m%r%h%w\ [POS=%04l,%04v][%p%%]
set laststatus=2 " always show the status line

" Textwidth a 80 per fitxers de texte
:au BufRead,BufNewFile *.txt :set tw=80

" Syntax i textwidth a 80 per fitxers TeX
:au BufRead,BufNewFile *.tex :set tw=80
:au BufRead,BufNewFile *.tex :syntax enable

" GUI Options
if has('gui_running')
    colorscheme zellner
    set tabpagemax=50
endif


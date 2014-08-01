" 
" This is my personal .vimrc
"
" I have taken ideas from everyone. This file is constantly evolving.
"
" Get the file from github: git clone https://github.com/pnegre/myvimrc.git
" and make a symlink to ~/.vimrc
"
" Install vundle (simple management for plugins):
"
"   $ mkdir -p ~/.vim/bundle
"   $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" Open vim (ignore the errors) and install the plugins typing ":PluginInstall"
"
" That's it!!
"

" Vundle {{{

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
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'

" Aquest no m'acaba de convèncer, per go (syntax checker en gravar)
" Plugin 'scrooloose/syntastic'

" This requires installation of additional software: gocode
" Enables autocompletion in go (omni-completion)
Plugin 'nsf/gocode', {'rtp': 'vim/'}

call vundle#end()

"}}}

" Plugins Settings {{{

" Set go compiler for go files
autocmd FileType go compiler go
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Auto load NERDTREE if called without arguments and only from GUI
if has("gui_Running")
    autocmd VimEnter * if !argc() | NERDTree | endif
endif

" }}}

" Mappings {{{

" Leader is comma
let mapleader = ","

" Comentaris amb F1 (comentar) i F2 (descomentar)
autocmd FileType go,c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <F1> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <F2> :<C-B>silent <C-E>s/\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Shortcut per nova línia en blanc """"""
map <F3> O<ESC>

" Shortcut per grep """"""""""""
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" Ctrl-l per eliminar highlighting """"""""""""""
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Use <space> to fold and unfold in normal mode
nnoremap <space> zA

" Exit with <leader>q
map <leader>q :qa!<cr>

" Exit and save with <leader>x
map <leader>x :wqa<cr>

" When searching, keep the result centered horizontally
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping
nnoremap <c-o> <c-o>zz

" Evil cursor keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" }}}

" Abreviacions {{{

" Shebang python
iabbrev ##p #!/usr/bin/python<cr># -*- coding: utf-8 -*-

" }}}

" Various {{{

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" No backups and swap files 
set noswapfile
set nobackup

" utf8
scriptencoding utf-8
set encoding=utf-8

" Various
set background=dark     " Colors més vius perquè tenim un background obscur
set wildmenu            " Millora de l'autocompletion (tab)
set hidden              " Canviem de buffer sense haver de desar
set autoread            " Carregar automàticament fitxers modificats externament
set hls                 " Highlight search

" Disable bell
set noeb vb t_vb=

" Folding (default markers)
set foldmethod=marker

" Keep lines visible when scrolling
set scrolloff=3

" }}}

" GUI {{{

" No bell on GUI
au GUIEnter * set vb t_vb=

" GUI Options
if has('gui_running')
    colorscheme zellner
    set tabpagemax=50
endif

" }}}

" Autocommands {{{

" Textwidth a 80 per fitxers de texte
:au BufRead,BufNewFile *.txt :set tw=80

" Syntax i textwidth a 80 per fitxers TeX
:au BufRead,BufNewFile *.tex :set tw=80
:au BufRead,BufNewFile *.tex :syntax enable

" Go autocommands
:au FileType go setlocal foldmethod=syntax 

" }}}

" Search, indent, tabs, etc...  {{{

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Incremental search
set incsearch 

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Indentation settings
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" }}}

" Miscellaneous {{{

" Change to buffer open in tab if error """""
set swb=usetab

" Autocompletion """""""""""""""
set completeopt=longest,menu

" AutoWrite, quan fem :make es graven els canvis """"""""
set autowrite

" Enable use of the mouse for all modes
set mouse=a

" Display line numbers on the left
set number

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

" }}}

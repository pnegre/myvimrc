
" Go plugins **************
set rtp+=$GOROOT/misc/vim
"""""""""""""""""""""""""""

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Various
:set background=dark	" Colors més vius perquè tenim un background obscur
:set wildmenu			" Millora de l'autocompletion (tab)
:set incsearch			" Cerca incremental

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
:set listchars=tab:>\ ,eol:¬
":set list

" Encryption method
:set cryptmethod=blowfish

" Enable syntax highlighting 
:syntax on

" Status line
set statusline=%f%m%r%h%w\ [POS=%04l,%04v][%p%%]
set laststatus=2 " always show the status line

" Textwidth a 80 per fitxers de texte
:au BufRead,BufNewFile *.txt :set tw=80

" Syntax i textwidth a 80 per fitxers TeX
:au BufRead,BufNewFile *.tex :set tw=80
:au BufRead,BufNewFile *.tex :syntax enable

" Automatic parens and braces:
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 elseif line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf

vim -c "so conque_2.3.vmb" +qall
wget https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh -O- | sh

cat > ~/.vimrc <<EOF
"======================
"  General Settings
"======================
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'osyo-manga/vim-marching'
NeoBundle 'osyo-manga/vim-snowdrop'
NeoBundle 'bling/vim-airline'
NeoBundle 'klen/python-mode'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'gilligan/vim-lldb'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set history=888    " Remember 888 lines of history
set hidden
filetype plugin on
filetype indent on
set encoding=utf8
try
  lang en_US
catch
endtry
set fileformats=unix,dos,mac " Default file types
" Backups and undo
set nobackup
try
  set undodir=/tmp/vim_undo
  set undofile
catch
endtry

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc
set autoread       " When file is changed, auto read the change
set autowrite      " Auto save files
set updatetime=100

set wildmenu       " Enhanced wildchar menu when typing in command-line

"======================
"  Color Settings
"======================
syntax enable
syntax on
if has("gui_running")
  set t_Co=256
  set guifont=Monaco:h11
endif
set background=dark
try
  colorscheme peaksea
catch
  colorscheme desert
endtry

"======================
"  Editor Settings
"======================
set number         " Show line number
set ruler
set showmatch
set backspace=indent,eol,start
set clipboard=unnamed
" Indentation
set smartindent
set autoindent
set cindent
set cinoptions=:0g0t0
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
" Searching
set incsearch
set hlsearch
set ignorecase     " Together with smartcase, ignore case only
set smartcase      " => when the pattern is all lower case

"======================
"  Enable Mouse Use
"======================
set mouse=a
set ttymouse=xterm2
behave xterm
set selectmode=mouse

"======================
" General Key Bindings 
"======================
let mapleader=","
let g:mapleader=","
map <C-C> "+y <CR>
nnoremap <silent> <F3> :Grep<CR>

"======================
"  Tab Config
"======================
set showtabline=2
nnoremap <A-k>  :bprevious<CR>
nnoremap <A-j>  :bnext<CR>
nnoremap <S-h>  :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
map <leader>tn :tabnew<CR> 
map <leader>te :tabedit
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove
map <leader>t% :tabedit %<CR>

"======================
" Manage Split Windows 
"======================
map <C-h> :wincmd h<CR>
map <C-j> :wincmd j<CR>
map <C-k> :wincmd k<CR>
map <C-l> :wincmd l<CR>
map <C-up>     :wincmd +<CR>
map <C-down>   :wincmd -<CR>
map <C-left>   :wincmd <<CR>
map <C-right>  :wincmd ><CR>

"======================
"  vim-airline
"======================
let g:airline#extensions#tabline#enabled=1

"======================
"  VimShell
"======================
map <leader>sh  :ConqueTerm zsh<CR>
map <leader>shs :ConqueTermSplit zsh<CR>

"======================
"  Unite
"======================
map <leader>ff  :Unite file<CR>
map <leader>fb  :Unite buf<CR>

"======================
"  NeoComplete
"======================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : '$HOME/.vimshell_hist',
    \ 'scheme' : '$HOME/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>   neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Enable code completion with snowdrop
let g:neocomplete#sources#snowdrop#enable = 1
" Not skip
let g:neocomplete#skip_auto_completion_time = ""

"======================
"  Snowdrop
"======================
" set libclang directory path
"let g:snowdrop#libclang_directory = "/Library/Developer/CommandLineTools/usr/lib/"

" set include directory path.
"let g:snowdrop#include_paths = {
"\   "cpp" : {
"\       "C:/cpp/boost",
"\       "C:/cpp/sprout",
"\   }
"\}

" set clang command options.
let g:snowdrop#command_options = {
\   "cpp" : "-std=c++1y",
\}

"======================
"  Rainbow Parentheses
"======================
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max=16
let g:rbpt_loadcmd_toggle=0

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

"======================
"  python-mode
"======================
let g:pymode_options_max_line_length = 119 
let g:pymode_lint_cwindow = 1
let g:pymode_run_bind = '<leader>r'


EOF



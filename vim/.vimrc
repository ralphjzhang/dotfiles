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
      \     'windows' : 'tools\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'vim-scripts/csv.vim'
NeoBundle 'Valloric/YouCompleteMe'

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

" wget https://github.com/jnurmine/Zenburn/raw/master/colors/zenburn.vim
try
  colorscheme zenburn
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
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
"  vimshell
"======================
nnoremap <leader>vs :VimShell<CR>
let g:vimshell_prompt_expr='escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern='^\%(\f\|\\.\)\+> '

"======================
"  vim-airline
"======================
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='papercolor'

"======================
"  FuzzyFinder
"======================
map <leader>ff   :FufFile<CR>
map <leader>fff  :FufFileWithFullCwd<CR>

"======================
"  YouCompleteMe
"======================
let g:ycm_confirm_extra_conf=''
let g:ycm_error_symbol='>>'
let g:ycm_warning_symbol='>*'
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nmap <F4> :YcmDiags<CR>



set nocompatible
filetype on
filetype off
filetype plugin on

" turn off the bell
set visualbell

" set color
set t_Co=256

let s:dotvim = fnamemodify(globpath(&rtp, 'sbvim.dir'), ':p:h')

" let's install plugged
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let s:beforerc = expand(s:dotvim . '/before.vimrc')

let mapleader = ","
let maplocalleader = "\\"
if filereadable(s:beforerc)
    exec ':so ' . s:beforerc
endif

" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" General
Plug 'editorconfig/editorconfig-vim'

Plug 'mileszs/ack.vim'
nnoremap <leader>a :Ack -i<space>

" Transforms markup languages ? alternatives
Plug 'wikimatze/hammer.vim'
nmap <leader>p :Hammer<cr>

Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" This is a simple plugin that helps to end certain structures automatically.
Plug 'tpope/vim-endwise'

Plug 'tpope/vim-repeat'

" help with incrementing the dates properly
Plug 'tpope/vim-speeddating'

" changed, add, delete parantheses, brackets, quotes, XML tags, etc.
" cs"' changes double quotes to single quotes
" ds" to delete double quotes
" ysiw] to soround selected text object (iw) with ]
Plug  'tpope/vim-surround'

" this one needs reading the documentation
" tpope/vim-unimpaired

" meta-p cycles backward through the yank stack
" meta-shift-p cycles forwards trhough history of yanks
" met = Alt but not working in WSL, find a fix?
Plug 'maxbrunsfeld/vim-yankstack'

" :Delete: Delete a buffer and the file on disk simultaneously.
" :Unlink: Like :Delete, but keeps the now empty buffer.
" :Move: Rename a buffer and the file on disk simultaneously.
" :Rename: Like :Move, but relative to the current file's containing
" directory.
" :Chmod: Change the permissions of the current file.
" :Mkdir: Create a directory, defaulting to the parent of the current file.
" :Cfind: Run find and load the results into the quickfix list.
" :Clocate: Run locate and load the results into the quickfix list.
" :Lfind/:Llocate: Like above, but use the location list.
" :Wall: Write every open window. Handy for kicking off tools like guard.
" :SudoWrite: Write a privileged file with sudo.
" :SudoEdit: Edit a privileged file with sudo.
" File type detection for sudo -e is based on original file name.
" New files created with a shebang line are automatically made executable.
" New init scripts are automatically prepopulated with /etc/init.d/skeleton.
Plug 'tpope/vim-eunuch'


Plug 'scrooloose/nerdtree'
" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L
" Keep NERDTree window fixed between multiple toggles
set winfixwidth

" Shows a file explorer
" Plug 'tpope/vim-vinegar'
" autocmd FileType netrw setl bufhidden=wipe

" Read later ?  text-objects
"kana/vim-textobj-user

" allows stroing yanked text ot a file to be used across sessions
" read :h yankring-tutorial
Plug 'vim-scripts/YankRing.vim'
let g:yankring_replace_n_pkey = '<leader>['
let g:yankring_replace_n_nkey = '<leader>]'
let g:yankring_history_dir = s:dotvim.'/tmp/'
nmap <leader>y :YRShow<cr>

Plug 'michaeljsmith/vim-indent-object'
let g:indentobject_meaningful_indentation = ["haml", "sass", "python", "yaml", "markdown"]

" use % to match more things other than just brackest
Plug 'tmhedberg/matchit'

"  Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
"  Read documentation :CtrlP to start, do I need this?
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode = ''

" brings up a temp scratch buffer to edit :scratch, or new split window
" :Sscratch , it retains the content of the buffer
Plug 'vim-scripts/scratch.vim'

" Switch between multiple buffers quickly :EasyBuffer or <leader>be
Plug 'troydm/easybuffer.vim'
nmap <leader>be :EasyBufferToggle<cr>


" Read the documentation, this is interesting
Plug 'terryma/vim-multiple-cursors'


"Fancy
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='molokai'

" Indent
" Plug 'Yggdroot/indentLine'
"set list lcs=tab:\|\
" let g:indentLine_color_term = 111
" let g:indentLine_color_gui = '#DADADA'
"let g:indentLine_char = 'c'
"let g:indentLine_char = '∙▹¦'
"let g:indentLine_char = '∙'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"

" tmux
"Plug 'zaiste/tmux.vim' ?
Plug 'benmills/vimux'
map <Leader>rp :VimuxPromptCommand<CR>
map <Leader>rl :VimuxRunLastCommand<CR>

map <LocalLeader>d :call VimuxRunCommand(@v, 0)<CR>
au! BufNewFile,BufRead /tmp/bash-fc* setfiletype sh

""""""""""""""""""""""""""""""""
" Coding
""""""""""""""""""""""""""""""""
" TagBar
Plug 'majutsushi/tagbar'
nmap <leader>t :TagbarToggle<CR>

""""""""""""""""""""""""""""""""
" git
Plug 'tpope/vim-fugitive'
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit -v<CR>
nmap <leader>gac :Gcommit --amen -v<CR>
nmap <leader>g :Ggrep
" ,f for global git search for word under the cursor (with highlight)
nmap <leader>f :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
" same in visual mode
:vmap <leader>f y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

Plug 'gregsexton/gitv', {'on': ['Gitv']}

autocmd FileType gitcommit set tw=68 spell
autocmd FileType gitcommit setlocal foldmethod=manual


""""""""""""""""""""""""""""""""
" NERDComment
" <leader>cm only use one delimeter, <leader>cc comment, <leader>cy comment and yank, <leader>ci reverse,
" <leader>cA comment at the end of the line, <leader>cs comment selected
Plug 'scrooloose/nerdcommenter'
nmap <leader># :call NERDComment(0, "invert")<cr>
vmap <leader># :call NERDComment(0, "invert")<cr>

"""""""""""""""""""""""""""""""
" ALE
Plug 'w0rp/ale'
let g:ale_cache_executable_check_failures = 1

"""""""""""""""""""""""""""""""
" Python
Plug 'python-mode/python-mode', { 'branch': 'develop', 'for' : 'python' }

"""""""""""""""""""""""""""""""
" Go
Plug 'fatih/vim-go', {'for' : 'go'}
let g:go_disable_autoinstall = 1

"""""""""""""""""""""""""""""""
" Clang: TODO: check other plugins
Plug 'rhysd/vim-clang-format'


"""""""""""""""""""""""""""""""
" Rust
Plug 'wting/rust.vim', { 'for': 'rust'}


"""""""""""""""""""""""""""""""
" Color
"""""""""""""""""""""""""""""""
set t_Co=256
Plug 'tomasr/molokai'
let g:molokai_original = 1


Plug 'jeffkreeftmeijer/vim-numbertoggle'
set number relativenumber

" Install user-supplied Bundles {{{
let s:extrarc = expand(s:dotvim . '/extra.vimrc')
if filereadable(s:extrarc)
    exec ':so ' . s:extrarc
endif
" }}}

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"" On-demand loading
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go'
"
"" Plugin options
"Plug 'nsf/gocode'
"
"" Initialize plugin system
call plug#end()

colorscheme molokai

""""""""""""""""""""""""""
" General {{{
filetype plugin indent on

syntax on

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set showbreak=↪


" _ backups {{{
if has('persistent_undo')
  " undo files
  exec 'set undodir='.s:dotvim.'/tmp/undo//'
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
" backups
exec 'set backupdir='.s:dotvim.'/tmp/backup//'
" swap files
exec 'set directory='.s:dotvim.'/tmp/swap//'
set backup
set noswapfile
" _ }}}
"
set modelines=0
set noeol
set numberwidth=3
set winwidth=83
set ruler

set showcmd

set matchtime=2

set completeopt=longest,menuone,preview

" }}}

" . searching {{{

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set showmatch
set gdefault
set hlsearch

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Don't jump when using * for search
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" }}}

" Navigation & UI {{{

" more natural movement with wrap on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Easy buffer navigation
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Bubbling lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

nmap <tab> :NERDTreeToggle<cr>

" }}}


" Settings {{{
set autoread
set backspace=indent,eol,start
set binary
set cinoptions=:0,(s,u0,U1,g0,t0
set completeopt=longest,menuone
set encoding=utf-8
set t_Co=256        "Use 256 colours by default
"set mouse=a         "Enables some basic mouse support
set hidden
set history=1000
set incsearch
set laststatus=2
set list
" }}}

""""""""""""""""""""""""""""""""""""""

" Load addidional configuration (ie to overwrite shorcuts) {{{
let s:afterrc = expand(s:dotvim . '/after.vimrc')
if filereadable(s:afterrc)
    exec ':so ' . s:afterrc
endif
" }}}
set foldmethod=indent"
set foldlevel=20
set cc=80

" White characters {{{
set autoindent
set softtabstop=0
set textwidth=80
set smarttab
set tabstop=8 shiftwidth=4 expandtab
set wrap
set whichwrap=b,s,<,>,[,]         "Set what can/cannot be wrapped
set spelllang=en_gb                 "Set spell check to The Queen's English
set formatoptions=qrn1
if exists('+colorcolumn')
  set colorcolumn=+1
endif
set cpo+=J
" }}}


:filetype plugin on
:syntax on
:set number
set mouse=a
"set spell
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
colorscheme ron
let g:solarized_termcolors=256
set background=dark
set guiheadroom=0
set history=700
filetype plugin on
filetype indent on
set autoread
let mapleader = ","
let g:mapleader = ","
nmap <leader>w :w!<cr>
command W w !sudo tee % > /dev/null
set so=7
set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif
set ruler
set cmdheight=1
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set mat=2
set showmatch
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"set foldcolumn=1


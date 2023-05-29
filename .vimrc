" Vbundle插件管理
" *********************************************
set nocompatible " required
filetype off " required
 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
" Add maktaba and codefmt to the runtimepath.

" ...
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
"JSX 程式碼外掛
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" 對齊線
Plugin 'Yggdroot/indentLine'
Plugin 'nathanaelkane/vim-indent-guides'
" 括號彩虹
Bundle 'luochen1990/rainbow'


"git commit record
Plugin 'zivyangll/git-blame.vim'

"syntax 
Plugin 'dense-analysis/ale'

call vundle#end()
" *********************************************
" NERD插件属性
" *********************************************
map <F2> :NERDTreeToggle<CR>
 
"不同顏色括號
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

"對齊線
let g:indentLine_char = '|'
let g:indentLine_color_term = 0
let g:indentLine_bgcolor_term = 239
let $LANG = 'en_US'
"map Leader 設定
let mapleader = "," 
let g:mapleader = ","

" 設定註釋快捷鍵
map <F4> <leader>ci<CR>

set clipboard=unnamed
set cindent
set cursorline
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set backspace =indent,eol,start
set number
set ruler
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set matchtime=5
set ignorecase
set incsearch
set cursorline
set cursorcolumn
set showmatch
set scrolloff=5
set laststatus=2
set foldmethod=indent
set foldlevel=99
set wrap                      "設定程式碼不折行"
set langmenu=en_US
set encoding=UTF-8
set foldmethod=marker
colorscheme jellybeans
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap [ []<Esc>i
inoremap {<CR> {<CR>}<Esc>ko
inoremap {{ {}<ESC>i
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
filetype indent on
hi Visual cterm=none ctermbg=darkgrey ctermfg=White
hi MatchParen ctermbg=Yellow guibg=lightblue
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

 
" Quickly Run
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F5> :call CompileAndRun()<CR>
func! CompileAndRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc -std=c11 % -o /tmp/a.out && /tmp/a.out"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -o /tmp/a.out && /tmp/a.out"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!%
    elseif &filetype == 'python'
        exec "!python3 %"
    endif
endfunc


" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0

" Vbundle插件管理
" *********************************************
set nocompatible " required
filetype off " required
 
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" Add maktaba and codefmt to the runtimepath.
" ...
Plugin 'gmarik/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'
Plugin 'docker/docker'
Plugin 'c9s/helper.vim'
Plugin 'c9s/treemenu.vim'
Plugin 'c9s/vikube.vim'
Plugin 'scrooloose/nerdtree'
"JSX 程式碼外掛
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'scrooloose/syntastic'

Bundle 'luochen1990/rainbow'
" Add all your pl:help :Glaiveugins here (note older versions of Vundle used Bundle instead of Plugin)
" All of your Plugins must be added before the following line
call vundle#end()
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"
filetype plugin indent on " required
" *********************************************
" NERD插件屬性
" *********************************************
" default開啟NERDTree
""au vimenter * NERDTree 
" F2為開啟NERDTree的快捷键
map <F2> :NERDTreeToggle<CR>
" 開啟時focus
map <F4> :TagbarToggle<CR>
let g:tagbar_auto_faocus =1
" 開啟指定文件時自動開啟tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
 

"k8s設定檔"
"To turn on automatic list update:
let g:vikube_autoupdate = 1
"To change the default tail lines for logs:
let g:vikube_default_logs_tail = 100
"To use current namespace instead of "default":
let g:vikube_use_current_namespace = 1
"To disable the default highlight for CursorLine
let g:vikube_disable_custom_highlight = 1
"不同顏色括號
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
" 設定註釋快捷鍵
map <F4> <leader>ci<CR>


set clipboard=unnamed
set cindent
set cursorline
syntax on
set tabstop=4
set shiftwidth=4
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
colorscheme kolor
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap [ []<Esc>i
inoremap {<CR> {<CR>}<Esc>ko
inoremap {{ {}<Esc>i
filetype indent on

 
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

" Indent Python in the Google way. （google style）

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END



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
" NERD插件属性
" *********************************************
" 开启vim的时候默认开启NERDTree
""au vimenter * NERDTree 
" 设置F2为开启NERDTree的快捷键
map <F2> :NERDTreeToggle<CR>
" 启动时自动focus
map <F4> :TagbarToggle<CR>
let g:tagbar_auto_faocus =1
" 启动指定文件时自动开启tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
 
" *********************************************
" YCM插件相关
" *********************************************
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
" 让vim的补全菜单行为与一般IDE一致
set completeopt=longest,menu
" 触发(符号)补全时需要键入的字符数
let g:ycm_min_num_of_chars_for_completion = 1
" 补全候选项的最小字符数
let g:ycm_min_num_identifier_candidate_chars = 0
" 关闭诊断显示功能(已经使用了ale进行异步语法检查)
let g:ycm_show_diagnostics_ui = 0
" 在字符串和注释中仍会触发补全
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" 禁止缓存匹配项，每次重新生成匹配项
let g:ycm_cache_omnifunc = 0
" 在用户接受提供的完成字符串后自动关闭窗口
let g:ycm_autoclose_preview_window_after_completion = 0
" 跳转到声明或定义处
nnoremap <silent><leader>gj :YcmCompleter GoToDefinitionElseDeclaration<cr>

" 自动触发语义补全
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{1}'],
            \ 'cs,lua,javascript': ['re!\w{1}'],
            \ }
" 遇到下列文件时才会开启YCM
let g:ycm_filetype_whitelist = {
            \ "c":1,
            \ "cpp":1,
            \ "python":1,
            \ "sh":1,
            \ }
"nnoremap <F5> :YcmForceCompileAndDiagno
" nerdcommenter預設熱鍵<leader>為'\'，這裡將熱鍵設定為','
let mapleader=','

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

" Indent Python in the Google way.

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


"分開不同檔案vimrc
filetype plugin on
"js
"for scrooloose/syntastic' 
set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*
 let g:syntastic_always_populate_loc_list = 1
 let g:syntastic_auto_loc_list = 1
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0
 let g:syntastic_javascript_checkers = ['standard']
 let g:syntastic_javascript_standard_generic = 1
 let g:syntastic_javascript_checkers = ['eslint']
 let g:syntastic_javascript_eslint_exec = 'eslint'

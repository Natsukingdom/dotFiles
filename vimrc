syntax enable
colorscheme solarized
set background=dark
set belloff=all
set noro

"バッファの設定-------------------------------------------
set hidden
"---------------------------------------------------------
"---------------------------------------------------------
"clipboardの設定
"---------------------------------------------------------
set clipboard+=unnamed

"---------------------------------------------------------
"mouse設定
"---------------------------------------------------------
set mouse=a
set ttymouse=xterm2
"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
"set cursorline " カーソルラインをハイライト

" 行を折り返さない
set nowrap
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start


" ESCキーを割り当てる
" jjでエスケープ
inoremap <silent> jj <ESC>

" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っｊ <ESC>

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
nmap n nzz " 検索時に結果を画面中央部に寄せてくれる。
nmap N Nzz
nmap * *zz
nmap # #zz

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,shift-jis,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
set guifont=Ricty\ Diminished\ Regular:h18

"----------------------------------------------------------
" ステータスライン
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの位置を表示する
set ruler "ルーラーをセットする


"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅
if has("autocmd")
    "ファイルタイプの検索を有効にする
    filetype plugin on
    "ファイルタイプに合わせたインデントを利用
    filetype indent on
    "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
    autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
    autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
    autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
    autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
    autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
    autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
    autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
    autocmd FileType typescript  setlocal sw=2 sts=2 ts=2 et
    autocmd FileType yaml        setlocal sw=2 sts=2 ts=2 et
    autocmd FileType markdown    setlocal sw=2 sts=2 ts=2 et
endif

"----------------------------------------------------------
"swapfileを作成しない。
"----------------------------------------------------------
set noswapfile

"----------------------------------------------------------
".md拡張子のファイルもmarkdownファイルとして認識させる。
"----------------------------------------------------------
au BufRead,BufNewFile *.md set filetype=markdown

"----------------------------------------------------------
".dig拡張子のファイルをyamlファイルとして認識させる。
"----------------------------------------------------------

au BufNewFile,BufRead *.dig            setf yaml

"----------------------------------------------------------
"fzfをvim内で使う
"----------------------------------------------------------
set rtp+=/usr/local/opt/fzf
nnoremap <silent> <C-]> :call fzf#vim#tags(expand('<cword>'))<CR>
"----------------------------------------------------------
"以下バンドル管理
"----------------------------------------------------------
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
    set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

call dein#begin(s:dein_dir)

:
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
"エラー検証
"call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/unite-outline')
call dein#add('Townk/vim-autoclose')
call dein#add('Yggdroot/indentLine')
call dein#add('airblade/vim-gitgutter')
call dein#add('godlygeek/tabular')
call dein#add('kannokanno/previm')
call dein#add('osyo-manga/vim-monster')
"call dein#add('plasticboy/vim-markdown')
call dein#add('scrooloose/nerdtree')
call dein#add('todesking/ruby_hl_lvar.vim')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-fugitive')
call dein#add('tyru/open-browser.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-ruby/vim-ruby')
call dein#add('vim-scripts/AnsiEsc.vim')
call dein#add('vim-scripts/grep.vim')
call dein#add('tpope/vim-rails')
call dein#add('scrooloose/syntastic')
call dein#add('fatih/vim-go')
call dein#add('elixir-lang/vim-elixir')
call dein#add('justmao945/vim-clang')
call dein#add('othree/yajs.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('maxmellon/vim-jsx-pretty')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('othree/es.next.syntax.vim')
call dein#add('leafgarland/typescript-vim')
call dein#add('junegunn/fzf.vim')
call dein#add('Quramy/vim-js-pretty-template')

call dein#end()

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" Unite.vimの設定----------------------------------------------------
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
"最近使ったファイル一覧
noremap <C-Z> :Unite file_mru<CR>



"neocomplete設定
autocmd VimEnter * NeoCompleteEnable " Enable NeoComplete at startup

" neocompleteにruby用の辞書ファイルを追加する
let g:neocomplete#sources#dictionary#dictionaries = {
            \   'ruby': $HOME . '/dicts/ruby.dict',
            \ }


" ブランチ情報を表示する(airline)
let g:airline#extensions#branch#enabled = 1

" neocomplete と osyo-manga/vim-monster の 連携設定
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}
" neocomplete_cache
let g:neocomplcache_enable_at_startup = 1

" Rsense用の設定
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

"rsenseのインストールフォルダがデフォルトと異なるので設定
let g:rsenseHome = expand("~/.rbenv/shims/rsense")
let g:rsenseUseOmniFunc = 1
" vim-markdownの設定
let g:vim_markdown_folding_disabled = 1

"rubocopを自動的, scrooloose/syntastic連携
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'passive_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"matchit有効化
if !exists('loaded_matchit')
    runtime macros/matchit.vim
endif

"http://yamitzky.hatenablog.com/entry/20111213/1323739808 の設定真似してみる。
"erb の 埋め込み補完
inoremap <expr> % Lt_Percent_Completion()
function Lt_Percent_Completion()
  if matchstr(getline('.'), '.', col('.') -1 ) == ">"
		return "\%\%\<Left>"
	else
		return "\%"
	end
endf

"goの補完について設定
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
let g:go_gocode_unimported_packages = 1
let g:go_def_mode = "gopls"

"cの補完について設定
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:clang_auto = 0
let g:clang_c_completeopt = 'menuone'
let g:clang_cpp_completeopt = 'menuone'




" 城所流 道場破り編
let mapleader = "\<Space>"

nnoremap <leader>b :Buffers<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>a :Ag <c-r><c-w>

nnoremap <leader>* :AFS<cr>

command! -bang -nargs=* -complete=file AFS call AFS('grep<bang>', <q-args>)
function! AFS(cmd, args)
  let search =  getreg('/')
  " translate vim regular expression to perl regular expression.
  let search = substitute(search,'\(\\<\|\\>\)','\\b','g')
  "call fzf#vim#ag(a:cmd, '"' .  search .'" '. a:args)
  "call fzf#vim#ag('"' .  search .'" '. a:args)
  call fzf#vim#ag(search)
endfunction
" /城所流

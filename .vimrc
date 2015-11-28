"release autogroup in MyAutoCmd
augroup MyAutoCmd
	autocmd!
augroup END


"NeoBundle Settings
"--------------------------------------------

let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
	let s:noplugin = 1
    else
	if has('vim_starting')
       execute "set runtimepath+=" . s:neobundle_root
    endif
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle "Shougo/vimproc", {
       \ "build": {
       \   "windows"   : "make -f make_mingw32.mak",
       \   "cygwin"    : "make -f make_cygwin.mak",
       \   "mac"       : "make -f make_mac.mak",
       \   "unix"      : "make -f make_unix.mak",
       \ }}

"Insert plugin Here-----------------------------------

"Unite.vim
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'sjl/gundo.vim'

"vim-tamplateをいれるつもり
"
"

NeoBundle 'Align'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'thinca/vim-quickrun'

"囲んでいるものをなんとかするプラグイン
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'


"NeoComplete
"補完スクリプト
if has('lua') && v:version >= 703 && has('patch885')
    NeoBundleLazy "Shougo/neocomplete.vim", {
            \ "autoload": {
            \   "insert": 1,
            \ }}
        let g:neocomplete#enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
        function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplet#enable_smart_case = 1

    endfunction
    else
        NeoBundleLazy "Shougo/neocomplcache.vim", {
        \ "autoload": {
        \   "insert": 1,
        \ }}
    let g:neocomplcache_enable_at_startup = 1
        let s:hooks = neobundle#get_hooks("neocomplcache.vim")
    function! s:hooks.on_source(bundle)
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_smart_case = 1
        endfunction
endif

"Neosnippet
"スニペット管理
NeoBundleLazy "Shougo/neosnippet.vim", {
      \ "depends": ["honza/vim-snippets"],
      \ "autoload": {
      \   "insert": 1,
      \ }}
let s:hooks = neobundle#get_hooks("neosnippet.vim")
function! s:hooks.on_source(bundle)
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"
       if has('conceal')
       set conceallevel=2 concealcursor=i
         endif
  let g:neosnippet#enable_snipmate_compatibility = 1
  let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
  endfunction

"Pythonの衝突問題の解決

NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
 "Vimで正しくvirtualenvを処理できるようにする
 NeoBundleLazy "jmcantrell/vim-virtualenv", {
       \ "autoload": {
             \   "filetypes": ["python", "python3", "djangohtml"]
                   \ }}

"カラースキーム
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'w0ng/vim-hybrid'
"-----------------------------------------------------

    call neobundle#end()
    NeoBundleCheck
    endif

"Markdown形式のファイルにはText環境でのシンタックスハイライトを行う
au BufNewFile,BufRead *.md setf text
"textもMarkdownでシンタックスハイライト
"au BufNewFile,BufRead *.txt setf markdown
"
" search setting
language C
set ignorecase
set smartcase
set incsearch
set hlsearch
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" editing
set shiftround
set infercase
set hidden
set switchbuf=useopen
set showmatch
set matchtime=2
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start

if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed
else
    set clipboard& clipboard+=unnamed
endif

set nowritebackup
set nobackup
set noswapfile

"display
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化

" 前時代的スクリーンベルを無効化
set t_vb=0
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

"タブ文字の幅はスペース4個分にする
set tabstop=4
set shiftwidth=4
"key settings

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up> <C-w>-
nnoremap <Down> <C-w>+


" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
 let s:local_vimrc = expand('~/.vimrc.local')
 if filereadable(s:local_vimrc)
     execute 'source ' . s:local_vimrc
     endif


" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on
syntax enable
" set background=light
set background=dark
colorscheme solarized

" Marcdownドキュメント一括変換コマンド
" 将来的にquickrunに統合したい
":command! Ppdf w | !pandoc -f markdown-superscript+tex_math_single_backslash -o %:r.pdf -V documentclass=ltjarticle --latex-engine=lualatex --number-sections %

:command! Ppdf w |!pandoc -f markdown+superscript+tex_math_single_backslash -o %:r.pdf -V documentclass=ltjarticle --latex-engine=lualatex --number-sections %
:command! NewPpdf w | :silent !pandoc -f markdown+superscript+tex_math_single_backslash -o %:r.pdf -V documentclass=ltjarticle --latex-engine=lualatex --number-sections % | :redraw!<CR>
".vimrcを開く
nnoremap <F2> :<C-u>tabe $MYVIMRC<CR>  G
command! ReloadVimrc w | source $MYVIMRC |q

"c++ファイルを実行する
command! Gpp !g++ -Wall -g % && !./a.out

"句点読点を半角のコンマ,ピリオドに変換する
command! Convperiod w | :%s/､/,/g | :%s/、/,/g | :%s/，/,/g | :%s/｡/./g | :%s/。/./g |:%s/．/./g

"前回終了時のカーソル位置の記憶
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"viminfoの保存先を.dotfile内にする
set viminfo+=n~/.dotfiles/.viminfo

"vimで緊急に改善したい部分
"タブ、ウインドウのマッピング
"自動補完、スニペットの機能
"シンタックスファイル
"Unite.vim活用
"Quickru活用
"
"

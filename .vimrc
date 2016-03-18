"release autogroup in MyAutoCmd
augroup MyAutoCmd
	autocmd!
augroup END

"File encoding settings
set encoding=utf-8
set fileencodings=iso-2022-jp,enc-ja,sjis,utf-8
set fileformats=unix,dos,mac


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
NeoBundle 'vim-pandoc/vim-pandoc-syntax'
NeoBundle 'Align'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'


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

NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
 NeoBundleLazy "jmcantrell/vim-virtualenv", {
       \ "autoload": {
             \   "filetypes": ["python", "python3", "djangohtml"]
                   \ }}

NeoBundle 'altercation/vim-colors-solarized'
"-----------------------------------------------------

    call neobundle#end()
    NeoBundleCheck
    endif

"au BufNewFile,BufRead *.md setf pandoc 
au BufNewFile,BufRead *.txt setf markdown
" search setting
language C
set ignorecase
set smartcase
set incsearch
set hlsearch
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

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
set number
set wrap
set textwidth=0
set t_vb=0
set novisualbell
set tabstop=4
set shiftwidth=4
inoremap jj <Esc>
nmap <silent> <Esc><Esc> :nohlsearch<CR>
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap j gj
nnoremap k gk
vnoremap v $h
nnoremap <Tab> %
vnoremap <Tab> %
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up> <C-w>-
nnoremap <Down> <C-w>+


function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

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

 let s:local_vimrc = expand('~/.vimrc.local')
 if filereadable(s:local_vimrc)
     execute 'source ' . s:local_vimrc
     endif

filetype plugin indent on
syntax enable
set background=dark
colorscheme solarized

:command! Ppdf w |!pandoc -f markdown+superscript+tex_math_single_backslash -o %:r.pdf -V documentclass=ltjarticle --latex-engine=lualatex --number-sections %
:command! NewPpdf w | :silent !pandoc -f markdown+superscript+tex_math_single_backslash -o %:r.pdf -V documentclass=ltjarticle --latex-engine=lualatex --number-sections % | :redraw!<CR>
nnoremap <F12> :<C-u>tabe $MYVIMRC<CR>  G
command! R w | source $MYVIMRC |q

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
set viminfo+=n~/dotfiles/.viminfo
set history=500

" vim: foldmethod=marker
" vim: foldmarker=\{{{,\}}}
"                                          _ __ _,  ＿_
"                                      ,.-' 丶   '｀丶/
"                                    ／ ）     ￣     ＼
"                           _,..,_ /__／        r ―-､   ＼
"                        ／      ｀丶    ＿_    丶 ＿）  ヽ―-､_,
"                     _／             ＼/   ﾉ             | く ＼
"                    /                  ヽ￣              /  }￣
"                   /              _     |＿           ／   /
"                   |           ／  ｀ヽ.|  ｀ー---‐-´ __,ノ
"                  /           /   _＿  }ﾉ     __ -― ￣￣￣￣￣￣￣￣￣￣￣／＿＿＿
"                ／        ＿／  /￣     /   ,-                                  ／|
"               /     .／￣           _//   / ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣|  |
"              /  _ ／ _ ,-  __ , __-   |_,/￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣| |  |
"              (ｰ´_,.´     | |                                                | |  |/|
"                ￣        | |    |￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣|    | |    |
"                          | |    |                                      |    | | /| |
"                          | |    |                                      |    | ||/| |
"                          | |･>>>|                                      |    | || | |
"                          | |    |                                      |    | ||/  |
"                          | |    |                                      |    | |    |
"                          | |    |                                      |    | |    |
"                          | |    |     なつめ の init.vim               |    | |    |
"                          | |    |       かきこむ        たくわえる     |    | |    |
"                          | |    |       ニトロチャージ  とっておき     |    | |    |
"                          | |    |                                      |    | |    |
"                          | |    |                                      |    | |    |
"                          | |    |                                      |    | |    |
"                          | |    |                                      |    | |    |
"                          | |    |                                      |    | |    |
"                          | |    |＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿|    | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
" ----------------------------------------------------------------------------------------------------

augroup initvim
  autocmd!
augroup END



"--- Environment Variables: --------------------------------------------------{{{
let $XDG_CACHE_HOME = expand($HOME.'/.cache')
let $XDG_CONFIG_HOME = expand($HOME.'/.config')
let $XDG_DATA_DIRS = expand('/usr/local/share:/usr/share')
let $XDG_DATA_HOME = expand($HOME.'/.local/share')

let $CURRENT_FILE_PASS = expand("%")
let $CURRENT_FILE_NAME = substitute(expand("%:p"), "^.*/", "", "g")
let $CURRENT_DIR       = substitute(expand("%:p"), "/[^/]*$", "", "g")
"}}}

"--- Global Functions: -------------------{{{
let save_curpos = getcurpos()
set nocompatible

" function! g:Get_curpos_to_curpos() abort
"   let g:curpos = getcurpos()
" endfunction

" pos は配列で，その扱いがおかしいっぽい？
function! g:Set_curpos() abort
  call setpos('.', save_curpos)
endfunction

function! s:move_cursor_pos_mapping(str, ...)
  let left = get(a:, 1, "<Left>")
  let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
  return substitute(a:str, '<Cursor>', '', '') . lefts
endfunction
function! Move_cursor_pos_mapping(str)
  return s:move_cursor_pos_mapping(a:str, "\<Left>")
endfunction
" Ref: http://d.hatena.ne.jp/osyo-manga/20130424/1366800441
"}}}

"--- Global Settings: -------------------------------------{{{
set fenc=utf-8
set backupdir=$XDG_DATA_HOME/nvim/backup
" " file_name で backupをまとめようかと思ったけど，
" " ディレクトリが存在しないと保存できないのでめんどくさい。
" set backupdir=$XDG_DATA_HOME/nvim/backup/file_name
set backup
au initvim BufWritePre * let &bex = '.' . strftime("%Y%m%d_%H%M%S")
set directory=$XDG_DATA_HOME/nvim/swap
set swapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" hidden current buffer and open other files
set hidden
" 自動改行しない
set textwidth=0
set display=lastline
set pumheight=12
" spelling check
set spell
set spelllang=en,cjk
"}}}

"--- Motion ---------------------{{{
set whichwrap=<,>,[,],h,l
set backspace=indent,eol,start
" set mouse=a
set virtualedit=block
" スクロールの余裕を確保する
set scrolloff=2
" maintain cursor position
autocmd initvim BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
"}}}

" --- Undo ------------------{{{
set undodir=$XDG_DATA_HOME/nvim/undo
set undofile
set undolevels=1000
"}}}

" --- Yank, Paste, Resisters ----------- {{{
" set clipboard+=unnamedplus
autocmd initvim TextYankPost *
      \ echomsg "yank"string(v:event.regcontents)" to reg: ".v:event.regname
" }}}

" --- viminfo -------------------------- {{{
set viminfo+=n$XDG_DATA_HOME/nvim/viminfo
autocmd initvim TextYankPost * :wv
autocmd initvim FocusGained * :rv!
" }}}

" --- Marks ---------------- {{{
" mark[0-9] をキューのように扱うものとして再構成する。
" mark 0 に追加して，mark9 は削除する。
function! Push_queue_of_marks() abort
  echo "hoge"
endfunction
" }}}

" --- Folding -------------- {{{
set foldenable
set foldmethod=marker
set foldmarker=\{{{,\}}}
set foldtext=FoldCCtext()
let g:foldCCtext_head = ''
" let g:foldCCtext_tail = 'printf(" %s[%4d lines Lv%-2d ]%s  ", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'
let g:foldCCtext_tail = 'printf(" %s[ %4d   %s  ", substitute(repeat("[", v:foldlevel-1), "[[[[[", "V ", "g"), v:foldend-v:foldstart+1, (repeat("]", v:foldlevel).repeat(" ", 5-v:foldlevel))[0:4])'
set foldcolumn=3
set fillchars=vert:\|
" foldcolumn が足りなくなった時に，自動で大きくする バグあり
" Ref: http://leafcage.hateblo.jp/entry/20111223/1324705686
let g:foldCCtext_enable_autofdc_adjuster = 1
" Don't save options.
set viewoptions-=options
"{{{{{{{{{{{{{{{
"{{{
"{{{
"{{{
"{{{
"{{{
"{{{

"}}}
"}}}
"}}}
"}}}
"}}}
"}}}
"}}}
"}}}
"}}}
"}}}
"}}}
" }}}

" --- Information ------------------------- {{{
" 行番号を表示
set number
" ビープ音を可視化
" set visualbell
" 括弧入力時の対応する括弧を表示，その時間
set showmatch
set matchtime=1
" 入力中のコマンドをステータスに表示する
set showcmd
" 文字数
" set ruler
" ステータスラインを 0=表示しない,1=2画面以上だけ,2=常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" }}}

" --- Tab / invisible character ----------- {{{
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2
" オートインデント
set autoindent
" インデントはスマートインデント
set smartindent
" タブを >--- 半スペを . で表示する
set listchars=tab:>-,trail:.
" 不可視文字を表示する
set list
" }}}

" --- Search ------------------------------ {{{
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" }}}



" about help ---------------------
" If true Vim master, use English help file.
set helplang& helplang=en,ja

" ---------------------------------------
"  Commands Settings:
" ---------------------------------------
"{{{
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
      \ | diffthis | wincmd p | diffthis

command! W bufdo w
command! WQ bufdo wq

command! MOJI %s/./&/g
"}}}

" ---------------------------------------
"  IME Settings:
" ---------------------------------------
"{{{
augroup initvim

  if executable('osascript')
    let s:keycode_jis_eisuu = 102
    let g:force_alphanumeric_input_command = "osascript -e 'tell application \"System Events\" to key code " . s:keycode_jis_eisuu . "' &"
    let s:keycode_jis_kana  = 104
    let g:force_kana_input_command         = "osascript -e 'tell application \"System Events\" to key code " . s:keycode_jis_kana  . "' &"
    let g:current_input_method = 102

    " control を押した状態で insert を抜けると，抜けた後にスペースが挿入される。
    " input source が切り替わった瞬間に押しっぱなしになってるキーがもう一度押された判定になるからの模様。
    " さらにスニペット絡みは展開もジャンプも内部的にインサートを抜けるので，同じく発火されるし挿入される。
    " そもそもラグが辛すぎる！ CTRL-o とかのレスポンスが悪すぎて，論外。
  endif

  autocmd InsertEnter *
        \ hi FoldColumn ctermbg=16 |
        \ if g:current_input_method == s:keycode_jis_kana |
        \   call system(g:force_kana_input_command) |
        \ endif

  inoremap <silent>っj <ESC>:let current_input_method = 104<CR>:hi FoldColumn ctermbg=black<CR>
  imap     <silent> jj <ESC>:let current_input_method = 102<CR>:hi FoldColumn ctermbg=16<CR>

  " todo: 変更が不必要な時は変更しない
  " 重さについて
  "   英数モードに変えるときは一切問題なし（割り込まれても大丈夫みたい）
  "   :hi :let も結構ラグがある
  "
  noremap  çlang1 <Nop>
  noremap! çlang1 <Nop>
  noremap  çlang2 <Nop>
  noremap! çlang2 <Nop>
  nnoremap <silent> çlang1 :
        \:call system(g:force_alphanumeric_input_command)<CR>
        \:let current_input_method = 104<CR>
        \:hi FoldColumn ctermbg=black<CR>
  nnoremap <silent> çlang2 :
        \:let current_input_method = 102<CR>
        \:hi FoldColumn ctermbg=16<CR>
  " inoremap <silent> çlang1
        "\ <C-o>
        "\:if current_input_method==102<CR>
        "\  :let current_input_method = 104<CR>
        "\  :hi FoldColumn ctermbg=black<CR>
        "\:endif<CR>
  " inoremap <silent> çlang2
        "\ <C-o>
        "\:if current_input_method==104<CR>
        "\  :let current_input_method = 102<CR>
        "\  :hi FoldColumn ctermbg=16<CR>
        "\:endif<CR>



augroup END
"}}}

" init.vim を保存したときにリロード
autocmd initvim BufWritePost $XDG_CONFIG_HOME/nvim/init.vim so $XDG_CONFIG_HOME/nvim/init.vim



" ---------------------------------------
"  Comands:
" ---------------------------------------
"{{{


"}}}

" ---------------------------------------
"  Dein Scripts:
" ---------------------------------------
"{{{
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$XDG_CACHE_HOME/dein')
  call dein#begin('$XDG_CACHE_HOME/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim')

  " core plugin
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/unite.vim')
  " call dein#add('poppyschmo/deoplete-latex')
  " call dein#add('Shougo/neco-syntax')
  " call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/defx.nvim')
  call dein#add('Shougo/deol.nvim')

  call dein#add('osyo-manga/vim-anzu')

  call dein#add('jonathanfilip/vim-lucius')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('ujihisa/unite-colorscheme')
  call dein#add('KeitaNakamura/tex-conceal.vim')
  call dein#add('kakkyz81/evervim')
  call dein#add('tpope/vim-surround')
  call dein#add('tyru/caw.vim')
  call dein#add('powerline/fonts')
  call dein#add('Lokaltog/vim-powerline')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('powerline/fonts')
  call dein#add('vim-jp/vimdoc-ja')
  " call dein#add('thinca/vim-ft-help_fold')
  call dein#add('tpope/vim-fugitive')
  call dein#add('LeafCage/foldCC.vim')

  call dein#add('lervag/vimtex')
  " カッコ補完プラグイン
  call dein#add('cohama/lexima.vim')

  " Required :
  call dein#end()
  call dein#save_state()
endif

" Required :
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()

endif
"}}}

" ---------------------------------------
"  Appearance:
" ---------------------------------------
"{{{
" Color Scheme: -----------------------
set runtimepath+=$XDG_CONFIG_HOME/nvim/runtime/

" :Unite -auto-preview colorscheme
" で一覧を表示する

colorscheme my_default
" colorscheme molokai
" colorscheme chocolatepapaya
" colorscheme anotherdark
" colorscheme bubblegum
" colorscheme buddy
" colorscheme emacs
" colorscheme elflord
" colorscheme desert
" colorscheme hybrid_reverse
" colorscheme hybrid

" set background=dark


hi Visual ctermbg = 6

highlight conceal ctermfg=7 ctermbg=black guibg=darkgray
"{{{
"}}}
hi Folded     term=standout ctermbg=17 ctermfg=white
hi FoldColumn term=standout ctermbg=16 ctermfg=2
" 欲を言うなら，fold しても1行目の構文ハイライトは維持したい。


" https://h2plus.biz/hiromitsu/entry/674
" カラースキームをまとめたサイト

hi MatchParen ctermbg=240

hi spellbad NONE
hi SpellCap NONE
hi SpellRare NONE
hi SpellLocal NONE

set cursorline
hi clear CursorLine
hi CursorColumn ctermbg=0
hi CursorLineNr term=bold   cterm=NONE ctermfg=215 ctermbg=NONE

" "todo なぜか更新しないと反映されない
" autocmd initvim BufRead,BufNewfile *
syntax match fmrkr '{{{\|}}}'
      \ containedin=vimLineComment contained |
      \ hi fmrkr term=NONE
      \ ctermbg=NONE ctermfg=black


" let g:airline_theme = 'tomorrow'
" let g:airline_theme = 'bubblegum'
" let g:airline_theme = 'papercolor'
let g:airline_theme = 'luna'

" airline : statusline ------------- {{{
" todo:lightline に乗り換える？
"      ついでに Ricty-powerline をちゃんと設定する
"      さらに buffer でなく，タブを主に使う
"       タブはペインより上で分けてくれるから，iterm と一貫性があってえらい．
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z', 'error', 'warning' ]
      \ ]
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

let g:airline_section_a = airline#section#create(['mode', 'crypt'])
let g:airline_section_b = airline#section#create(['hunks', 'branch'])
let g:airline_section_c = airline#section#create(['filename'])
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#readonly#enabled = 0
let g:airline_section_b =
      \ '%{airline#extensions#branch#get_head()}' .
      \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
      \ '%t%( %M%)'
let g:airline#extensions#branch#empty_message = 'not staged'
let g:airline_section_c = ''


let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif


" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''


" function! MyPlugin(...)
"   let w:airline_section_a = '%l'
"   let w:airline_section_b = '%f'
"   let w:airline_section_y = 'hoge'
"   let g:airline_variable_referenced_in_statusline = 'foo'
" endfunction
" " autocmd initvim CursorMoved * call airline#add_statusline_func('MyPlugin')
" " call airline#add_statusline_func('MyPlugin')





" let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#ale#error_symbol = 'E:'
" let g:airline#extensions#ale#warning_symbol = 'W:'
" let g:airline#extensions#ale#show_line_numbers = 1
" let g:airline#extensions#ale#open_lnum_symbol = '(L'
" let g:airline#extensions#ale#close_lnum_symbol = ')'
" let g:airline#extensions#branch#custom_head = 'gina#component#repo#branch'
" let g:airline#extensions#hunks#enabled = 0
" let g:airline#extensions#quickfix#location_text = 'Location'
" let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#buffers_label = 'b'
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#exclude_preview = 1
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#show_buffers = 0
" let g:airline#extensions#tabline#show_splits = 1
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#show_tab_type = 1
" let g:airline#extensions#tabline#show_tabs = 1
" let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
" let g:airline#extensions#tabline#tab_nr_type = 2
" let g:airline#extensions#tabline#tabs_label = 't'
" let g:airline#extensions#tagbar#enabled = 0
" let g:airline#extensions#languageclient#enabled = 1
" let g:airline#extensions#whitespace#mixed_indent_algo = 2
" let g:airline#extensions#wordcount#enabled = 0
" let g:airline_exclude_filetypes = ['fzf']
" let g:airline_highlighting_cache = 1
" let g:airline_inactive_collapse = 0
" let g:airline_skip_empty_sections = 1
" let g:airline_theme = 'hybridline'
" if dein#source('vim-airline')
"   let g:airline_section_c = airline#section#create(['%<', 'readonly', 'path'])
" endif
" Ref: https://github.com/zchee/.nvim/blob/master/init.vim
" }}}

" --- Conceal: --------------------{{{
let conceallevel=0
set conceallevel=0
set concealcursor=""
"}}}
"}}}

" ---------------------------------------
"  Key Map:
" ---------------------------------------
"{{{
"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"---------------------------------------------------------------------------"

map  ─Control-h <C-h>
map! ─Control-h <C-h>
let maplocalleader = "\<Space>"

" ---------------------------------------
"  key map (n):
" ---------------------------------------
"{{{
" simple mapping -------------------
" :と;の入れ替え、Karabinar からやったのでクビ
" それどころかキーボードも物理的に入れ替えちゃった
" nnoremap ; :
" nnoremap : ;
nnoremap <C-u> <C-r>
nnoremap <C-r> "
xnoremap <C-r> "
nnoremap Y y$
nnoremap j gj
nnoremap k gk
map gm %
nnoremap tcou :%s/.//gn


" spell
nnoremap <C-s> z=
nmap <silent> " <plug>(caw:hatpos:toggle)
nnoremap con J
" 行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp

"Search/substitute
" anzu search
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
" nmap n <Plug>(anzu-mode-n)
" nmap N <Plug>(anzu-mode-N)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" set statusline=%{anzu#search_status()}
" nnoremap <expr> n anzu#mode#mapexpr("n", "", "zzzv")
" nnoremap <expr> N anzu#mode#mapexpr("N", "", "zzzv")
" let g:anzu_status_format = "%#WarningMsg#%p(%i/%l)"
" nnoremap <silent>n  :keepjumps normal ─n<CR>"{{{
" nnoremap <expr>  ─n Avoid_too_recursive_n()
function! Avoid_too_recursive_n() abort"
  return "n"
endfunction
"}}}
" nnoremap <silent>N  :keepjumps normal ─N<CR>"{{{
nnoremap <expr>  ─N Avoid_too_recursive_N()
function! Avoid_too_recursive_N() abort"
  return "N"
endfunction
"}}}

nnoremap <expr> sub Move_cursor_pos_mapping(":%s/<C-r>0/<C-r>0<CURSOR>/g")
vnoremap <expr> sub Move_cursor_pos_mapping(":s/<C-r>0/<C-r>0<CURSOR>/g")


" motion ------------------------------{{{
inoremap <C-a> <C-o>^
" アンドゥを抜けないで左に動かす．
noremap! <C-b> <C-g>U<left>
noremap! <C-e> <END>
" noremap! <C-f> <C-g>U<Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
noremap! <C-t> <C-e>
noremap H _
noremap L $
nnoremap <silent> M     :keepjumps normal ─M<CR>
xnoremap <silent> M     :keepjumps normal ─M<CR>
onoremap <silent> M     :keepjumps normal ─M<CR>
noremap <expr>   ─M  Avoid_too_recursive_M()
xnoremap <expr>  M     Avoid_too_recursive_M()
function! Avoid_too_recursive_M() abort"{{{
  return "M"
endfunction"
"}}}
" 思い通りになるJK
" keepjumps をする際に，関数の中に入れることで，無限ループを回避している。
nnoremap <silent> J     :keepjumps normal ─J<CR>
xnoremap <silent> J     :keepjumps normal ─J<CR>
onoremap <silent> J     :keepjumps normal ─J<CR>
noremap <expr>   ─J  To_bottom_of_window_OR_scroll_next_page()
xnoremap <expr>  J     To_bottom_of_window_OR_scroll_next_page()
function! To_bottom_of_window_OR_scroll_next_page() abort" {{{
  if winline() > winheight(0) - 5
    return "\<C-f>L"
  else
    return "L"
  endif
endfunction" }}}
nnoremap <silent> K     :keepjumps normal ─K<CR>
xnoremap <silent> K     :keepjumps normal ─K<CR>
onoremap <silent> K     :keepjumps normal ─K<CR>
noremap <expr>   ─K  To_top_of_window_OR_scroll_previous_page()
xnoremap <expr>  K     To_top_of_window_OR_scroll_previous_page()
function! To_top_of_window_OR_scroll_previous_page() abort" {{{
  if winline() < 5
    return "\<C-b>H"
  else
    return "H"
  endif
endfunction" }}}



" cursor が移動したときとしなかったときとで，動作を変えるしくみ。
" f コマンドは見つからなかったときにエラーとして扱われるらしく，これでうまくいかない。
nnoremap ─l :
      \:let g:save_curpos = getcurpos()<CR>
      \l
      \:call Hoge(save_curpos)
function! Hoge(save_curpos) abort
  if save_curpos[1] != getcurpos()[1]
    return "^"
  else
    return ""
  endif
endfunction

nnoremap ─hoge :
      \:let save_curpos = getcurpos()<CR>
      \jjjkl
      \:if save_curpos == getcurpos()<CR>
      \:    echo "移動してない"<CR>
      \:else<CR>
      \:    echo "移動した"<CR>
      \:endif<CR>

" autocmd initvim CursorMoved * j


"}}}

" mode switch ----------------------
nnoremap <C-p> :<C-p>
" nnoremap q: :

nnoremap <silent> <ESC> :nohl<CR><ESC>
nnoremap <silent> <C-c> :nohl<CR><C-c>
nnoremap <silent> <C-{> :nohl<CR><C-{>


" http://www.ipentec.com/document/regularexpression-url-detect
" done : ディレクトリパスなら開く？ gf でできる！
noremap <expr> +  Open_reference_OR_URL()
function! Open_reference_OR_URL() abort" {{{
  if expand('<cWORD>') =~ 'https\?:\/\/'
    return ":!open ".expand('<cWORD>')."\<CR>"
  elseif expand('<cWORD>') =~ '^\(\$\?\(\w\|\ \)\+\|\~\)\?\(\/\(\.\?\(\(\w\|\ \)\+\)\)\)\+\/'
    return ":e ".expand('<cWORD>')."\<CR>"
  else
    return "K"
  endif
endfunction

" ~/.config/nvim/my_dictionary/json.dict
" ~/.config/nv im/my_dictionary/json.dict
" $XDG_CHAce/.config/nvim/my_dictionary/json.dict
" $XDG_CHAce/.config/nvim/my_dictionary/
" $XDG_CHAce/.con fig/nvim/my_dictionary/
" fig/nvim/my_dictionary/
"
" \(\$\(\w\|\ \)\+\|\~\)
" " 一つのディレクトリ名
" \(\.\?\(\(\w\|\ \)\+\)\)
"
" \(\/\(\.\?\(\(\w\|\ \)\+\)\)\)\+
" \(\$\(\w\|\ \)\+\|\~\)\(\/\(\.\?\(\(\w\|\ \)\+\)\)\)\+\/
" \/\(\.\?\(\(\w\|\ \)\+\)\)\+

" }}}

" ~/.config/nvim/my_dictionary/json.dict

let mapleader = "z"

" folding -------------------------------------------------- {{{

noremap  <silent> <Leader>w :echo FoldCCnavi()<CR>
nnoremap <silent> <Leader>f za
nnoremap <silent> <Leader>F zA
nnoremap <silent> <Leader>M zM
nnoremap <silent> <Leader>j zj
nnoremap <silent> <Leader>k zk
nnoremap <silent> <Leader>d zd
nnoremap <silent> <Leader>D zD
nnoremap <silent> <Leader>c zc
nnoremap <silent> <Leader>C zC
nnoremap <silent> <Leader>i zi
" なにかつぶした
nnoremap <silent> <Leader>h zMzv
nnoremap <silent> <Leader>a zR
nnoremap <silent> <Leader>A zM
nnoremap <silent> <Leader>j :<C-u>call <SID>smart_foldjump('j')<CR>
nnoremap <silent> <Leader>k :<C-u>call <SID>smart_foldjump('k')<CR>

function! s:smart_foldjump(direction)" {{{
  if a:direction == 'j'
    let [cross, trace, compare] = ['zj', ']z', '<']
  else
    let [cross, trace, compare] = ['zk', '[z', '>']
  endif

  let i = v:count1
  while i
    let save_lnum = line('.')
    exe 'keepj norm! '. trace
    let trace_lnum = line('.')
    exe save_lnum

    exe 'keepj norm! '. cross
    let cross_lnum = line('.')
    if cross_lnum != save_lnum && eval('cross_lnum '. compare. ' trace_lnum')
          \ || trace_lnum == save_lnum
      let i -= 1
      continue
    endif

    exe trace_lnum
    let i -= 1
  endwhile
  mark `
  norm! zz
endfunction
" }}}
" Ref: http://d.hatena.ne.jp/leafcage/20130212/1360636769

" }}}

let mapleader = "\\"
let mapleader = "s"

" about pain --------------------- {{{
" split pain horizontally/vertically
nnoremap <silent> <Leader>S :split<CR>
nnoremap <silent> <Leader>s :vsplit<CR>
nnoremap <silent> <Leader>b :5split<CR>:enew<CR>
" focus to another pane
nnoremap <Leader>j <C-w>w
" swap to another pane
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>H <C-w>H
nnoremap <Leader>L <C-w>L
" Expand/Shrink focused pane (take number)
nnoremap <Leader>> <C-w>>
nnoremap <Leader>< <C-w><
nnoremap <Leader>+ <C-w>+
nnoremap <Leader>- <C-w>-
"}}}

" about buffer (airline) ---------------------{{{
" new buffer
" nnoremap <silent> <Leader>n :tabnew<CR>
" show preious/next buffer
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>h <Plug>AirlineSelectPrevTab
nmap <leader>l <Plug>AirlineSelectNextTab
nmap <silent> <BS>        :bprevious<CR>
nmap <silent> ─Control-h :bprevious<CR>
nmap <silent> <C-l>        :bnext<CR>
nmap <silent> <leader><Space> :b<Space>
nmap <silent> <leader>q :bdelete<CR>
nmap <silent> <leader>w :w<CR>
"}}}

" interface between pain and buffer ---------------------{{{
" move current pain to new buffer
" (if current window has only one pane, split into two tabs)
nnoremap <silent> <Leader>t :<C-u>call <SID>MoveToNewBuf()<CR>
function! s:MoveToNewBuf()" {{{
  tab split
  tabprevious
  if winnr('$') > 1
    close
  elseif bufnr('$') > 1
    buffer #
  endif
  tabnext
endfunction
" }}}
"}}}

let mapleader = "\\"

nnoremap <silent> <C-f> :Defx<CR>
" nnoremap <silent> <C-f> :Defx -show-ignored-files<CR>

" defx --------{{{
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <C-f>
        \ defx#do_action('change_vim_cwd')
        \ .defx#do_action('quit')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('change_vim_cwd')
        \ .defx#do_action('open')
  nnoremap <silent><buffer><expr> O
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> l
        \ defx#do_action('open_directory')
  nnoremap <silent><buffer><expr> l
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('cd', [expand($CURRENT_DIR)])
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> S
        \ defx#do_action('toggle_sort', 'Time')

  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('toggle_columns',
        \                'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> ;
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
endfunction
"}}}

" marks ------------------------------{{{
" <C-m> と <CR> の２つはつながってる
" nnoremap <C-> '
nnoremap <CR> <CR>
"}}}

" function key
" default: map <f1> to display the help file
" map <f2> to toggle show Information
nnoremap <f2> :
      \:set cursorcolumn!<CR>
"\:let hi_cursorline=(hi_cursorline/2+1)%2*2<CR>
"\:if hi_cursorline == 0<CR>
"\:    hi Cursorline =0<CR>
"\:else<CR>
"\:    hi Cursorline =0<CR>
"\:endif<CR>
"\<CR>
" map <f4> to edit init.vim
nnoremap <f4> :<C-u>.tabedit $XDG_CONFIG_HOME/nvim/init.vim<CR>
" map <f5> to source init.vim
nnoremap <f5> :<C-u>source $XDG_CONFIG_HOME/nvim/init.vim<CR>

" map language_specific/global dictionary
nnoremap <f6>  :<C-u>.tabedit $LANG_DICTIONARY<CR>:sort u<CR>:w<CR>
vnoremap <f6>  "zy :!echo <C-r>z>> $LANG_DICTIONARY<CR><CR>
nnoremap <f18> :<C-u>.tabedit $GLOBAL_DICTIONARY<CR>:sort u<CR>:w<CR>
vnoremap <f18> "zy :!echo <C-r>z>> $GLOBAL_DICTIONARY<CR><CR>
" map language_specific/global neosnippet edit
nnoremap <f7>  :NeoSnippetEdit -horizontal<CR>
xnoremap <f7>  y :NeoSnippetEdit -horizontal<CR>Gp
nnoremap <f19> :<C-u>.tabedit $XDG_CONFIG_HOME/nvim/my_snippets/_.snip<CR>
xnoremap <f19> y :<C-u>.tabedit $XDG_CONFIG_HOME/nvim/my_snippets/_.snip<CR>Gp

" <f11> conceal syntax の呼び出し（vim）
autocmd initvim filetype tex  nnoremap <f11>
      \ :<C-u>.tabedit $XDG_CACHE_HOME/dein/repos/github.com/keitanakamura/tex-conceal.vim/after/syntax/tex.vim<CR>
" <f12> conceal のきりかえ
nnoremap <f12> :
      \:let conceallevel=(conceallevel/2+1)%2*2<CR>
      \:if conceallevel == 0<CR>
      \:    set conceallevel=0<CR>
      \:else<CR>
      \:    set conceallevel=2<CR>
      \:endif<CR>
      \<CR>

" small trick -----------------------
" delete only last char in current line
" nnoremap <expr><silent> d, Get_curpos_to_curpos()."\A<C-h><ESC>"
nnoremap <silent>d, :
      \:let save_curpos = getcurpos()<CR>
      \A<C-h><ESC>
      \:call setpos('.', save_curpos)<CR>
"}}}

" ---------------------------------------
"  key map (c):
" ---------------------------------------
"{{{
cnoremap jj <C-c>
cnoremap <C-a> <HOME>
cnoremap <C-y> <HOME>bufdo :
cnoremap <C-i> <C-l>
set wildchar=<C-l>
"}}}

" ---------------------------------------
"  key map (v):
" ---------------------------------------
"{{{
vnoremap  *  "zy/\V<C-r>z<CR>

" 複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

vnoremap cou :s/.//gn<CR>

" comment (caw)
vmap <silent> " <plug>(caw:hatpos:toggle)

" vnoremap Y :<BS><BS><BS><BS><BS>
vnoremap Y "*y

" xmap (     <plug>(neosnippet_expand_target)(<CR>
" xmap {     <plug>(neosnippet_expand_target){<CR>
" xmap [     <plug>(neosnippet_expand_target)[<CR>
" xmap <     <plug>(neosnippet_expand_target)<<CR>
" xmap "     <plug>(neosnippet_expand_target)"<CR>
" xmap '     <plug>(neosnippet_expand_target)'<CR>

"}}}

" ---------------------------------------
"  key map (i):
" ---------------------------------------
"{{{
noremap! <C-d> <Del>
" spell
inoremap <C-s> <C-x>s

imap <expr> <C-l>   (neosnippet#jumpable() ? "\<plug>(neosnippet_jump)" : pumvisible() ? deoplete#close_popup() : "\<Tab>")
inoremap <silent> <C-f> <C-r>=lexima#insmode#leave(1, '<LT>C-G>U<LT>RIGHT>')<CR>

" inoremap <C-> Match_Paren()



let paren_list = '('

function! Match_Paren() abort
  if expand('<cWORD>') =~ 'https\?:\/\/'
    return ":!open ".expand('<cWORD>')."\<CR>"
  elseif expand('<cWORD>') =~ '^\(\$\?\(\w\|\ \)\+\|\~\)\?\(\/\(\.\?\(\(\w\|\ \)\+\)\)\)\+\/'
    return ":e ".expand('<cWORD>')."\<CR>"
  else
    return "K"
  endif
endfunction


set matchpairs=(:),{:},[:],<:>



" ひとつ上の行をいただく
" i_CTRL-Y を最後までやる
" CTRL-Y の表示がこのマッピングがあるためにディレイかかっちゃって使いづらい上に，あんまり使ってないのでオフ
" imap <C-y>L  <Up><Right><ESC>y$i<Down><ESC>pa<CR><C-o>dd<left>





"}}}
"}}}

" ---------------------------------------
"  Auto Snippet:
" ---------------------------------------
"{{{
" imap å(       (a<C-h><plug>(neosnippet_expand)
" imap å{       {a<C-h><plug>(neosnippet_expand)
" imap å[       [a<C-h><plug>(neosnippet_expand)
" imap å<       <a<C-h><plug>(neosnippet_expand)
" imap å$       $a<C-h><plug>(neosnippet_expand)
"}}}

" ---------------------------------------
"  Plugin Setting:
" ---------------------------------------
"{{{
" deoplete --------------------- {{{

if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
"let g:neocomplcache_enable_auto_select = 1

call deoplete#custom#source('_', 'matchers'  ,  ['matcher_head']) "完全一致だけ
call deoplete#custom#source('_', 'sorters'   ,  ['sorter_rank'])
call deoplete#custom#source('_', 'converters',  ['converter_remove_overlap', 'converter_truncate_abbr','converter_truncate_menu', 'converter_auto_paren'])
" デフォルト設定
"call deoplete#custom#source('_', 'matchers'  , ['matcher_fuzzy'])
"call deoplete#custom#source('_', 'sorters'   ,  ['sorter_rank'])
"call deoplete#custom#source('_', 'converters',  ['converter_remove_overlap', 'converter_truncate_abbr','converter_truncate_menu'])

" 一つ前の文字が ない（カーソル位置が1） or \s(改行・タブ・半スペ) にマッチする
function! s:Check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" 選択を tab キーで行う。単語の後ろで tab キーを押すと deoplete を呼び出す（無効化）
" inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <sid>Check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
inoremap <expr> <TAB>   pumvisible() ? deoplete#complete_common_string() : "\<TAB>"
inoremap <expr> <S-TAB> deoplete#refresh().deoplete#smart_close_popup()
"}}}

" neosnippet --------------------- {{{
let g:neosnippet#snippets_directory='$XDG_CONFIG_HOME/nvim/my_snippets'

" note: it must be "imap" and "smap".  it uses <plug> mappings.
" a<C-h> の理由：
"   例えば { を使ったマッピングがある影響で { を入力すると待機モードになる。
"   待機モードで expand を呼び出しても即座に展開はされず，二度押しが必要だった。
"   他にも待機モードになるような任意の入力で即座に展開できなかった。
"   一旦適当な文字 a を打ってそれを消す操作を挟むことで，一度押しでいけるようにした。
" 内部的にインサートモードを抜けるので，InsertLeave が発火する。

" 一番上の expand できるキーワードでスニペットを展開する
imap <expr> œ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : pumvisible() ? Finite_increase_pum() : ""
" imap <expr> œ neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : pumvisible() ? Finite_increase_pum() : "œ"
function! Finite_increase_pum()"{{{
  if g:counter < 100
    let g:counter += 1
    return "\<C-n>œ"
  else
    let g:counter = 0
    return "\<S-TAB>"
  endif
endfunction
let counter = 0
"}}}
function! Finite_increase_pum_copy()"{{{
  if g:counter < 100
    let g:counter += 1
    return "\<C-n>œ"
  else
    let g:counter = 0
    return "\<S-TAB>"
  endif
endfunction
let counter = 0
"}}}

vmap œ     <plug>(neosnippet_expand_target)
" vmap œ     <plug>(neosnippet_expand_target)
imap <expr> <C-i>   deoplete#complete_common_string()
"imap <hoge>    <plug>(neosnippet_start_unite_snippet)
"}}}

" lexima ------------------------{{{
call lexima#add_rule({'char': '$',       'input_after': '$', 'filetype': 'tex'})
call lexima#add_rule({'char': '$',       'at': '\%#\$', 'leave': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<Space>', 'at': '\$\%#\$', 'input': '<Space>', 'input_after': '<Space>', 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>',    'at': '\$\%#\$', 'delete': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>',    'at': '\$ \%# \$', 'delete': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '$',    'at': '@\%#', 'input_after': '$@', 'filetype': 'tex'})


call lexima#add_rule({'char': '<', 'input': '<', 'input_after': '>'})
call lexima#add_rule({'char': '>', 'at': '\%#>', 'leave': 1})
call lexima#add_rule({'char': '<Space>', 'at': '<\%#>', 'input': '<Space>', 'input_after': '<Space>'})
call lexima#add_rule({'char': '<BS>',    'at': '<\%#>', 'delete': 1})
call lexima#add_rule({'char': '<BS>',    'at': '< \%# >', 'delete': 1})



let g:leximamap_escape = 'jj'

"}}}

" vim-surround ---------------- {{{
" }}}

" caw : commentout------------- {{{
let g:caw_no_default_keymappings = 1
" let g:caw_operator_keymappings   = 0
" }}}

" evervim --------------------- {{{
let g:evervim_devtoken='S=s1:U=950c7:E=17007f452d0:C=168b0432528:P=1cd:A=en-devtoken:V=2:H=708160efd6d58adcc078a7f8ea1c5563'
" first time settings
" :EvervimSetup
" }}}

" defx -----------------------{{{
" Like Textmate icons.
call defx#custom#column('mark', {
      \ 'directory_icon': '▸',
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ })
"}}}

" Deol -----------------------{{{
tnoremap  <CR>  <Plug>(deol_execute_line)
tnoremap  <C-p> <Plug>(deol_previous_prompt)
tnoremap  <C-n> <Plug>(deol_next_prompt)
tnoremap  <C-y> <Plug>(deol_paste_prompt)
tnoremap  <C-z> <Plug>(deol_bg)
tnoremap  e     <Plug>(deol_edit)

"}}}

"}}}

" ---------------------------------------
"  Language Specific Setting:
" ---------------------------------------
"{{{
filetype on
filetype plugin indent on

" Variables depend on language
let $LANG = "no defined"
let $LANG_COMMENT_TOKEN = "no defined"


" template
" " hogehogengo ----------------------
" autocmd BufNewFile,BufRead *.hogehogengo setfiletype hogehogengo
" autocmd initvim FileType hogehogengo
"      \ let $LANG = "hogehogengo"


" todo: 全部
" &filetype =~ 'help'
" でいい説がある

" vim --------------------------
autocmd initvim FileType vim
      \ let $LANG = "vim"

" neosnippet -------------------
autocmd initvim BufNewFile  *.snip  put='# hogehoge snippets'

" tex --------------------------
" autocmd initvim BufNewFile,BufRead *.tex set filetype=tex
autocmd initvim FileType tex
      \ | let $LANG = "tex"
      \ | set foldmethod=expr
      \ | set shiftwidth=2
      \ | set foldcolumn=5
let g:tex_conceal="adgmb"

autocmd initvim BufNewFile  *.tex  put='%! TEX root = /path/to/thesis.tex'

let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled = 1
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})
let g:vimtex_compiler_enabled = 1
let g:vimtex_compiler_progname = 'nvr'
" -pvc
let g:vimtex_compiler_latexmk = {'continuous': 1}
let g:vimtex_quickfix_open_on_warning = 1
" autocmd BufNewFile,BufRead *.tex nmap <C-c> <plug>(vimtex-compile)

let g:vimtex_latexmk_options = '-pdfdvi'
let g:vimtex_view_method = 'skim'
let g:vimtex_view_automatic = 1
" let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/MacOS/Skim'
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '@line @pdf @tex'
" 分割してるとバグる？
" let g:vimtex_quickfix_autojump = 1
let g:vimtex_quickfix_mode     = 2
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

let g:Tex_IgnoredWarnings =
      \"Underfull\n".
      \"Overfull\n".
      \"specifier changed to\n".
      \"You have requested\n".
      \"Missing number, treated as zero.\n".
      \"There were undefined references\n".
      \"Citation %.%# undefined\n".
      \"LaTeX Font Warning:"
let g:Tex_IgnoreLevel = 8


function! s:previewTex() range
  let l:tmp = @@
  silent normal gvy
  let l:selected = split(@@, "\n")
  let @@ = l:tmp

  let l:template1 = ["\\input{env.tex}",
        \"\\begin{document}"]
  let l:template2 = ["\\end{document}"]

  let l:output_file = "preview.tex"
  call writefile(extend(extend(l:template1, l:selected), template2), l:output_file)
  silent call system("latexmk preview.tex")
  silent call system("open -ga /Applications/Skim.app preview.pdf")
endfunction
autocmd initvim FileType tex
      \ | nmap <buffer> <localleader>la vae:call <SID>previewTex()<CR>
      \ | nmap <buffer> <localleader><localleader> vae:call <SID>previewTex()<CR>
      \ | vnoremap <buffer> <localleader>la :call <SID>previewTex()<CR>
      \ | nmap <buffer> <localleader>lt <plug>(vimtex-toc-toggle)sj
      \ | nmap <buffer> <localleader>lj f{yi{:e <C-r>"<CR>
" Ref: http://mmi.hatenablog.com/entry/2015/01/02/003517
" 環境単位でコンパイルできる。
" カードル移動に伴って自動的に表示するようにする？
" 表示のためのアプリやスペースの選択（amethyst は邪魔 ツールバーも邪魔）
"   最前列で内容に合わせてなるべく小さく
" キャッシュしておいて素早く表示する

" json -------------------------
autocmd initvim FileType json
      \ let $LANG = "json"
"}}}


" ---------------------------------------
"  Fired Lastly:
" ---------------------------------------
"{{{

autocmd initvim VimEnter *
      \ let $LANG_DICTIONARY = expand($XDG_CONFIG_HOME.'/nvim/my_dictionary/'.$LANG.'.dict')
autocmd initvim VimEnter *
      \ set dictionary+=$LANG_DICTIONARY

let $GLOBAL_DICTIONARY = expand($XDG_CONFIG_HOME.'/nvim/my_dictionary/_.dict')
set dictionary+=$GLOBAL_DICTIONARY



" Ref: https://vim-jp.org/vim-users-jp/2009/10/08/Hack-84.html
" Save fold settings and cursor pos.
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile'                       | mkview | endif
autocmd BufRead      * if expand('%') != '' && &buftype !~ 'nofile' && &buftype !~ 'help' | silent loadview | endif
"}}}


" ----------------------------------------------
"
" おしまい
"
"
"       "<<<" "lll"
"       " //        eee "
"       "/\ /\      /\ /\   "
"        ￣￣￣￣￣￣￣￣￣￣   >
"        ￣                     >
"
"
" ----------------------------------------------

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
"                          | |     command でコマンド追加できる？             | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
"                          | |                                                | |    |
" ----------------------------------------------------------------------------------------------------
function! Hino() abort
  echo "hino"
endfunction

augroup initvim
  autocmd!
augroup END

"--- Environment Variables: --------------------------------------------------
let $XDG_CACHE_HOME = expand($HOME.'/.cache')
let $XDG_CONFIG_HOME = expand($HOME.'/.config')
let $XDG_DATA_DIRS = expand('/usr/local/share:/usr/share')
let $XDG_DATA_HOME = expand($HOME.'/.local/share')

let $CURRENT_FILE_NAME = split(expand("%"),"/")[-1]



"--- Global Functions: -------------------
let save_curpos = getcurpos()
set nocompatible

" function! g:Get_curpos_to_curpos() abort
"   let g:curpos = getcurpos()
" endfunction

" pos は配列で，その扱いがおかしいっぽい？
function! g:Set_curpos() abort
  call setpos('.', save_curpos)
endfunction



set fenc=utf-8
set backupdir=$XDG_DATA_HOME/nvim/backup
" " CURRENT_FILE_NAME で backupをまとめようかと思ったけど，
" " ディレクトリが存在しないと保存できないのでめんどくさい。
" set backupdir=$XDG_DATA_HOME/nvim/backup/$CURRENT_FILE_NAME
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

"--- Motion ---------------------{{{
" 左右のカーソル移動で行間移動可能にする。
set whichwrap=h,l,b,s,<,>,[,]
set backspace=indent,eol,start
" マウスを使えるようにする
set mouse=a
" 行末の1文字先までカーソルを移動できるように
set virtualedit=
" 短形選択でいくらでも横に行ける
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
"
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

" --- Marks ----------------todo: {{{
" mark[0-9] をキューのように扱うものとして再構成する。
" mark 0 に追加して，mark9 は削除する。
" nnoremap mm
function! Push_queue_of_marks() abort
  echo "hoge"
endfunction
" }}}

" --- Folding -------------- {{{
set foldenable
" set foldmethod=marker
" set foldmethod=indent
" set foldmarker=\{{{,\}}}
set foldtext=Natsume_fold_text()
function! Natsume_fold_text() "{{{
  " todo: 設定し放題。コメントなら表示するけど，そうじゃないなら表示しないとか？　大きいならなにか変わったあれを用意するとか？
  "       関数定義の１行目を巻き込まないようにすれば，シンタックスハイライトも消えずにすむ。
  "       その場合は body とかにしたりね。
  if g:foldCCtext_enable_autofdc_adjuster && v:foldlevel > &fdc-1
    let &fdc = v:foldlevel + 1
  endif
  let headline =
        \ getline(v:foldstart)
        "\ getline(v:foldstart)
  let head = g:foldCCtext_head=='' ? '' : eval(g:foldCCtext_head)
  let tail = g:foldCCtext_tail=='' ? '' : ' '. eval(g:foldCCtext_tail)
  let headline = s:_adjust_headline(headline, strlen(head)+strlen(tail))
  return substitute(headline, '^\s*\ze', '\0'. head, ''). tail
endfunction
"}}}
set foldcolumn=3
set fillchars=vert:\|
let g:foldCCtext_head = ''
let g:foldCCtext_tail = 'printf(" %s[%4d lines Lv%-2d ]%s  ", v:folddashes, v:foldend-v:foldstart+1, v:foldlevel, v:folddashes)'
" foldcolumn が足りなくなった時に，自動で大きくする バグあり
" Ref: http://leafcage.hateblo.jp/entry/20111223/1324705686
" let g:foldCCtext_enable_autofdc_adjuster = 1
" Ref: https://vim-jp.org/vim-users-jp/2009/10/08/Hack-84.html
" Save fold settings.
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile'                       | mkview | endif
autocmd BufRead      * if expand('%') != '' && &buftype !~ 'nofile' && &buftype !~ 'help' | silent loadview | endif
" Don't save options.
set viewoptions-=options
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

" --- Search -------------------- {{{
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

" " 英数を切り替えるための関数を定義する
" if executable('osascript')
"   let s:keycode_jis_eisuu = 102
"   let g:force_alphanumeric_input_command = "osascript -e 'tell application \"System Events\" to key code " . s:keycode_jis_eisuu . "' &"
"   " inoremap   :call system(g:force_alphanumeric_input_command)
" endif
" Ref:


" about help ---------------------
" If true Vim master, use English help file.
set helplang& helplang=en,ja



" ---------------------------------------
"  autocmd settings
" ---------------------------------------
augroup initvim

  if executable('osascript')
    let s:keycode_jis_eisuu = 102
    let g:force_alphanumeric_input_command = "osascript -e 'tell application \"System Events\" to key code " . s:keycode_jis_eisuu . "' &"
  endif

  " インサートモードに入ったときに発火
  " autocmd InsertEnter * NoMatchParen

  " インサートモードを抜けるときに発火
  " 抜けてから入力できるまでウェイトタイムが生まれちゃうので切る。フォーカスのやつなら許容範囲だけど。。。
  " q: モードでインサートモードに入るとバグる
  " autocmd InsertLeave * DoMatchParen
  " autocmd InsertLeave * call system(g:force_alphanumeric_input_command)

  " vim をフォーカスしたときに発火
  " インサートモードなら発火しないとかも考えられる
  " autocmd FocusGained *
  "     \   call system(g:force_alphanumeric_input_command)

  " init.vim を保存したときにリロード
  autocmd BufWritePost $XDG_CONFIG_HOME/nvim/init.vim so $XDG_CONFIG_HOME/nvim/init.vim

  " 新規に .hello ファイルを作成する場合に Hello というテキストを挿入する
  autocmd BufNewFile  *.hello  put='Hello'


augroup END


" ---------------------------------------
"  Dein Scripts:
" ---------------------------------------

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

  call dein#add('jonathanfilip/vim-lucius')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('ujihisa/unite-colorscheme')
  call dein#add('KeitaNakamura/tex-conceal.vim')
  call dein#add('kakkyz81/evervim')
  call dein#add('tpope/vim-surround')
  call dein#add('tyru/caw.vim')
  call dein#add('powerline/fonts')
  " call dein#add('Lokaltog/vim-powerline')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('powerline/fonts')
  call dein#add('vim-jp/vimdoc-ja')
  " call dein#add('thinca/vim-ft-help_fold')
  call dein#add('tpope/vim-fugitive')
  call dein#add('LeafCage/foldCC.vim')

  call dein#add('lervag/vimtex')


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


" ---------------------------------------
"  Appearance:
" ---------------------------------------

" Color Scheme: -----------------------{{{
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


" highlight statusline ctermfg=248 ctermbg=23
hi Visual ctermbg = 0

" conceal        xxx ctermfg=7 ctermbg=242 guifg=lightgrey guibg=darkgrey
highlight conceal ctermfg=7 ctermbg=black guibg=darkgray
" 全角スペースの背景を白に変更
autocmd initvim colorscheme highlight fullwidthspace ctermbg=white
autocmd initvim vimenter match fullwidthspace /　/

hi Folded     term=standout ctermbg=Black ctermfg=Green
hi FoldColumn term=standout ctermbg=Black ctermfg=130
" 欲を言うなら，fold しても1行目の構文ハイライトは維持したい。


" https://h2plus.biz/hiromitsu/entry/674
" カラースキームをまとめたサイト
hi MatchParen ctermbg=240

hi spellbad NONE
hi SpellCap NONE
hi SpellRare NONE
hi SpellLocal NONE

" let g:airline_theme = 'tomorrow'
" let g:airline_theme = 'bubblegum'
" let g:airline_theme = 'papercolor'
let g:airline_theme = 'luna'
"}}}

" --- Conceal: --------------------
let conceallevel=0
set conceallevel=0
set concealcursor=""



" ---------------------------------------
"  key map
" ---------------------------------------

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

" ---------------------------------------
"  key map (n):
" ---------------------------------------

" simple mappings -------------------
" :と;の入れ替え、Karabinar からやったのでクビ
" それどころかキーボードも物理的に入れ替えちゃった
" nnoremap ; :
" nnoremap : ;
" noremap!  
" undo/redo
nnoremap <C-u> <C-r>
" yank/cut/paste
noremap <C-r>   "
noremap <C-r>'   "*
nnoremap Y y$
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" spell
nnoremap <C-s> z=
" commentout
nmap <silent> " <plug>(caw:hatpos:toggle)
nnoremap con J

" motion ------------------------------{{{
" keepjumps をする際に，関数の中に入れることで，無限ループを回避している。
nnoremap <silent>n  :keepjumps normal ___n<CR>"{{{
nnoremap <expr>  ___n Avoid_too_recursive_n()
function! Avoid_too_recursive_n() abort"
  return "n"
endfunction
"}}}
nnoremap <silent>N  :keepjumps normal ___N<CR>"{{{
nnoremap <expr>  ___N Avoid_too_recursive_N()
function! Avoid_too_recursive_N() abort"
  return "N"
endfunction
"}}}
noremap H _
noremap L $
noremap <silent>M :keepjumps normal ___M<CR>"{{{
noremap <expr>  ___M   Avoid_too_recursive_M()
function! Avoid_too_recursive_M() abort"
  return "M"
endfunction"
"}}}
" 思い通りになるJK
" default: Concat some lines
noremap <silent>J   :keepjumps normal ___J<CR>
xnoremap <expr>J        To_bottom_of_window_OR_scroll_next_page()
noremap  <expr>  ___J   To_bottom_of_window_OR_scroll_next_page()
function! To_bottom_of_window_OR_scroll_next_page() abort" {{{
  if winline() > winheight(0) - 5
    return "\<C-f>L"
  else
    return "L"
  endif
endfunction" }}}
" default: reference to help
noremap <silent>K   :keepjumps normal ___K<CR>
xnoremap <expr>K      To_top_of_window_OR_scroll_previous_page()
noremap <expr> ___K   To_top_of_window_OR_scroll_previous_page()
function! To_top_of_window_OR_scroll_previous_page() abort" {{{
  if winline() < 5
    return "\<C-b>H"
  else
    return "H"
  endif
endfunction" }}}
noremap <silent>fa fa
function! Find_for_next_line(char) abort
  let save_curpos = getcurpos()
endfunction
" cursor が移動したときとしなかったときとで，動作を変えるしくみ。
" f コマンドは見つからなかったときにエラーとして扱われるらしく，これでうまくいかない。
nnoremap ___l :
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

nnoremap ___hoge :
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
" default: same as [gQ] (switch to ex mode)
nnoremap Q kA

" default: same as [k]
nnoremap <C-p> q:k
nnoremap q: :

nnoremap <silent> <ESC> :nohl<CR><ESC>
nnoremap <silent> <C-c> :nohl<CR><ESC>


" http://www.ipentec.com/document/regularexpression-url-detect

noremap <expr> +  Open_reference_OR_URL()

function! Open_reference_OR_URL() abort" {{{
  if expand('<cWORD>') =~ 'https\?:\/\/'
    return ":!open ".expand('<cWORD>')."\<CR>"
  else
    return "K"
  endif
endfunction
" }}}

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

" about tab/pain --------------------- {{{
" split pain horizontally/vertically
nnoremap <silent> <Leader>S :split<CR>
nnoremap <silent> <Leader>s :vsplit<CR>
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
" new tab
nnoremap <silent> <Leader>n :tabnew<CR>
" show preious/next tab
nnoremap <Leader>h gT
nnoremap <Leader>l gt
" move current pain to new tab
" (if current window has only one pane, split into two tabs)
nnoremap <silent> <Leader>t :<C-u>call <SID>MoveToNewTab()<CR>
function! s:MoveToNewTab()" {{{
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
" }}}

" surround ---------------------------{{{
nmap <Leader>d  ds
nmap <Leader>c  cs
vmap <Leader>   S
"}}}

let mapleader = "\\"

" marks ------------------------------{{{
" <C-m> と <CR> の２つはつながってる
" nnoremap <C-m> '
nnoremap <CR> <CR>
"}}}

" function key
" default: map <f1> to display the help file
" map <f2> to toggle show Information
nnoremap <f2> :
      \:set cursorline!<CR>
      \:set cursorcolumn!<CR>
" map <f4> to edit init.vim
nnoremap <f4> :<C-u>.tabedit $XDG_CONFIG_HOME/nvim/init.vim<CR>
" map <f5> to source init.vim
nnoremap <f5> :<C-u>source $XDG_CONFIG_HOME/nvim/init.vim<CR>
" map <f6> to global neosnippetedit
nnoremap <f6> :<C-u>.tabedit $XDG_CONFIG_HOME/nvim/my_snippets/_.snip<CR>
" map <f7> to language specific neosnippetedit
nnoremap <f7> :NeoSnippetEdit -horizontal<CR>
" <f8> dictionary の呼び出し
nnoremap <f8> :<C-u>.tabedit $LANG_DICTIONARY<CR>:sort u<CR>
" autocmd initvim filetype dict  nnoremap <f8> :q<CR>
" v mode <f8> 選択範囲を dictionary に送る
vnoremap <f8> y :!echo <C-r>">> $LANG_DICTIONARY<CR><CR>
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


" ---------------------------------------
"  key map (v):
" ---------------------------------------

" comment (caw)
vmap <silent> " <plug>(caw:hatpos:toggle)


" ---------------------------------------
"  key map (i):
" ---------------------------------------

imap <silent> jj  <ESC>
imap <silent> っj <ESC>
inoremap <C-d> <Right><C-h>
" spell
inoremap <C-s> <C-x>s
" yank/cut/paste
inoremap <C-r>'   <C-r>*
" inoremap <C-r><C-r>  <C-r>*

" ひとつ上の行をいただく
" i_CTRL-Y を最後までやる
imap <C-y>L  <Up><Right><ESC>y$i<Down><ESC>pa<CR><C-o>dd<left>


" かっこ補完
imap (       (a<C-h><plug>(neosnippet_expand)
imap {       {a<C-h><plug>(neosnippet_expand)
imap [       [a<C-h><plug>(neosnippet_expand)
imap <       <a<C-h><plug>(neosnippet_expand)
inoremap () ()
inoremap {} {}
inoremap [] []
inoremap <> <>
imap (jj (jj
imap {jj {jj
imap [jj [jj
imap <jj <jj
inoremap (<CR> ()<ESC>i<CR><Esc><S-o>
inoremap {<CR> {}<ESC>i<CR><Esc><S-o>
inoremap [<CR> []<ESC>i<CR><Esc><S-o>
inoremap <<CR> <><ESC>i<CR><Esc><S-o>

" imap     <silent><expr> <C-l>   pumvisible() ? deoplete#close_popup()."\<C-l>" : "\<plug>(neosnippet_jump)"



" ---------------------------------------
"  plugin setting:
" ---------------------------------------

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
"inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <sid>Check_back_space() ? "\<TAB>" : deoplete#mappings#manual_complete()
inoremap <silent><expr> <TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
imap     <silent><expr> <C-l>   pumvisible() ? deoplete#close_popup()."\<C-l>" : "\<plug>(neosnippet_jump)"
inoremap <silent><expr> <Up>    pumvisible() ? deoplete#close_popup()."\<Up>" : "\<Up>"
inoremap <silent><expr> <Down>  pumvisible() ? deoplete#close_popup()."\<Down>" : "\<Down>"
" inoremap <expr><hoge> deoplete#complete_common_string()

"tab tab キーでトップヒットを選択する
"inoremap <silent><expr><TAB>    pumvisible() ? "\<C-n>".deoplete#mappings#close_popup() : "\<TAB>"
" 開いてるときにリターンすると確定 バグあり
"inoremap <silent><expr> <ENTER>
"      \ pumvisible() ? "\a<BS>".deoplete#mappings#manual_complete() :
"      \ <sid>Check_back_space() ? "\<ENTER>" :
"      \ "\<ENTER>"
" }}}

" neosnippet --------------------- {{{
let g:neosnippet#snippets_directory='$XDG_CONFIG_HOME/nvim/my_snippets'

" note: it must be "imap" and "smap".  it uses <plug> mappings.
" a<C-h> の理由：
"   例えば { を使ったマッピングがある影響で { を入力すると待機モードになる。
"   待機モードで expand を呼び出しても即座に展開はされず，二度押しが必要だった。
"   他にも待機モードになるような任意の入力で即座に展開できなかった。
"   一旦適当な文字 a を打ってそれを消す操作を挟むことで，一度押しでいけるようにした。
imap <C-k>     a<C-h><plug>(neosnippet_expand)
smap <C-k>     a<C-h><plug>(neosnippet_expand)
" deoplete setting -> imap <silent><expr> <C-l>   pumvisible() ? deoplete#close_popup()."\<C-l>" : "\<plug>(neosnippet_jump)"
smap <C-l>     <plug>(neosnippet_jump)
xmap <C-k>     <plug>(neosnippet_expand_target)
"imap <hoge>    <plug>(neosnippet_start_unite_snippet)
" }}}

" vim-surround ---------------- {{{

" }}}

" caw : commentout------------- {{{
let g:caw_no_default_keymappings = 1
" }}}

" airline : statusline ------------- todo:lightline に乗り換える？ {{{
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
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 1
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

" evervim --------------------- {{{

"S=s1:U=950c7:E=16ed29afffd:C=1677ae9d0f8:P=1cd:A=en-devtoken:V=2:H=5eb05138265db2c1bf56b1b5fea42e0b
" first time settings
" :EvervimSetup
" }}}


" ---------------------------------------
"  Language Specific Setting:
" ---------------------------------------
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

" tex --------------------------
autocmd initvim FileType tex
      \ let $LANG = "tex"
let g:tex_conceal="adgmb"

autocmd initvim BufNewFile  *.tex  put='%! TEX root = /path/to/thesis.tex'

let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled = 1
call deoplete#custom#var('omni', 'input_patterns', {
     \ 'tex': g:vimtex#re#deoplete
     \})
let g:vimtex_compiler_enabled = 1
let g:vimtex_compiler_progname = '/usr/local/bin/nvim'
" -pvc
let g:vimtex_compiler_latexmk = {'continuous': 1}
let g:vimtex_quickfix_open_on_warning = 1
" autocmd BufNewFile,BufRead *.tex nmap <C-c> <plug>(vimtex-compile)

let g:vimtex_latexmk_options = '-pdfdvi'
let g:vimtex_view_method = 'general'
let g:vimtex_view_automatic = 1
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/MacOS/Skim'
" 分割してるとバグる？
" let g:vimtex_quickfix_autojump = 1
let g:vimtex_quickfix_mode     = 2
let g:vimtex_quickfix_autoclose_after_keystrokes = 1



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
           \ | vnoremap <buffer> <localleader>la :call <SID>previewTex()<CR>
           \ | nmap <buffer> <Space><Space> <localleader>la
" Ref: http://mmi.hatenablog.com/entry/2015/01/02/003517
" 環境単位でコンパイルできる。
" カードル移動に伴って自動的に表示するようにする？
" 表示のためのアプリやスペースの選択（amethyst は邪魔 ツールバーも邪魔）
"   最前列で内容に合わせてなるべく小さく
" キャッシュしておいて素早く表示する



" json -------------------------
autocmd initvim FileType json
      \ let $LANG = "json"



" ---------------------------------------
"  Fired Lastly:
" ---------------------------------------

autocmd initvim VimEnter *
      \ let $LANG_DICTIONARY = expand($XDG_CONFIG_HOME.'/nvim/my_dictionary/'.$LANG.'.dict')
autocmd initvim VimEnter *
      \ set dictionary=$LANG_DICTIONARY




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
" これでヒノアラシつくりたい。
" 火は " /\ " で囲って赤くする！
" そうする関係上，デザインは慎重に選ぶ。
"
" ----------------------------------------------

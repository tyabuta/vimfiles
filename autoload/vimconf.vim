" vim:foldmethod=marker

if 0 != get(g:, 'loaded_vimconf', 0)
  finish
endif
let g:loaded_vimconf = 1

function! vimconf#rc()
endfunction


" -----------------------------------------------
" 文字コードの設定
" -----------------------------------------------
" {{{
set encoding    =utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileformat  =unix

set fileencodings =utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp,ucs-21e,ucs-2
set fileformats   =unix,dos,mac

" 全角記号の表示調整
set ambiwidth=double

" }}}

" -----------------------------------------------
" 表示関連
" -----------------------------------------------
" {{{


" タイトルをウィンドウ枠に表示する。
set title

" 行数を表示する。
set number

" ルーラーを表示する。
set ruler

" シンタックスハイライトを有効にする。
syntax on

" カラースキームを設定する。
colorscheme ron

" 検索結果のハイライト(設定しない場合はデフォルトでNo)
set hlsearch
"set nohlsearch

"検索をファイルの先頭へループする
set wrapscan

" 入力中のコマンドを表示する
set showcmd

" 全角スペースに色をつける。
highlight ZenkakuSpace  guibg=gray ctermbg=gray
match ZenkakuSpace /　/

" カーソル形状
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Insertモード時に水平ラインを表示する
set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!


" macvim用の設定
if has('gui_macvim')
    " 透過率の設定
    set transparency=30
endif

set shortmess+=I

" スクロール遅延の軽減
set lazyredraw
set ttyfast

" マーカーでの折りたたみ
set foldmethod=marker

" }}}

" -----------------------------------------------
" インデント関連
" -----------------------------------------------
" {{{

" 自動的にインデントする。
set autoindent

" タブを空白に展開する。
set expandtab


" タブ幅を設定。
let &g:tabstop = macro#getTabSize()
let &l:tabstop = macro#getTabSize()
let &g:softtabstop = macro#getTabSize()
let &l:softtabstop = macro#getTabSize()

" インデント数を設定。
let &g:shiftwidth = macro#getTabSize()
let &l:shiftwidth = macro#getTabSize()


" }}}

" -----------------------------------------------
" その他
" -----------------------------------------------
" {{{

" カーソルを行頭・行末で止まらないようにする。
set whichwrap=b,s,h,l,<,>,[,]

" バックスペースで削除できるようにする。
set backspace=indent,eol,start

" マウスモードを有効にする
set mouse=a

" 保存しなくてもバッファ切り替えが出来る
set hidden


" 書き込み可能なディレクトリなら、
" スワップファイルを下記ディレクトリに作成する
let s:backup_dir = expand('~/dotfiles/vim/backup')
if 2 == filewritable(s:backup_dir)
  let &g:directory = s:backup_dir " スワップファイルの場所
  let &g:backupdir = s:backup_dir " バックアップファイルの場所
endif
unlet s:backup_dir


" TOhtmlコマンドで行番号を出力しない
let html_number_lines=0

" クリップボード共有(guiでないと意味がない)
set clipboard=unnamed,autoselect

" 外部からファイル更新された場合、自動でリロードする。
set autoread

" ビープオンをフラッシュ表示に切り替え
if has('gui_macvim')
    set visualbell
endif

" }}}

" -----------------------------------------------
" キーバインド
" -----------------------------------------------
" {{{


" exモード抑制
nnoremap Q <Nop>

" Shiftを押しながら移動キーで、画面スクロール。
nnoremap <S-j> <C-f>
nnoremap <S-k> <C-b>

" Shiftを押しながら移動キーで、行頭、行末移動。
nnoremap <S-h> ^
nnoremap <S-l> $


" Ctrl-s で保存
nnoremap <silent> <C-s> :w<CR>

" タブで画面移動
"nnoremap <Tab> <C-w>p

" vim スクリプトの読み込み(カレントバッファ)
nnoremap <F5> :call macro#Run()<CR>

" ビルドコマンドまたは、シンタックスチェック。
nnoremap <F7> :call macro#Build()<CR>

" .vimrcの再読み込み
nnoremap <F8> :source ~/.vimrc<CR>

" .vimrcファイルを開く
nnoremap <F9> :e ~/.vimrc<CR>

" 一行上をコピーして貼り付け
"nnoremap <C-d> kyyp

" バッファDelete
nnoremap <silent> <C-d> :bdelete<CR>

" 0レジスタを貼付ける。(0レジスタにはヤンクされたものだけが入る。)
nnoremap <C-p> "0p

" 数字の加算
nnoremap <C-z> <C-a>


" 日付の挿入
nnoremap <silent> <C-c>d :call macro#DateInsert()<CR>

" 検索結果のハイライトを解除
nnoremap <silent> <C-c>h :nohlsearch<CR>

" コメントライン書き込み(Shif-l強調版)
nnoremap <silent> <C-c>l
\ :call macro#CommentOutputLineWithFileType(macro#FileType(), 0)<CR>
nnoremap <silent> <C-c><S-l>
\ :call macro#CommentOutputLineWithFileType(macro#FileType(), 1)<CR>


" Shift-mでコマンドメニュー
"nnoremap <silent> <S-m> :call CommandMenu#Show()<CR>

" Shift-bでバッファ操作
nnoremap <silent> <S-b> :call macro#BufferControl()<CR>

" 全体選択
nnoremap [prefix]a ggVG


" 置換コマンドの補完
nnoremap [prefix]r :%s///gc<Left><Left><Left>
vnoremap [prefix]r :s///gc<Left><Left><Left>

" カーソル行のコマンドを外部コマンド実行する。
nnoremap <silent> [prefix]q ^y$:!<C-r>"<CR>
nnoremap <silent> [prefix]Q ^y$:r!<C-r>"<CR>


" Esc
inoremap <C-f> <Esc>

" インサートモードのカーソル移動
" j,kはメニュー展開時は<C-n>,<C-p>に展開する
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" }}}

" -----------------------------------------------
" オートコマンド
" -----------------------------------------------
" {{{


augroup vimrc-my-group
    autocmd!

    if !has('gui_running')
        " vim終了時にターミナルをクリアする
        autocmd VimLeave * :!clear
    endif

    " .mdをmarkdownファイルと認識させる
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

" }}}

" -----------------------------------------------
" Command
" -----------------------------------------------
" {{{


" カレントファイルをコマンド実行する。
command! Run :!./%

" FileEncodeをUTF-8に設定する。
command! UTF8 set fenc=utf8

"現バッファの差分表示。
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif


" }}}

" -----------------------------------------------
" Make
" -----------------------------------------------
" {{{


autocmd filetype php :set makeprg=php\ -ln\ %
autocmd filetype sh  :set makeprg=sh\ -n\ %
autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l


" }}}




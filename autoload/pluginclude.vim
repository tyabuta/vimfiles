if 0 != get(g:, 'loaded_pluginclude', 0) " {{{
  finish
endif
let g:loaded_pluginclude = 1

" }}}


function! pluginclude#rc()
endfunction


NeoBundleFetch 'Shougo/neobundle.vim'

if has('unix')
    NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'cygwin'  : 'make -f make_cygwin.mak',
        \     'mac'     : 'make -f make_mac.mak',
        \     'linux'   : 'make',
        \     'unix'    : 'gmake',
        \    },
        \ }
endif

" Cygwin環境でファイルを開くときに遅くなるので一旦読み込まないように対応
if !has('win32unix')
    NeoBundle 'thinca/vim-localrc'      " ローカル設定
endif


NeoBundle 'vim-jp/vimdoc-ja'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimfiler.vim'

NeoBundle 'Shougo/vimshell.vim'

" GOPATHを設定して、:GoInstallBinaries を叩く必要がある。
NeoBundle 'fatih/vim-go'

NeoBundle 'tyabuta/sline-style.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'

NeoBundle 'tyabuta/inline-syntax.vim'
"NeoBundle 'tyabuta/sweep-trail.vim'
NeoBundle 'tyabuta/switch-toggler.vim'

NeoBundle 'LeafCage/foldCC'         " foldスタイルの変更
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'simeji/winresizer'

NeoBundle 'kana/vim-smartinput'     " 括弧入力の補完
NeoBundle 'scrooloose/syntastic'    " 保存時の自動シンタックスチェック
NeoBundle 'thinca/vim-visualstar'   " *検索の拡張
NeoBundle 'tmhedberg/matchit'       " %の拡張
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/caw.vim'            " コメントアウト機能
NeoBundle 'MattesGroeger/vim-bookmarks'


NeoBundle 'cespare/vim-toml'


" vim-textobj-user {{{

" if{c} af{c}
NeoBundleLazy 'thinca/vim-textobj-between', {
            \ 'depends'  : ['kana/vim-textobj-user'],
            \ 'autoload' : {'mappings':['<Plug>(textobj-between-']}
            \ }

" i, a,
NeoBundleLazy 'sgur/vim-textobj-parameter', {
            \ 'depends'  : ['kana/vim-textobj-user'],
            \ 'autoload' : {'mappings':['<Plug>(textobj-parameter-']}
            \ }

" iS aS
NeoBundleLazy 'saihoooooooo/vim-textobj-space', {
            \ 'depends'  : ['kana/vim-textobj-user'],
            \ 'autoload' : {'mappings':['<Plug>(textobj-space-']}
            \ }

" ic ac
NeoBundleLazy 'thinca/vim-textobj-comment', {
            \ 'depends'  : ['kana/vim-textobj-user'],
            \ 'autoload' : {'mappings':['<Plug>(textobj-comment-']}
            \ }

" il al
NeoBundleLazy 'kana/vim-textobj-line', {
            \ 'depends'  : ['kana/vim-textobj-user'],
            \ 'autoload' : {'mappings':['<Plug>(textobj-line-']}
            \ }

" }}}

" vim-operator-user {{{

" http://kazuph.hateblo.jp/entry/2013/01/04/005030
NeoBundleLazy 'kana/vim-operator-replace', {
            \ 'depends'  : ['kana/vim-operator-user'],
            \ 'autoload' : {'mappings':['<Plug>(operator-replace)']}
            \ }

NeoBundleLazy 'emonkak/vim-operator-comment', {
            \ 'depends'  : ['kana/vim-operator-user'],
            \ 'autoload' : {'mappings':['<Plug>(operator-comment)','<Plug>(operator-uncomment)']}
            \ }

" NeoBundle 'kana/vim-operator-user'
" NeoBundle 'rhysd/vim-operator-surround'

" NeoBundleLazy 'rhysd/vim-operator-surround', {
"             \ 'depends'  : ['kana/vim-operator-user'],
"             \ 'autoload' : {'mappings':['<Plug>(operator-surround-']}
"             \ }

" }}}

" unite-source {{{

NeoBundleLazy 'Shougo/unite-outline',      { 'depends': ['Shougo/unite.vim'] }
NeoBundleLazy 'zhaocai/unite-scriptnames', { 'depends': ['Shougo/unite.vim'] }
NeoBundleLazy 'osyo-manga/unite-quickfix', { 'depends': ['Shougo/unite.vim'] }

" }}}

" 文書整形
NeoBundleLazy 'junegunn/vim-easy-align', {
            \ 'autoload': {'mappings':['<Plug>(EasyAlign)']}
            \ }

" quickrun
NeoBundleLazy 'thinca/vim-quickrun', {
            \ 'autoload': {'commands':['QuickRun']}
            \ }

" capture
NeoBundleLazy 'tyru/capture.vim', {
            \ 'autoload': {'commands':['Capture']}
            \ }

" memolist
NeoBundleLazy 'glidenote/memolist.vim', {
            \ 'autoload':{'commands':['MemoList','MemoNew','MemoGrep']}
            \ }

" ブラウザ起動
NeoBundleLazy 'tyru/open-browser.vim', {
            \ 'autoload':{'commands':['OpenBrowser'],'mappings':['<Plug>(openbrowser-']}
            \ }

" markdownプレビュー
NeoBundleLazy 'kannokanno/previm', {
            \ 'depends':  ['tyru/open-browser.vim'],
            \ 'autoload': {'commands':['PrevimOpen']}
            \ }

" PrettyPrint
NeoBundleLazy 'thinca/vim-prettyprint', {
            \ 'autoload':{'commands': ['PrettyPrint', 'PP'], 'functions': ['PrettyPrint', 'PP']}}

" Qiita編集
NeoBundleLazy 'mattn/qiita-vim', {
            \ 'depends':  ['mattn/webapi-vim'],
            \ 'autoload': {'commands':['Qiita','CtrlPQiita']}
            \ }



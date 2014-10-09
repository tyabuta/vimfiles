if 0 != get(g:, 'loaded_pluginclude', 0) " {{{
  finish
endif
let g:loaded_pluginclude = 1

" }}}


function! pluginclude#rc()
endfunction


NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimfiler.vim'

NeoBundle 'tyabuta/sline-style.vim'
NeoBundle 'tyabuta/inline-syntax.vim'
NeoBundle 'tyabuta/sweep-trail.vim'
NeoBundle 'tyabuta/switch-toggler.vim'

NeoBundle 'LeafCage/foldCC'         " foldスタイルの変更
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'embear/vim-localvimrc'   " ローカル設定
NeoBundle 'junegunn/vim-easy-align' " 文書整形
NeoBundle 'kana/vim-smartinput'     " 括弧入力の補完
NeoBundle 'scrooloose/syntastic'    " 保存時の自動シンタックスチェック
NeoBundle 'thinca/vim-visualstar'   " *検索の拡張
NeoBundle 'tmhedberg/matchit'       " %の拡張
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/caw.vim'            " コメントアウト機能

" NeoBundle 'plasticboy/vim-markdown'


" unite-source
NeoBundleLazy 'Shougo/unite-outline',      { 'depends': ['Shougo/unite.vim'] }
NeoBundleLazy 'zhaocai/unite-scriptnames', { 'depends': ['Shougo/unite.vim'] }
NeoBundleLazy 'osyo-manga/unite-quickfix', { 'depends': ['Shougo/unite.vim'] }

" quickrun
NeoBundleLazy 'thinca/vim-quickrun', {
            \ 'autoload': {'commands':['QuickRun']}
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



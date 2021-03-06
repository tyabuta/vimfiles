scriptencoding utf-8

" vi互換モードを解除
set nocompatible

if 0 == isdirectory($VIMRUNTIME)
    echo "Not found runtime directory: " . $VIMRUNTIME
endif


" neobundleをランタイムPATHに挿入
if has('vim_starting')
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

" bundleディレクトリの登録
call neobundle#begin(expand('~/vimfiles/bundle/'))

" 追加プラグイン
" autoload/pluginclude.vim
call pluginclude#rc()

call neobundle#end()
filetype plugin indent on
NeoBundleCheck


" プラグインの設定
" autoload/plugconf.vim
call plugconf#rc()

" vimの設定
" autoload/vimconf.vim
call vimconf#rc()


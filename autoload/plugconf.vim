" vim:foldmethod=marker

if 0 != get(g:, 'loaded_plugconf', 0)
  finish
endif
let g:loaded_plugconf = 1

function! plugconf#rc()
endfunction


" prefix-key for Keymapping
nnoremap [prefix] <Nop>
nmap <space> [prefix]
vmap <space> [prefix]


" -------------------------------------------------------------------
" Unite
" -------------------------------------------------------------------
"{{{

" unite検索で大文字小文字を無視する
call unite#set_profile('default', 'context', {'ignorecase':1})

" Unite bookmark でディレクトリをVimFilerExplorerで開く
let s:action = { 'description' : 'open vimfiler-explorer buffer here' }
function! s:check_is_directory(directory) " {{{
  if !isdirectory(a:directory)
    if unite#util#is_sudo()
      return 0
    endif

    let yesno = input(printf(
          \ 'Directory path "%s" does not exist. Create? : ', a:directory))
    redraw
    if yesno !~ '^y\%[es]$'
      echo 'Canceled.'
      return 0
    endif

    call mkdir(a:directory, 'p')
  endif

  return 1
endfunction
"}}}
function! s:move_vimfiler_cursor(candidate) "{{{
  if &filetype !=# 'vimfiler'
    return
  endif

  if has_key(a:candidate, 'action__path')
        \ && a:candidate.action__path !=#
        \     unite#helper#get_candidate_directory(a:candidate)
    " Move cursor.
    call vimfiler#mappings#search_cursor(a:candidate.action__path)
  endif
endfunction"}}}
function! s:action.func(candidate) " {{{
  if !exists(':VimFilerExplorer')
    echo 'vimfiler is not installed.'
    return
  endif

  let directory = unite#helper#get_candidate_directory(a:candidate)
  if !s:check_is_directory(directory)
    return
  endif

  execute 'VimFilerExplorer' escape(directory, '\ ')

  if has_key(a:candidate, 'action__path')
        \ && directory !=# a:candidate.action__path
    " Move cursor.
    call vimfiler#mappings#search_cursor(a:candidate.action__path)
    call s:move_vimfiler_cursor(a:candidate)
  endif
endfunction " }}}
call unite#custom#action('source/bookmark/directory', 'vimfiler-explorer', s:action)
call unite#custom_default_action('source/bookmark/directory', 'vimfiler-explorer')
unlet s:action


" unite-menu
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.shortcat = {
    \'description': 'shortcat'
    \ }

let g:unite_source_menu_menus.shortcat.command_candidates = [
    \ ['vimrc-edit   (F9)',           'e $HOME/.vimrc'],
    \ ['vimrc-reload (F8)',           'source $HOME/.vimrc'],
    \ ['unite-scriptnames',           'Unite scriptnames'],
    \ ['unite-history-yank',          'Unite history/yank'],
    \ ['unite-same-dir-files',        'Unite file:%:h'],
    \ ['unite-bookmark-config-files', "Unite file:$HOME/.cache/unite/bookmark"],
    \ ['unite-file-mru',              'Unite file_mru'],
    \ ['memolist-new',                'MemoNew'],
    \ ['php-function-list',           'vimgrep /\(^\|\s\+\)function\s\+.\+/ % | cwindow'],
    \ ['help easy-align-examples',    'help easy-align-examples'],
    \ ['help vimfiler-default-key-mappings', 'help vimfiler-default-key-mappings'],
    \ ]

" unite-mru
let g:unite_source_file_mru_limit = 1000

" unite-history/yank
let g:unite_source_history_yank_enable = 1

" -- unite キーバインド --

" ディレクトリBookmark一覧(BookmarkName: dir)
nnoremap <silent> [prefix]ee :Unite -direction=topleft -vertical -winwidth=35 -default-action=cd bookmark:dir<CR>

nnoremap <silent> [prefix]b :Unite buffer<CR>
nnoremap <silent> [prefix]m :Unite menu:shortcat<CR>
nnoremap <silent> [prefix]d :Unite -direction=botright -vertical -winwidth=70 outline<CR>

" nnoremap <silent> [prefix]<S-f> :Unite -start-insert file<CR>
" nnoremap <silent> [prefix]j :Unite -auto-preview jump<CR>
" nnoremap <silent> [prefix]g :Unite  -keep-focus -no-quit -direction=botright grep<CR>
" nnoremap <silent> [prefix]u :UniteBookmarkAdd<CR>
" nnoremap <silent> [prefix]f :Unite -start-insert buffer bookmark:* file_mru directory_mru file<CR>
" nnoremap <silent> [prefix]f :Unite -start-insert file_mru directory_mru<CR>
" nnoremap <silent> [prefix]l :Unite -direction=botright location_list<CR>
" vnoremap <silent> [prefix]g y:Unite -keep-focus -no-quit -direction=botright grep:::<C-R>=escape(@", '\\.*$^[]')<CR><CR>

"}}}

" -------------------------------------------------------------------
" memolist
" -------------------------------------------------------------------
" {{{
let s:hooks = neobundle#get_hooks("memolist.vim")
function! s:hooks.on_source(bundle)

    " メモファイルの置き場所
    let g:memolist_path        = '~/memo'

    " メモファイルの拡張子
    let g:memolist_memo_suffix = 'txt'

    " uniteで使用する
    let g:memolist_unite       = 1
endfunction

nnoremap <silent> [prefix]n :MemoList<CR>

" }}}

" -------------------------------------------------------------------
" NeoComplcache
" -------------------------------------------------------------------
" {{{

" 補完機能を有効にする。
let g:neocomplcache_enable_at_startup = 1

" タブで補完を確定する。
inoremap <expr><TAB>   pumvisible() ? "\<CR>" : "\<TAB>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}

" -------------------------------------------------------------------
" neosnippet
" -------------------------------------------------------------------
" {{{

" snippetディレクトリの設定
if isdirectory(expand("~/dotfiles/vim/snippet"))
    let g:neosnippet#snippets_directory = "~/dotfiles/vim/snippet"

elseif isdirectory(expand("$VIM/dotfiles/vim/snippet"))
    let g:neosnippet#snippets_directory = "$VIM/dotfiles/vim/snippet"
endif



" TABキー操作
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" CRキー操作
imap <expr><CR> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand)" : "\<CR>"
smap <expr><CR> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand)" : "\<CR>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" }}}

" -------------------------------------------------------------------
" vimfiler
" -------------------------------------------------------------------
" {{{

let g:vimfiler_as_default_explorer = 1
nnoremap <silent> [prefix]e :VimFilerExplorer<CR>

autocmd! FileType vimfiler call s:my_vimfiler_settings()
function! s:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
endfunction

" }}}

" -------------------------------------------------------------------
" vimshell
" -------------------------------------------------------------------
" {{{

let g:vimshell_vimshrc_path = expand('~/vimfiles/runtime/vimshrc')

" }}}

" -------------------------------------------------------------------
" EasyMotion
" <Leader> はBackSlashキー
" -------------------------------------------------------------------
"{{{

let g:EasyMotion_use_migemo = 1

" key-mapping
nmap [prefix]w <Plug>(easymotion-bd-w)
vmap [prefix]w <Plug>(easymotion-bd-w)
omap [prefix]w <Plug>(easymotion-bd-w)

nmap [prefix]v v<Plug>(easymotion-bd-w)


"}}}

" -------------------------------------------------------------------
" caw.vim
" -------------------------------------------------------------------
"{{{

" コメントアウト
nmap [prefix]/ <Plug>(caw:i:toggle)
vmap [prefix]/ <Plug>(caw:i:toggle)

"}}}

" -------------------------------------------------------------------
" syntastic
" -------------------------------------------------------------------
"{{{

let g:syntastic_enable_signs  = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_always_populate_loc_list = 1

"}}}

" -------------------------------------------------------------------
" vim-easy-align
" -------------------------------------------------------------------
"{{{

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

"}}}

" -------------------------------------------------------------------
" switch-toggler
" -------------------------------------------------------------------
"{{{

nmap [prefix]st <Plug>(switch-toggler-unite)

"}}}

" -------------------------------------------------------------------
" open-browser
" -------------------------------------------------------------------
"{{{

" カーソル位置にあるURLをブラウザで開く
nmap [prefix]o <Plug>(openbrowser-open))

"}}}

" -------------------------------------------------------------------
" ctrlp.vim
" -------------------------------------------------------------------
"{{{

" デフォルトのマッピングを無効化(default:'<C-p>')
let g:ctrlp_map = '<Nop>'

" 対象ファイル最大数(default:10000)
let g:ctrlp_max_files  = 100000

" 検索対象の最大階層数(default:40)
let g:ctrlp_max_depth = 10

" vim終了時にキャッシュクリアしない(default:1)
let g:ctrlp_clear_cache_on_exit = 0

" 検索ウィンドウの設定
" :help g:ctrlp_match_window
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:50'


" カレントディレクトリを基準に検索
nnoremap <silent> ff :CtrlPCurWD<CR>
" カレントバッファのルートディレクトリを基準に検索(root:自動認識)
nnoremap <silent> fF :CtrlPRoot<CR>

" 最近使ったファイルから検索
nnoremap <silent> fr :CtrlPMRUFiles<CR>

" ディレクトリ移動
nnoremap <silent> fd :CtrlPDir .<CR>
nnoremap <silent> f~ :CtrlPDir ~<CR>

" tag検索
nnoremap <silent> ft :CtrlPTag<CR>

"}}}

" -------------------------------------------------------------------
" foldCC
" -------------------------------------------------------------------
" {{{

set foldtext=FoldCCtext()

" }}}

" -------------------------------------------------------------------
" vim-quickrun
" -------------------------------------------------------------------
" {{{
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)

    " デフォルトのキーマップを使用しない
    let g:quickrun_no_default_key_mappings = 1

endfunction
" }}}

" -------------------------------------------------------------------
" vim-bookmarks
" -------------------------------------------------------------------
" {{{

nmap [prefix]mm <Plug>BookmarkToggle
nmap [prefix]mi <Plug>BookmarkAnnotate
nmap [prefix]ma <Plug>BookmarkShowAll

" 使わないMappingをOverwrite
nmap <Nop>BookmarkNext     <Plug>BookmarkNext
nmap <Nop>BookmarkPrev     <Plug>BookmarkPrev
nmap <Nop>BookmarkClear    <Plug>BookmarkClear
nmap <Nop>BookmarkClearAll <Plug>BookmarkClearAll


" }}}



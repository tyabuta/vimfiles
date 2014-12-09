if 0 != get(g:,'loaded_macro', 0)
  finish
endif
let g:loaded_macro = 1



function! macro#getTabSize()
    if exists("$VIM_TABSIZE")
        return $VIM_TABSIZE
    else
        return 4
endfunction

function! macro#openGlobalMemo()
    let g:memolist_path = expand(g:memolist_path, ':p')
    if !isdirectory(g:memolist_path)
      call mkdir(g:memolist_path, 'p')
    endif
    execute ":e " . g:memolist_path . "/global.txt"
endfunction

" -----------------------------------------------
" テキストファイルの文字列読み込み関数
" -----------------------------------------------
function! macro#ReadText(filename)
    let buf = ""
    for line in readfile(a:filename)
        let buf .= line . "\n"
    endfor
    return buf
endfunction

"
" more-promptの設定をする。
" 1 -> more  0 -> nomore
"
function! macro#MorePromptSetEnabled(bMore)
    if a:bMore
        set more
    else
        set nomore
    endif
endfunction

"
" more-promptの設定値を返す。
" 1 -> more  0 -> nomore
"
function! macro#MorePrompt()
    return &g:more
endfunction

"
" コマンド高さ値
"
function! macro#CommandHeight()
    return &g:cmdheight
endfunction

"
" コマンド高さ野設定
"
function! macro#CommandHeightSetValue(h)
    execute ":set cmdheight=" . a:h
endfunction

"
" 配列要素に指定オブジェクトは含まれるか調べる。
" 配列内に要素がさればゼロ以外を返す。
"
function! macro#ArrayHasObject(arr, obj)
    return count(a:arr, a:obj)
endfunction

"
" コマンドラインに選択リストを表示する。
" カーソルで操作し、決定すると選択されたリストインデックスを返す。
" 選択がキャンセルされると-1を返します。
"   msg: 選択を促すメッセージ
" items: 選択リストに表示する項目を配列で渡す。
"
function! macro#PromptSelectMenuList(msg, items)
    " more-promptの既存設定値
    let original_more = macro#MorePrompt()
    " echo出力があふれた時にMore表示が出ないようにする。
    call macro#MorePromptSetEnabled(0)

    let items_lentgh = len(a:items)
    let sel = 0
    while 1
        " --- 描画バッファ ---
        let buf = a:msg . "\n"
        let i = 0
        for item in a:items
            let buf .= printf("%s%s\n", sel==i? '->' : '  ', item)
            let i+=1
        endfor
        let buf .= printf("sel:%2d (^,v:Select  <:Cancel  >:OK) ", sel)

        " --- 描画 ---
        redraw
        echo buf

        " --- 入力 ---
        let a = getchar()
        let c = nr2char(a)
        if     "\<Down>"  ==a || 'j'==c
            let sel+=1
        elseif "\<Up>"    ==a || 'k'==c
            let sel-=1
        elseif "\<Left>"  ==a || 'h'==c || 27==a
            let sel = -1
            break
        elseif "\<Right>" ==a || 'l'==c || 13==a
            break
        endif
        " インデックスのループ計算
        let sel = (sel+items_lentgh) % items_lentgh
    endwhile

    " オリジナルの設定に戻す。
    call macro#MorePromptSetEnabled(original_more)
    " 再描画
    redraw
    return sel
endfunction



function! macro#PromptSelectKeyMap(msg, items)
    " more-promptの既存設定値
    let original_more = macro#MorePrompt()
    " echo出力があふれた時にMore表示が出ないようにする。
    call macro#MorePromptSetEnabled(0)

    let items_lentgh = len(a:items)
    let inputKey = ''
    while 1
        let cnt = 0
        let selectItem = ''

        " --- 描画バッファ ---
        let buf = a:msg . "\n"
        for item in a:items
            if item =~ printf("^%s", inputKey)
                let buf .= item . '  '
                let selectItem = item
                let cnt += 1
            endif
        endfor
        let buf .= "\n"
        let buf .= printf("key: %s", inputKey)
        " --- 描画 ---
        redraw
        echo buf

        if 1 >= cnt
            break
        endif

        " --- 入力 ---
        let a = getchar()
        let c = nr2char(a)
        let inputKey .= c
    endwhile

    " オリジナルの設定に戻す。
    call macro#MorePromptSetEnabled(original_more)
    " 再描画
    redraw

    return selectItem
endfunction


"
" カレントバッファのファイルタイプを取得する。
"
function! macro#FileType()
    return &l:filetype
endfunction


"
" 日付書式のリストを生成する。
"
function! s:DateFormatMakeList(date)
    let formats = [
        \ strftime("%Y.%m.%d", a:date),
        \ strftime("%Y.%m.%d %H:%M", a:date),
        \ strftime("%Y/%m/%d", a:date),
        \ strftime("%Y/%m/%d %H:%M", a:date),
        \ strftime("%H:%M", a:date),
        \ strftime("%H時%M分", a:date),
        \ strftime("%H時%M分%S秒", a:date),
        \ strftime("%Y年%m月%d日 %H時%M分", a:date),
        \ strftime("%Y年%m月%d日 %A %H時%M分", a:date),
        \ strftime("%Y.%m.%d(%a)", a:date),
        \ strftime("%Y/%m/%d(%a)", a:date),
        \ strftime("%Y年%m月%d日(%a)", a:date),
        \ strftime("%Y年%m月%d日 %A", a:date)]
    return formats
endfunction


"
" 日時を挿入する。
" 挿入する日時はコマンドラインより選択できる。
"
function! macro#DateInsert()
    " 候補となる日付書式を作成
    let now     = localtime()
    let formats = s:DateFormatMakeList(now)

    " リストから選択
    let ret = macro#PromptSelectMenuList("挿入する日付書式を選んでください。", formats)
    if -1 != ret
        execute ":normal i" . formats[ret]
    endif
endfunction



"
" バッファ操作をカーソルキーで行う。
"   左: 前のバッファへ
"   右: 次のバッファへ
"   下: カレントバッファを閉じる
" 数値: 1-9の指定のバッファ番号へ(10以上は不可)
"
function! macro#BufferControl()
    echo "*** Buffer Control ***"
    echo "%:Current #:Alternate a:Active h:Hidden +:Changed"
    echo "--------------------------------------------------"
    buffers
    echo "--------------------------------------------------"
    echo "                       ^"
    echo "< Previous  Close  Alternate  Next >"
    echo "              v                      Please key press."

    " キー入力
    let a = getchar()  " Ascii
    let c = nr2char(a) " Char
    let n = str2nr(c)  " Number
    if     "\<Left>" ==a || 'h'==c
        bprevious
    elseif "\<Down>" ==a || 'j'==c
        bdelete
    elseif "\<Up>"   ==a || 'k'==c || '#'==c
        b#
    elseif "\<Right>"==a || 'l'==c
        bNext
    else
        " 1-9の数値入力の場合、番号指定でバッファ移動する。
        if 0<n && bufexists(n)
            execute ":buffer " . n
        endif
    endif

    " 画面更新
    redraw
endfunction



"
" PHP用のシンタックスチェック
"
function! macro#PHPSyntaxCheck()
    execute ":silent !clear"
    execute ":silent !echo PHP Syntax Check"
    execute ":!php --syntax-check %"
endfunction

"
" Ruby用のシンタックスチェック
"
function! macro#RubySyntaxCheck()
    execute ":silent !clear"
    execute ":silent !echo Ruby Syntax Check"
    execute ":!ruby -cw %"
endfunction

"
" ビルドコマンド、またはシンタックスチェックを
" ファイルタイプに応じて行う。
"
function! macro#Build()
    let filetype = macro#FileType()
    if      "php" == filetype
        call macro#PHPSyntaxCheck()
    elseif "ruby" == filetype
        call macro#RubySyntaxCheck()
    else
        echo printf("[%s]に適切なビルドコマンドが見つかりません。", filetype)
    endif
endfunction


"
" カレントバッファをsourceコマンドで読み込む
"
function! macro#VimImport()
    echo "Vim Import " . expand("%:p")
    source %
endfunction

"
" スクリプト実行関数
"
function! macro#RunScript()
    execute ":silent !clear"
    execute ":silent !echo Script run"
    execute ":!./%"
endfunction

"
" Runコマンド
" ファイルタイプに応じて行う。
"
function! macro#Run()
    let filetype = macro#FileType()
    if    "vim" == filetype
        call macro#VimImport()
    elseif macro#ArrayHasObject(["sh","ruby","php","python"], filetype)
        call macro#RunScript()
    else
        echo printf("[%s]に適切なRunコマンドが見つかりません。", filetype)
    endif
endfunction


"
" コメントによる線を引く。
"
"      line: 行を表す表記
" begin_str: コメントの始まり
"   end_str: コメントの終わり
"      char: ライン形成に使用する文字
"
function! macro#CommentOutputLine(line, begin_str, end_str, char)
    let cur_line = line(a:line)
    " コメントの最大列数
    let col_max = 70

    let str = a:begin_str
    let str.= repeat(a:char, col_max - strlen(a:begin_str . a:end_str) - 1)
    let str.= a:end_str
    call setline(cur_line, str)
endfunction

"
"
" textファイル用のコメントライン書き込み関数
" linetype: 0 -> -----
"           1 -> =====
"
function! macro#CommentOutputLineForText(linetype)
    call macro#CommentOutputLine(".",
        \ '',
        \ '',
        \ (a:linetype? '=' : '-'))
endfunction

"
"
" vimファイル用のコメントライン書き込み関数
" linetype: 0 -> " -----
"           1 -> " *****
"
function! macro#CommentOutputLineForVim(linetype)
    call macro#CommentOutputLine(".",
        \ '" ',
        \ '',
        \ (a:linetype? '*' : '-'))
endfunction

"
"
" Shellスクリプト用のコメントライン書き込み関数
" Ruby, Perlでも使用可。
" linetype: 0 -> # -----
"           1 -> # *****
"
function! macro#CommentOutputLineForShell(linetype)
    call macro#CommentOutputLine(".",
        \ '# ',
        \ '',
        \ (a:linetype? '*' : '-'))
endfunction

"
" ファイルタイプに応じてコメントによるラインを書き込む。
"
function! macro#CommentOutputLineWithFileType(ftype, linetype)
    if "vim"==a:ftype
        call macro#CommentOutputLineForVim(a:linetype)
    elseif "sh"==a:ftype || "ruby"==a:ftype || "perl"==a:ftype
        call macro#CommentOutputLineForShell(a:linetype)
    else
        call macro#CommentOutputLineForText(a:linetype)
    endif
endfunction


"
" tmpディレクトリに一時ファイルを作成する。
"
function! macro#make_temp()
  let suffix = input('suffix: ')
  execute 'edit ' . tempname() . suffix
endfunction






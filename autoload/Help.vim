
" -----------------------------------------------
" テキストファイルの文字列読み込み関数
" -----------------------------------------------
function! s:read_text(filename)
    let buf = ""
    for line in readfile(a:filename)
        let buf .= line . "\n"
    endfor
    return buf
endfunction


" ----------------------------------------------
" カーソル移動についてのヘルプを表示する。
" -----------------------------------------------
function! Help#CursorControl()
    echo "Cursor移動 h,j,k,l"
    echo "    k ... カーソルを上に移動        k:上"
    echo "    h ... カーソルを左に移動  h:左"
    echo "    l ... カーソルを右に移動           l:右"
    echo "    j ... カーソルを下に移動     j:下"
    echo "Word移動 w,b,e,ge"
    echo "    w ... 次の単語の先頭に移動"
    echo "    b ... 前の単語の先頭に移動"
    echo "    e ... 次の単語の末尾に移動"
    echo "   ge ... 前の単語の末尾に移動"
    echo "行移動 ^,$"
    echo "    ^ ... 行頭へ移動"
    echo "    $ ... 行末へ移動"
    echo "括弧移動 %"
    echo "    % ... 対応する括弧へ移動"
    echo "画面移動 C-f,C-b"
    echo "  C-f ... １画面分進む or S-j (my custom)"
    echo "  C-b ... １画面分戻る or S-k (my custom)"
endfunction



" ----------------------------------------------
" レジスタ操作についてのヘルプを表示する。
" -----------------------------------------------
function! Help#Register()
    echon s:read_text($HOME . "/.vim/doc/RegisterHelp.txt")
endfunction


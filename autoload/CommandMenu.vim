" *******************************************************************
"
"                          コマンドメニュー
"
"                                                 (c) 2013 tyabuta.
" *******************************************************************



" -------------------------------------------------------------------
" メニューアイテム配列から、ディスプレイ配列を生成する。
" -------------------------------------------------------------------
function! s:get_display_array(menu)
    let arr = []
    for item in a:menu
        call add(arr, item.display)
    endfor
    return arr
endfunction

" -------------------------------------------------------------------
" 「挿入」用のコマンドメニュー
" -------------------------------------------------------------------
function! s:command_menu_for_insert()

    let item1 = {'display': "コメントライン"}
    function item1.func()
        call macro#CommentOutputLineWithFileType(macro#FileType(), 0)
    endfunction

    let item2 = {'display': "コメントライン(強調)"}
    function item2.func()
        call macro#CommentOutputLineWithFileType(macro#FileType(), 1)
    endfunction

    let item3 = {'display': "日付"}
    function item3.func()
        call macro#DateInsert()
    endfunction

    let menu = [item1, item2, item3]
    let ret = macro#PromptSelectMenuList("*** Command Menu [Insert] ***",
                                       \ s:get_display_array(menu))
    if -1 != ret
        call menu[ret].func()
    endif
endfunction


" -------------------------------------------------------------------
" 「ヘルプ」用のコマンドメニュー
" -------------------------------------------------------------------
function! s:command_menu_for_help()

    let item1 = {'display': "カーソル操作"}
    function item1.func()
        call Help#CursorControl()
    endfunction

    let item2 = {'display': "レジスタについて"}
    function item2.func()
        "call macro#MorePromptSetEnabled(1)
        call Help#Register()
        "call macro#MorePromptSetEnabled(0)
    endfunction

    let menu = [item1, item2]
    let ret = macro#PromptSelectMenuList("*** Command Menu [Help] ***",
                                       \ s:get_display_array(menu))
    if -1 != ret
        call menu[ret].func()
    endif
endfunction


" -------------------------------------------------------------------
" コマンドメニュー
" 選択メニュー形式で、コマンド機能を呼び出せる。
" -------------------------------------------------------------------
function! CommandMenu#Show()

    let item1 = {'display': "そうにゅう"}
    function item1.func()
        call s:command_menu_for_insert()
    endfunction

    let item2 = {'display': "へんしゅう"}
    function item2.func()
        echo "未実装"
    endfunction

    let item3 = {'display': "ヘルプ"}
    function item3.func()
        call s:command_menu_for_help()
    endfunction

    let menu = [item1, item2, item3]
    let ret = macro#PromptSelectMenuList("*** Command Menu ***",
                                       \ s:get_display_array(menu))
    if -1 != ret
        call menu[ret].func()
    endif
endfunction



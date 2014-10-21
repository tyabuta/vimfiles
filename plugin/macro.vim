
command! MacroMakeTemp call macro#make_temp()

" JSON整形コマンド
command! MacroJsonFormat :execute '%!python ' . expand('~/vimfiles/scripts/json-format.py')


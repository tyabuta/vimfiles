#!/usr/bin/env bash

echo -n "create ~/.vimrc  ~/.gvimrc ? [yes/No] "
read answer
case $answer in
    "Y" | "y" | "yes" | "Yes" | "YES" ) ;;
    * ) exit 0 ;;
esac

cat <<EOT > ~/.vimrc
if has('unix')
    set runtimepath+=~/vimfiles
endif
source ~/vimfiles/runtime/vimrc.vim
EOT

cat <<EOT > ~/.gvimrc
source ~/vimfiles/runtime/gvimrc.vim
EOT

echo 'created!'


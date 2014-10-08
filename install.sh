#!/usr/bin/env bash

echo -n "create ~/.vimrc ? [yes/No] "
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

echo 'created!'


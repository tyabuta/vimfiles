#!/usr/bin/env bash

echo -n "create ~/.vimrc ? [yes/No] "
read answer
case $answer in
    "Y" | "y" | "yes" | "Yes" | "YES" ) ;;
    * ) exit 0 ;;
esac

cat <<EOT > ~/.vimrc
set runtimepath+=~/vimfiles
source ~/vimfiles/runtime/vimrc.vim
EOT

echo 'created!'


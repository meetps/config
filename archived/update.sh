#!/bin/bash

source ./install.sh

echo $1
# Update local repo everytime
basic_update


case $1 in
    --vim )
        vim_update ;;
    --tmux )
        tmux_update ;;
    --zsh )
        zsh_update ;;
    --i3 )
        i3_update ;;
    --urxvt )
        urxvt_update ;;
    *)
    echo "Update for module $1 is not supported";;
esac

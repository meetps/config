#!/bin/bash

source ./install.sh

echo $1
# Update local repo everytime
basic_update


case $1 in
    --python )
        python_update ;;
    --vim )
        vim_update ;;
    --tmux )
        tmux_update ;;
    --git ) 
        git_update ;;
    --zsh ) 
        zsh_update ;;
    --imgur )
        imgur_update ;;
    --visdom )
        visdom_update ;;
    --vscode )
        vscode_update ;;
    --rmate )
        rmate_update ;;
    --ranger )
        ranger_update ;;
    --terminator )
        terminator_update ;;
    *)
    echo "Update for module $1 is not supported";;
esac

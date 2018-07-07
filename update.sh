#!/bin/bash

source ./install.sh &&#

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
    --terminator )
        terminator_update ;;
    *)
    echo "Signal number $1 is not processed";;
esac
#####################################################
#
#          Personal Environment Config
#            
#                    .--.
#          ::\`--._,'.::.`._.--'/::::
#          ::::.  ` __::__ '  .::::::
#          ::::::-:.`'..`'.:-::::::::
#          ::::::::\ `--' /::::::::::
#                    '--'
#
#                  Try not.
#         Do or do not. There is no try.
#####################################################


URL=https://github.com/meetshah1995/config.git
CONFIGDIR=$HOME/.mconfig

basic_update () {
    if [ ! -d "$CONFIGDIR" ] ; then
        echo "Config repo doesn't exist at $CONFIGDIR, cloning";
        git clone "$URL" "$CONFIGDIR";
    else
        echo "Config repo exists at $CONFIGDIR, checking for updates";
        cd "$CONFIGDIR";
        git pull "$URL";
    fi
}

dependencies () {
    # Install Vim 8.0
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update
    sudo apt install -y vim

    # Install misc stuff
    sudo apt-get install -y ncdu tmux ranger w3m
    echo "Dependencies installed";
}

# Setup git
git_update() {
    cp $CONFIGDIR/git/gitconfig ~/.gitconfig
    sudo cp $CONFIGDIR/git/redate /usr/bin/redate
    sudo chmod +x /usr/bin/redate

    #Setup fancy diff
    sudo cp $CONFIGDIR/git/diff-so-fancy /usr/bin/diff-so-fancy
    sudo chmod +x /usr/bin/diff-so-fancy
    echo "git updated";
}

# Setup zsh and oh-my-zsh
zsh_update() {
    sudo apt-get install -y zsh
    whoami | xargs -n 1 sudo chsh -s $(which zsh) $1
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    mv ~/.zshrc ~/.zshrc_old
    cp $CONFIGDIR/zsh/zshrc ~/.zshrc
    echo "zsh updated";
}


vim_update() {
    # Make directory for bundles and colors
    mkdir ~/.vim/bundle
    mkdir ~/.vim/colors

    # Copy color scheme
    cp $CONFIGDIR/vim/monokai.vim ~/.vim/colors/
    
    # Vimcat binary
    sudo cp $CONFIGDIR/vim/vimcat /usr/bin/vimcat
    sudo chmod +x /usr/bin/vimcat

    # Clone and Install vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp $CONFIGDIR/vim/vimrc ~/.vimrc
    vim +PluginInstall! 
    echo "vim updated"; 

}

# Setup imgur 
imgur_update() {
    sudo cp $CONFIGDIR/imgur/imgur /usr/bin/imgur
    sudo chmod +x /usr/bin/imgur
    echo "imgur updated";
}

# Setup visdom
visdom_update() {
    sudo python -m pip install "visdom==0.1.6.5"
    sudo cp $CONFIGDIR/visdom/visdom /usr/bin/visdom
    sudo chmod +x /usr/bin/visdom
    echo "visdom updated";
}

# Setup VS Code
vscode_update() {
    cp $CONFIGDIR/vscode/keybindings.json $HOME/.config/Code/User/keybindings.json
    cp $CONFIGDIR/vscode/settings.json $HOME/.config/Code/User/settings.json
    echo "vscode updated";
}

# Setup rmate
rmate_update() {
    sudo cp $CONFIGDIR/rmate/rmate /usr/bin/rmate
    sudo chmod +x /usr/bin/rmate
    echo "rmate updated";
}

# Setup tmux
tmux_update() {
    cp tmux/tmux.conf $HOME/.tmux.conf
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux source-file ~/.tmux.conf
    echo "tmux updated";
}

terminator_update() {
    # Copy config to terminator
    cp $CONFIGDIR/terminator/config ~/.config/terminator/config
    echo "terminator updated";
}

python_update() {
    # Copy Ipython and Python configs
    cp $CONFIGDIR/python/ipython_config ~/.ipython/ipython_config.py
    cp $CONFIGDIR/python/loadpy /usr/bin/loadpy
    cp $CONFIGDIR/python/jupyter_notebook_config.py ~/.jupyter/jupyter_notebook_config.py
    sudo chmod +x /usr/bin/loadpy
    echo "python updated";
}

ranger_update() {
    # Copy Ipython and Python configs
    cp $CONFIGDIR/ranger/* ~/.config/ranger/
    echo "ranger updated";
}

# Call all common update functions
common_update() {
    basic_update
    dependencies
    imgur_update
    visdom_update
    python_update
    tmux_update
    rmate_update
    ranger_update
}

# Call device specific functions
if [ "$1" = "server" ] ; then
    common_update
    rmate_update
    vim_update

elif [ "$1" = "laptop" ] ; then
    common_update
    terminator_update
    vscode_update
    vim_update
else
    echo "Only laptop and server supported, $1 not supported"
fi

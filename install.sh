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

function basic_update {
    if [ ! -d "$CONFIGDIR" ] ; then
        echo "Config repo doesn't exist at $CONFIGDIR, cloning" && git clone "$URL" "$CONFIGDIR";
    else
        echo "Config repo exists at $CONFIGDIR, checking for updates" &&#
        cd "$CONFIGDIR"
        git pull "$URL"
    fi

}

function dependencies {
    # Install Vim 8.0
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update
    sudo apt install -y vim

    # Install misc stuff
    sudo apt-get install -y ncdu tmux
}

# Setup git
function git_update {
    cp $CONFIGDIR/git/gitconfig ~/.gitconfig
    sudo cp $CONFIGDIR/git/redate /bin/redate
    sudo chmod +x /usr/bin/redate

    #Setup fancy diff
    sudo cp $CONFIGDIR/git/diff-so-fancy /usr/bin/diff-so-fancy
    sudo chmod +x /usr/bin/diff-so-fancy
}

# Setup zsh and oh-my-zsh
function zsh_update {
    sudo apt-get install -y zsh
    whoami | xargs -n 1 sudo chsh -s $(which zsh) $1
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    mv ~/.zshrc ~/.zshrc_old
    cp $CONFIGDIR/zsh/zshrc ~/.zshrc
}


function vim_update {
    # Make directory for bundles and colors
    mkdir ~/.vim/bundle
    mkdir ~/.vim/colors

    # Copy color scheme
    cp $CONFIGDIR/vim/monokai.vim ~/.vim/colors/
    
    # Clone and Install vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    cp $CONFIGDIR/vim/vimrc ~/.vimrc
    vim +PluginInstall! 
}

# Setup imgur 
function imgur_update {
    sudo cp $CONFIGDIR/imgur/imgur /bin/imgur
    sudo chmod +x /usr/bin/imgur
}

# Setup visdom
function visdom_update {
    sudo python -m pip install "visdom==0.1.6.5"
    sudo cp $CONFIGDIR/visdom/visdom /bin/visdom
    sudo chmod +x /usr/bin/visdom
}

# Setup VS Code
function vscode_update {
    cp $CONFIGDIR/vscode/keybindings.json $HOME/.config/Code/User/keybindings.json
    cp $CONFIGDIR/vscode/settings.json $HOME/.config/Code/User/settings.json
}

# Setup rmate
function rmate_update {
    sudo cp $CONFIGDIR/rmate/rmate /bin/rmate
    sudo chmod +x /usr/bin/rmate
}

# Setup tmux
function tmux_update {
    sudo cp tmux/tmux.conf $HOME/.tmux.conf
    tmux source-file ~/.tmux.conf
}

function terminator_update {
    # Copy config to terminator
    cp $CONFIGDIR/terminator/config ~/.config/terminator/config
}

function python_update {
    # Copy Ipython and Python configs
    cp $CONFIGDIR/python/ipython_config ~/.ipython/ipython_config.py
    cp $CONFIGDIR/python/loadpy /usr/bin/loadpy
    sudo chmod +x /usr/bin/loadpy
}

# Call all common update functions
basic_update
dependencies
imgur_update
visdom_update
vim_update
python_update
tmux_update
rmate_update

# Call device specific functions
if [ "$1" == "server" ] ; then
    rmate_update
elif [ $1="laptop" ] ; then
    terminator_update
    vscode_update
else
    echo "Only laptop and server supported, $1 not supported"
fi
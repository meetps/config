#####################################################
#
#          Personal Environment Config
#            
#                     .--.
#           ::\`--._,'.::.`._.--'/::
#           ::::.  ` __::__ '  .::::
#           ::::::-:.`'..`'.:-::::::
#           ::::::::\ `--' /::::::::
#                     '--'
#
#                  Try not.
#         Do or do not. There is no try.
#####################################################


URL=https://github.com/meetps/config.git
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
    sudo add-apt-repository --yes --force-yes ppa:jonathonf/vim
    sudo apt update --force-yes
    sudo apt install -y --no-install-recommends vim

    # Install misc stuff
    sudo apt-get install -y --no-install-recommends ncdu tmux ranger w3m curl htop
    echo "Dependencies installed";
}

# Setup git
git_update() {
    cp $CONFIGDIR/git/gitconfig $HOME/.gitconfig
    sudo cp $CONFIGDIR/git/redate /usr/bin/redate
    sudo chmod +x /usr/bin/redate

    #Setup fancy diff
    sudo cp $CONFIGDIR/git/diff-so-fancy /usr/bin/diff-so-fancy
    sudo chmod +x /usr/bin/diff-so-fancy
    echo "git updated";
}

# Setup zsh and oh-my-zsh
zsh_update() {
    # install zsh
    sudo apt-get install -y zsh
    whoami | xargs -n 1 sudo chsh -s $(which zsh) $1

    # install oh-my-zsh and powerline9k with fonts
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    sudo apt-get install fonts-font-awesome
    sudo mkdir -p /usr/share/fonts/truetype/fonts-iosveka/
    sudo cp $CONFIGDIR/static/iosveka-regular.ttf /usr/share/fonts/truetype/fonts-iosveka/

    # install zsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    mv $HOME/.zshrc $HOME/.zshrc_old
    cp $CONFIGDIR/zsh/zshrc $HOME/.zshrc
    cp $CONFIGDIR/zsh/transfer.sh $HOME/.transfer.sh
    cp $CONFIGDIR/zsh/aliases $HOME/.zsh_aliases
    echo "zsh updated";
}


# Setup vim and Vundle
vim_update() {
    # Make directory for bundles and colors
    mkdir -p $HOME/.vim/bundle
    mkdir -p $HOME/.vim/colors

    # Copy color scheme
    cp $CONFIGDIR/vim/monokai.vim $HOME/.vim/colors/
    
    # Vimcat binary
    sudo cp $CONFIGDIR/vim/vimcat /usr/bin/vimcat
    sudo chmod +x /usr/bin/vimcat

    # Clone and Install vim-plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    cp $CONFIGDIR/vim/vimrc $HOME/.vimrc
    vim +silent +VimEnter +PluginInstall +qall
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
    sudo python -m pip install visdom
    sudo cp $CONFIGDIR/visdom/vis /usr/bin/vis
    sudo chmod +x /usr/bin/vis
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
    mkdir -p $HOME/.tmux/
    cp tmux/tmux.conf $HOME/.tmux.conf
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    tmux source-file $HOME/.tmux.conf
    echo "tmux updated";
}

# Setup terminator
terminator_update() {
    # Copy config to terminator
    cp $CONFIGDIR/terminator/config $HOME/.config/terminator/config
    echo "terminator updated";
}

# Setup urxvt
urxvt_update() {
    sudo apt-get install -y --no-install-recommends rxvt-unicode
    mkdir -p $HOME/.urxvt/ext/
    cp -r $CONFIGDIR/urxvt/ext $HOME/.urxvt/
    cp -r $CONFIGDIR/urxvt/Xdefaults $HOME/.Xdefaults
    xrdb $HOME/.Xdefaults
    echo "urxvt updated";
}

# Setup python modules
python_update() {
    # Copy Ipython and Python configs
    mkdir -p $HOME/.ipython/
    mkdir -p $HOME/.jupyter/
    sudo python -m pip install sh neovim
    cp $CONFIGDIR/python/ipython_config $HOME/.ipython/ipython_config.py
    cp $CONFIGDIR/python/loadpy /usr/bin/loadpy
    cp $CONFIGDIR/python/jupyter_notebook_config.py $HOME/.jupyter/jupyter_notebook_config.py
    sudo chmod +x /usr/bin/loadpy
    echo "python updated";
}

ranger_update() {
    # Copy Ipython and Python configs
    mkdir -p $HOME/.config/ranger
    cp $CONFIGDIR/ranger/* $HOME/.config/ranger/
    echo "ranger updated";
}

i3_update() {
    sudo add-apt-repository --force-yes ppa:jasonpleau/rofi
    sudo apt update --force-yes
    sudo apt-get install -y --no-install-recommends py3status i3 i3lock rofi
    mkdir -p $HOME/.config/i3
    cp $CONFIGDIR/i3/*confg $HOME/.config/i3/
    echo "i3 updated";
}

# Call all common update functions
common_update() {
    basic_update
    dependencies
    git_update
    imgur_update
    visdom_update
    python_update
    tmux_update
    rmate_update
    ranger_update
    urxvt_update
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
    i3_update
else
    echo "Only laptop and server supported, $1 not supported"
fi

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


BRANCH=master
URL=https://github.com/ms-google/config/archive/refs/heads/${BRANCH}.zip
CONFIGDIR=$HOME/.mconfig

basic_update () {
    sudo apt install -y --no-install-recommends git unzip wget
    if [ ! -d "$CONFIGDIR" ] ; then
        echo "Config repo doesn't exist at $CONFIGDIR, cloning";
        git clone "$URL" "$CONFIGDIR";
    else
        echo "Config repo exists at $CONFIGDIR, checking for updates";
        cd "$CONFIGDIR";
        git pull "$URL";
    fi
}

dependencies_ubuntu () {
    # Install neovim / vim 8.0
    sudo apt install -y --no-install-recommends neovim vim
    sudo apt install -y --no-install-recommends ncdu tmux ranger w3m curl htop
    sudo apt install -y --no-install-recommends xclip xsel
    echo "Dependencies installed";
}

bin_update() {
    sudo cp $CONFIGDIR/git/redate /usr/bin/redate && sudo chmod +x /usr/bin/redate
    sudo cp $CONFIGDIR/python/loadpy /usr/bin/loadpy && sudo chmod +x /usr/bin/loadpy
    echo "Binaries installed";
}

config_update() {
    cp $CONFIGDIR/git/gitconfig $HOME/.gitconfig
    mkdir -p $HOME/.ipython/ && cp $CONFIGDIR/python/ipython_config $HOME/.ipython/ipython_config.py
    mkdir -p $HOME/.config/ranger && cp $CONFIGDIR/ranger/* $HOME/.config/ranger/
    echo "configs updated";
}

zsh_update() {
    sudo apt install -y zsh fonts-font-awesome fzf
    whoami | xargs -n 1 sudo chsh -s $(which zsh) $1


    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    mv $HOME/.zshrc $HOME/.zshrc_old
    cp $CONFIGDIR/zsh/zshrc $HOME/.zshrc && cp $CONFIGDIR/zsh/aliases $HOME/.zsh_aliases
    cp $CONFIGDIR/zsh/p10k.zsh $HOME/.p10k.zsh

    sudo mkdir -p /usr/share/fonts/truetype/fonts-iosveka/
    sudo cp $CONFIGDIR/static/iosveka-regular.ttf /usr/share/fonts/truetype/fonts-iosveka/
    echo "zsh updated";
}

tmux_update() {
    mkdir -p $HOME/.tmux/
    cp tmux/tmux.conf $HOME/.tmux.conf
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    tmux source-file $HOME/.tmux.conf
    echo "tmux updated";
}

urxvt_update() {
    sudo apt-get install -y --no-install-recommends rxvt-unicode
    mkdir -p $HOME/.urxvt/ext/
    cp -r $CONFIGDIR/urxvt/ext $HOME/.urxvt/
    cp -r $CONFIGDIR/urxvt/Xdefaults $HOME/.Xdefaults
    xrdb $HOME/.Xdefaults
    echo "urxvt updated";
}

i3_update() {
    sudo add-apt-repository --force-yes ppa:jasonpleau/rofi
    sudo apt update --force-yes
    sudo apt-get install -y --no-install-recommends py3status i3 i3lock rofi
    mkdir -p $HOME/.config/i3
    cp $CONFIGDIR/i3/*confg $HOME/.config/i3/
    echo "i3 updated";
}

vim_update() {
    mkdir -p $HOME/.config/nvim/plugin
    mkdir -p $HOME/.config/nvim/colors
    mkdir -p $HOME/.config/nvim/lua

    cp $CONFIGDIR/nvim/colors/monokai.vim $HOME/.config/nvim/colors/
    cp $CONFIGDIR/nvim/lua/* $HOME/.config/nvim/lua/

    nvim -u $HOME/.config/nvim/lua/init.lua --headless "+Lazy! sync" +qa
    echo "vim updated";
}

common_update() {
    basic_update
    dependencies_ubuntu
    config_update
    bin_update
    zsh_update
    vim_update
    tmux_update
}

# Call device specific functions
if [ "$1" = "server" ] ; then
    common_update

elif [ "$1" = "laptop" ] ; then
    common_update
    urxvt_update
    i3_update
else
    echo "Only laptop and server supported, $1 not supported"
fi

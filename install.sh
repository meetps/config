URL=https://github.com/ms-google/config.git
CONFIGDIR=$HOME/.mconfig

basic_update () {
    sudo apt install -y --no-install-recommends git unzip wget git-delta
    if [ ! -d "$CONFIGDIR" ] ; then
        echo "Config repo doesn't exist at $CONFIGDIR, cloning";

        repo_url="https://github.com/meetps/config/archive/master.zip"
        dest_dir="$HOME/.mconfig"
        mkdir -p "$dest_dir"
        temp_zip="$(mktemp).zip"
        curl -sL "$repo_url" -o "$temp_zip"
        unzip -qo "$temp_zip" -d "$dest_dir"
        rm "$temp_zip"
        extracted_dir="$dest_dir/config-master"
        if [ -d "$extracted_dir" ]; then
            mv "$extracted_dir"/* "$dest_dir"
            rm -r "$extracted_dir"
        fi
    else
        echo "Config repo exists at $CONFIGDIR, checking for updates";
        cd "$CONFIGDIR";
        git pull "$URL";
    fi
}

dependencies_ubuntu () {
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo apt update -y
    sudo apt install -y --no-install-recommends neovim vim ranger tmux
    sudo apt install -y --no-install-recommends ncdu wget w3m curl htop btop ripgrep bat nvtop
    sudo apt install -y --no-install-recommends xclip xsel

    if which python &>/dev/null; then
        python -m ensurepip --upgrade
        python -m pip install uv
        uv pip install --system beautifulsoup4 black flake8 ipython isort matplotlib-inline numpy pandas requests rich ruff uploadserver uv yt-dlp
    else
        echo "Python not found, skipping command."
    fi

    echo "Dependencies installed";
}

bin_update() {
    sudo cp $CONFIGDIR/git/redate /usr/bin/redate && sudo chmod +x /usr/bin/redate
    echo "Binaries installed";
}

zsh_update() {
    sudo apt install -y --no-install-recommends zsh fonts-font-awesome fzf
    sudo chsh -s $(which zsh)

    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    if test -f $HOME/.zshrc; then
        mv $HOME/.zshrc $HOME/.zshrc_old
    fi
    cp $CONFIGDIR/zsh/zshrc $HOME/.zshrc && cp $CONFIGDIR/zsh/aliases $HOME/.zsh_aliases

    sudo mkdir -p /usr/share/fonts/truetype/fonts-iosevka/
    sudo cp $CONFIGDIR/static/iosevka-regular.ttf /usr/share/fonts/truetype/fonts-iosevka/
    echo "zsh updated";
}

tmux_update() {
    mkdir -p $HOME/.tmux/
    cp tmux/tmux.conf $HOME/.tmux.conf
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    tmux new-session -d && tmux source-file $HOME/.tmux.conf
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
    cp $CONFIGDIR/i3/*.py /usr/bin/
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

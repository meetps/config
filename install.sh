#####################################################
#
# Config Personal Environment
#
#####################################################

URL=git@github.com:meetshah1995/config.git
CONFIGDIR=$HOME/.mconfig

if [ ! -d "$CONFIGDIR" ] ; then
    echo "REPo doesn't exist at $CONFIGDIR, cloning"
    git clone "$URL" "$CONFIGDIR"
else
    echo "REPO exists at $CONFIGDIR, checking for updates"
    cd "$CONFIGDIR"
    git pull "$URL"
fi

# Install Vim 8.0
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

# Install misc stuff
sudo apt-get install ncdu

# Setup git
cp $CONFIGDIR/git/gitconfig ~/.gitconfig
sudo cp $CONFIGDIR/git/redate /bin/redate
sudo chmod +x /bin/redate

# Setup zsh and oh-my-zsh
sudo apt-get install zsh
whoami | xargs -n 1 sudo chsh -s $(which zsh) $1
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup imgur 
sudo cp $CONFIGDIR/imgur/imgur /bin/imgur
sudo chmod +x /bin/imgur

# Setup visdom
sudo python -m pip install "visdom=0.1.6.5"
sudo cp $CONFIGDIR/visdom/visdom /bin/visdom
sudo chmod +x /bin/visdom

# Setup VS Code
cp $CONFIGDIR/vscode/keybindings.json $HOME/.config/Code/User/keybindings.json
cp $CONFIGDIR/vscode/settings.json $HOME/.config/Code/User/settings.json

# Make directory for bundles
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp $CONFIGDIR/vim/vimrc ~/.vimrc
vim +PluginInstall!

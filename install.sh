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

if [ ! -d "$CONFIGDIR" ] ; then
    echo "Config repo doesn't exist at $CONFIGDIR, cloning"
    git clone "$URL" "$CONFIGDIR"
else
    echo "Config repo exists at $CONFIGDIR, checking for updates"
    cd "$CONFIGDIR"
    git pull "$URL"
fi

# Install Vim 8.0
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install -y vim

# Install misc stuff
sudo apt-get install -y ncdu tmux

# Setup git
cp $CONFIGDIR/git/gitconfig ~/.gitconfig
sudo cp $CONFIGDIR/git/redate /bin/redate
sudo chmod +x /usr/bin/redate

# Setup zsh and oh-my-zsh
sudo apt-get install -y zsh
whoami | xargs -n 1 sudo chsh -s $(which zsh) $1
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv ~/.zshrc ~/.zshrc_old
cp $CONFIGDIR/zsh/zshrc ~/.zshrc

# Setup imgur 
sudo cp $CONFIGDIR/imgur/imgur /bin/imgur
sudo chmod +x /usr/bin/imgur

# Setup visdom
sudo python -m pip install "visdom==0.1.6.5"
sudo cp $CONFIGDIR/visdom/visdom /bin/visdom
sudo chmod +x /usr/bin/visdom

# Setup VS Code
cp $CONFIGDIR/vscode/keybindings.json $HOME/.config/Code/User/keybindings.json
cp $CONFIGDIR/vscode/settings.json $HOME/.config/Code/User/settings.json

# Setup rmate
sudo cp $CONFIGDIR/rmate/rmate /bin/rmate
sudo chmod +x /usr/bin/rmate

# Setup tmux
sudo cp tmux/tmux.conf $HOME/.tmux.conf
tmux source-file ~/.tmux.conf

# Make directory for bundles and colors
mkdir ~/.vim/bundle
mkdir ~/.vim/colors

# Copy color scheme
cp $CONFIGDIR/vim/monokai.vim ~/.vim/colors/

# Copy config to terminator
cp $CONFIGDIR/terminator/config ~/.config/terminator/config

# Copy Ipython and Python configs
cp $CONFIGDIR/python/ipython_config ~/.ipython/ipython_config.py
cp $CONFIGDIR/python/loadpy /usr/bin/loadpy
sudo chmod +x /usr/bin/loadpy

# Clone and Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp $CONFIGDIR/vim/vimrc ~/.vimrc
vim +PluginInstall!

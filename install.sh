#####################################################
#
# Config Personal Environment
#
#####################################################

# Install Vim 8.0
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

# Install misc stuff
sudo apt-get install ncdu

# Setup git
cp git/gitconfig ~/.gitconfig
sudo cp git/redate /bin/redate
sudo chmod +x /bin/redate

# Setup zsh and oh-my-zsh
sudo apt-get install zsh
whoami | xargs -n 1 sudo chsh -s $(which zsh) $1
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup imgur 
sudo cp imgur/imgur /bin/imgur
sudo chmod +x /bin/imgur

# Setup visdom
sudo python -m pip install "visdom=0.1.6.5"
sudo cp visdom/visdom /bin/visdom
sudo chmod +x /bin/visdom

# Setup VS Code
cp vscode/keybindings.json $HOME/.config/Code/User/keybindings.json
cp vscode/settings.json $HOME/.config/Code/User/settings.json

# Make directory for bundles
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vim/vimrc ~/.vimrc
vim +PluginInstall!

#####################################################
#
# Config Personal Environment
#
#####################################################

# Install Vim 8.0
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

# Setup git
cp git/gitconfig ~/.gitconfig

# Setup imgur 
sudo cp imgur/imgur /bin/imgur
sudo chmod +x /bin/imgur

# Make directory for bundles
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vim/vimrc ~/.vimrc
vim +PluginInstall!

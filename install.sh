#####################################################
#
# Install Vim and configure git
#
#####################################################

# Install Vim 8.0
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

# Setup git
cp git/gitconfig ~/.gitconfig

# Make directory for bundles
mkdir ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vim/vimrc ~/.vimrc
vim +PluginInstall!

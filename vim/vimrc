set nocompatible              " be iMproved, required
filetype off                  " required

" General
set number
set encoding=utf-8
set showcmd
set splitright
set nowrap
set noswapfile                " Yeah no backups 
set tabstop=4 shiftwidth=4
set smartindent
set expandtab
set lazyredraw
set updatetime=100
set colorcolumn=80
highlight colorcolumn ctermbg=DarkBlue

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Resizing Splits
nnoremap <S-Right> <C-W><lt>
nnoremap <S-Left>  <C-W>>
nnoremap <S-Up>    <C-W>+
nnoremap <S-Down>  <C-W>-


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'davidhalter/jedi-vim'
Plugin 'shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'nvie/vim-flake8'
Plugin 'w0rp/ale'
Plugin 'vim-scripts/comments.vim'
Plugin 'blueyed/vim-diminactive'
Plugin 'junegunn/goyo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'easymotion/vim-easymotion'
call vundle#end()            " required

filetype plugin indent on    " required

" NerdTree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeQuitOnOpen = 1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" YCM & Jedi - Padawan I always shall be
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:jedi#use_splits_not_buffers = "right"
let g:deoplete#enable_at_startup = 1

" Goyo
let g:goyo_width = 140
let g:goyo_width = 90
let g:goyo_linenr = 1

" Ctrl-P
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Easymotion
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Misc
map <leader>t :redraw!<CR>
nmap <F8> :TagbarToggle<CR>

" ColorScheme
syntax enable
colorscheme monokai
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$/

" Python Stuff
map <Leader>p :call InsertLine()<CR>

function! InsertLine()
  let trace = expand("import ipdb; ipdb.set_trace()")
  execute "normal o".trace
endfunction

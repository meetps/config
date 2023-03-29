local vim = vim
local api = vim.api

vim.opt.compatible = false
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.showcmd = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.tabstop=2 
vim.opt.shiftwidth=2
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.lazyredraw = true
vim.opt.updatetime=100
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

api.nvim_command [[filetype on]]
api.nvim_command [[set colorcolumn=80]]
api.nvim_command [[highlight colorcolumn ctermbg=DarkBlue]]

api.nvim_command [[nnoremap <C-J> <C-W><C-J>]]
api.nvim_command [[nnoremap <C-K> <C-W><C-K>]]
api.nvim_command [[nnoremap <C-L> <C-W><C-L>]]
api.nvim_command [[nnoremap <C-H> <C-W><C-H>]]

api.nvim_command [[nnoremap <Tab> :bnext<CR>]]
api.nvim_command [[nnoremap <S-Tab> :bprevious<CR>]]

api.nvim_command [[nnoremap <S-Right> <C-W><lt>]]
api.nvim_command [[nnoremap <S-Left>  <C-W>>]]
api.nvim_command [[nnoremap <S-Up>    <C-W>+]]
api.nvim_command [[nnoremap <S-Down>  <C-W>-]]

require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
end)

require("packer").startup(function(use)
  use({'wbthomason/packer.nvim'})
  use({"nvim-telescope/telescope.nvim", tag = "0.1.1", requires = {{'nvim-lua/plenary.nvim'}}})
  use("ojroques/nvim-osc52")
  use("nvim-lua/plenary.nvim")
  use("nvim-tree/nvim-tree.lua")
  -- CiderLSP
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-vsnip")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/vim-vsnip")
  use("neovim/nvim-lspconfig")
  use("onsails/lspkind.nvim")
  use("easymotion/vim-easymotion")
  -- Diagnostics
  use("nvim-lualine/lualine.nvim")
  use("nvim-tree/nvim-web-devicons")
  use("blueyed/vim-diminactive")
  use("junegunn/goyo.vim")
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
  use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"})
end)

local function get_current_workspace()
  return string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd(), '')
end

api.nvim_command [[colorscheme monokai]]
api.nvim_command [[map <C-n> :NvimTreeToggle <CR>]]
api.nvim_command [[map <C-t> :Telescope <CR>]]

api.nvim_command [[map  <Leader>f <Plug>(easymotion-bd-f)]]
api.nvim_command [[nmap <Leader>f <Plug>(easymotion-overwin-f)]]
api.nvim_command [[map <Leader>L <Plug>(easymotion-bd-jk)]]
api.nvim_command [[nmap <Leader>L <Plug>(easymotion-overwin-line)]]
api.nvim_command [[map  <Leader>w <Plug>(easymotion-bd-w)]]
api.nvim_command [[nmap <Leader>w <Plug>(easymotion-overwin-w)]]

api.nvim_command [[let g:goyo_width = 240]]
api.nvim_command [[let g:goyo_linenr = 1]]
api.nvim_command [[map <F9> :Goyo<CR>]]
api.nvim_command [[map <leader>t :redraw!<CR>]]

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


require("telescope").setup()
require("nvim-web-devicons").setup()
require("bufferline").setup{
  options = {
    numbers = "buffer_id",
    indicator = { icon = '', style = 'none' },
    max_name_length = 30,
    middle_mouse_command = 'vsp %d'
  }
}
require("nvim-tree").setup()
require("lsp") -- CiderLSP
require("diagnostics") -- Diagnostics
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '|', right = '|'},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
 --   lualine_c = {'filename'},
    lualine_c = { hello },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

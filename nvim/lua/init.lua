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
api.nvim_command [[set colorcolumn=88]]
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

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-telescope/telescope.nvim", tag = "0.1.1", requires = { 'nvim-lua/plenary.nvim' } },
  "ojroques/nvim-osc52",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-tree.lua",
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-nvim-lua", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-vsnip", lazy = true },
  { "hrsh7th/nvim-cmp", lazy = true },
  { "hrsh7th/vim-vsnip", lazy = true },
  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",
  "easymotion/vim-easymotion",
  "nvim-lualine/lualine.nvim",
  "nvim-tree/nvim-web-devicons",
  "blueyed/vim-diminactive",
  "junegunn/goyo.vim",
  { "akinsho/bufferline.nvim", tag = "v3.7.0", requires = 'nvim-tree/nvim-web-devicons' },
  { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }
})

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
require("nvim-tree").setup({
    filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { '.ruff_cache', '.git' },
    },
})

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


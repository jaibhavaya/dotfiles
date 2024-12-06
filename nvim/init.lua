-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Ensure Packer is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Initialize Packer and Plugins
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Packer manages itself
  use 'tpope/vim-sensible'
  use 'vim-ruby/vim-ruby'
  use 'tpope/vim-rails'
  use 'tpope/vim-fugitive'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'preservim/nerdtree'
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-commentary'
  use 'sainnhe/everforest'
  use 'morhetz/gruvbox'
	use "tpope/vim-endwise"
  use { 'neoclide/coc.nvim', branch = 'release' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Detect the current directory and set the colorscheme accordingly
local cwd = vim.fn.getcwd()

if cwd:match("boost%-client") then
  -- Enable termguicolors if available
  if vim.fn.has("termguicolors") == 1 then
    vim.opt.termguicolors = true
  end

  -- Set background to dark or light
  vim.opt.background = "dark" -- Use "light" for light version

  -- Set contrast for Everforest
  -- Available values: 'hard', 'medium' (default), 'soft'
  vim.g.everforest_background = "hard"

  -- Enable better performance for Everforest
  vim.g.everforest_better_performance = 1
  -- Apply the Everforest colorscheme
  vim.cmd("colorscheme everforest")
else
  -- Set the background to light
  vim.opt.background = "dark"

  -- Customize Gruvbox options
  vim.g.gruvbox_contrast_light = "hard" -- Available values: 'hard', 'medium', 'soft' (default)
  vim.g.gruvbox_invert_selection = false -- Prevents inverted selection for better readability
  vim.cmd("colorscheme gruvbox")
end

-- Basic Settings
vim.o.number = true -- Line numbers
vim.o.hlsearch = true -- Highlight search
vim.o.termguicolors = true -- Enable 24-bit RGB colors

-- Key Mappings
vim.api.nvim_set_keymap('n', '-', ':NERDTreeToggle<CR>', { noremap = true, silent = true }) -- Toggle NERDTree
vim.api.nvim_set_keymap('n', '<S-CR>', ':FZF<CR>', { noremap = true, silent = true }) -- Open FZF

-- Coc
vim.g.coc_global_extensions = { 'coc-tsserver', 'coc-solargraph' }
vim.api.nvim_set_var("coc_root_patterns", {".git", "tsconfig.json", "package.json"})
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { noremap = false, silent = true })

vim.api.nvim_set_keymap(
  'i',
  '<Tab>',
  'pumvisible() ? "\\<C-n>" : "\\<Tab>"',
  { noremap = true, expr = true, silent = true }
)
vim.api.nvim_set_keymap(
  'i',
  '<S-Tab>',
  'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"',
  { noremap = true, expr = true, silent = true }
)
vim.api.nvim_set_keymap(
  'i',
  '<CR>',
  'pumvisible() ? coc#pum#confirm() : "\\<CR>"',
  { noremap = true, expr = true, silent = true }
)
vim.api.nvim_set_keymap(
  'i',
  '<Esc>',
  'pumvisible() ? coc#pum#cancel() : "\\<Esc>"',
  { noremap = true, expr = true, silent = true }
)

-- FZF Configuration
vim.g.fzf_action = {
  ['ctrl-t'] = 'tabedit',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

require('keymaps')
require('commands')
require('ruby')
require('typescript')


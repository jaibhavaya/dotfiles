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
  use 'mhartington/oceanic-next'
  use { 'neoclide/coc.nvim', branch = 'release' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Basic Settings
vim.o.number = true -- Line numbers
vim.o.hlsearch = true -- Highlight search
vim.o.termguicolors = true -- Enable 24-bit RGB colors
vim.cmd('colorscheme OceanicNext') -- Theme

-- Key Mappings
vim.api.nvim_set_keymap('n', '-', ':NERDTreeToggle<CR>', { noremap = true, silent = true }) -- Toggle NERDTree
vim.api.nvim_set_keymap('n', '<S-CR>', ':FZF<CR>', { noremap = true, silent = true }) -- Open FZF
vim.api.nvim_set_keymap('n', '<leader>m', ':mksession! /tmp/vim_session.vim<CR><C-w>o', { noremap = true, silent = true }) -- Save session
vim.api.nvim_set_keymap('n', '<leader>r', ':source /tmp/vim_session.vim<CR>', { noremap = true, silent = true }) -- Reload session
vim.api.nvim_set_keymap('n', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true }) -- Commenting
vim.api.nvim_set_keymap('n', '<leader>c', ':w !pbcopy<CR>', { noremap = true, silent = true }) -- Copy buffer to clipboard
vim.api.nvim_set_keymap('v', '<leader>c', ':w !pbcopy<CR>', { noremap = true, silent = true }) -- Copy buffer to clipboard

-- Language-Specific Settings

-- Ruby
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ruby', 'eruby' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.commentstring = '# %s'
  end,
})

-- TypeScript
vim.g.coc_global_extensions = { 'coc-tsserver' }
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typescript',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Coc Key Bindings
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { noremap = false, silent = true })

-- Coc Completion Menu
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

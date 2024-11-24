vim.cmd('source ~/.vimrc')
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

-- Initialize Packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Function to create a React component
local function create_react_component(name)
  local component_name = name or "MyComponent"
  local file_name = component_name .. ".tsx"

  local current_dir = vim.fn.expand("%:p:h")
  local file_path = current_dir .. "/" .. file_name

  if vim.fn.filereadable(file_path) == 1 then
    vim.api.nvim_err_writeln("File " .. file_name .. " already exists!")
    return
  end

  local boilerplate = {
    "import React from 'react';",
    "",
    "const " .. component_name .. " = () => {",
    "  console.log('in component');",
    "  return (",
    "    <div>Hello World</div>",
    "  );",
    "};",
    "",
    "export default " .. component_name .. ";",
  }

  vim.fn.writefile(boilerplate, file_path)

  vim.cmd("edit " .. file_path)
end

-- Define the `:Rc` command in Neovim
vim.api.nvim_create_user_command("Rc", function(opts)
  create_react_component(opts.args)
end, { nargs = "?" })


-- Set tab width to 2 spaces
vim.o.tabstop = 2       -- A tab is displayed as 2 spaces
vim.o.shiftwidth = 2    -- Indentation uses 2 spaces
vim.o.expandtab = true  -- Convert tabs to spaces

vim.api.nvim_set_keymap('i', '<Esc>', 'pumvisible() ? "\\<C-e>\\<Esc>" : "\\<Esc>"', { noremap = true, expr = true })

vim.api.nvim_create_user_command("EInit", function()
  vim.cmd("edit ~/.config/nvim/init.lua")
end, {})

vim.api.nvim_set_keymap("n", "<C-S-f>", ":Rg<CR>", { noremap = true, silent = true })

-- Map Ctrl-S to save in normal mode
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
-- Map Ctrl-S to save in insert mode
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>i", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "i",
  "<CR>",
  [[pumvisible() ? coc#pum#confirm() : "\<CR>"]],
  { noremap = true, expr = true, silent = true }
)

-- FZF Configuration for custom actions
vim.g.fzf_action = {
  ['ctrl-t'] = 'tabedit',      -- Open in a new tab
  ['ctrl-x'] = 'split',       -- Open in a horizontal split
  ['ctrl-v'] = 'vsplit',      -- Open in a vertical split
}

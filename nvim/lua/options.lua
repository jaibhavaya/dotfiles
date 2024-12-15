vim.g.mapleader = " "
vim.cmd("let g:netrw_liststyle = 3")

-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.termguicolors = true -- Enable 24-bit RGB colors

vim.opt.wrap = false

-- Default colorcolumn for all files
vim.opt.colorcolumn = "120"

-- Set colorcolumn for Ruby files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.colorcolumn = "100"
  end,
})

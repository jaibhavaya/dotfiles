-- Maximizing / Minimizing vim panels
vim.api.nvim_set_keymap('n', '<leader>m', ':mksession! /tmp/vim_session.vim<CR><C-w>o', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':source /tmp/vim_session.vim<CR>', { noremap = true, silent = true })

-- Copy to clipboard (normal + visual modes)
vim.api.nvim_set_keymap('n', '<leader>c', ':w !pbcopy<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':w !pbcopy<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true }) -- Commenting
vim.api.nvim_set_keymap('v', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true }) -- Commenting

vim.keymap.set('n', '<leader>T', vim.cmd.UndotreeToggle)

-- replace selection/word with register without overwriting register
vim.api.nvim_set_keymap('n', '<leader>p', '"_diwP', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"_dP', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

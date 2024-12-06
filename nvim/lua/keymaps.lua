-- Maximizing / Minimizing vim panels
vim.api.nvim_set_keymap('n', '<leader>m', ':mksession! /tmp/vim_session.vim<CR><C-w>o', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':source /tmp/vim_session.vim<CR>', { noremap = true, silent = true })

-- Copy to clipboard (normal + visual modes)
vim.api.nvim_set_keymap('n', '<leader>c', ':w !pbcopy<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':w !pbcopy<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true }) -- Commenting

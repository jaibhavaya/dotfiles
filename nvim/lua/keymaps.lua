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

-- Close all unmodified buffers except the current one
vim.keymap.set("n", "<leader>bc", function()
  local current_buf = vim.api.nvim_get_current_buf() -- Get the current buffer ID
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) and not vim.bo[buf].modified then
      vim.cmd("bdelete " .. buf)
    end
  end
end, { desc = "Close all unmodified buffers except the current one" })

vim.keymap.set('n', '<leader>uu', ':e!<CR>', { noremap = true, silent = true, desc = 'Reload buffer discarding changes' })
vim.keymap.set('n', '<leader>s',':wa<CR>', { noremap = true, silent = true, desc = 'Reload buffer discarding changes' })

-- Initialize Go DAP setup (after your other require statements)
require('dap-go').setup()
require('dapui').setup()

-- Debugging keymaps
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>do', function() require('dapui').open() end)
vim.keymap.set('n', '<leader>dx', function() require('dapui').close() end)

-- Telescope for Go
vim.keymap.set('n', '<leader>gfs', '<cmd>Telescope lsp_document_symbols<CR>')
vim.keymap.set('n', '<leader>gws', '<cmd>Telescope lsp_workspace_symbols<CR>')

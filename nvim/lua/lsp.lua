local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

_G.on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, opts)
end

-- Add to your on_attach function or in a separate Go-specific section
local go_on_attach = function(client, bufnr)
  on_attach(client, bufnr)  -- Call your existing on_attach

  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>gI', '<cmd>GoImports<CR>', opts)  -- Only if using vim-go
  vim.keymap.set('n', '<leader>gd', '<cmd>GoDoc<CR>', opts)      -- Only if using vim-go
  vim.keymap.set('n', '<leader>gr', '<cmd>GoRun<CR>', opts)      -- Only if using vim-go
  vim.keymap.set('n', '<leader>gb', '<cmd>GoBuild<CR>', opts)    -- Only if using vim-go
end

lspconfig.eslint.setup({
  on_attach = on_attach,
  root_dir = require('lspconfig.util').root_pattern(".eslintrc", ".eslintrc.js", "package.json", ".git"),
})

lspconfig.ts_ls.setup({
  on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
    preferences = {
      importModuleSpecifierPreference = "non-relative", -- Use non-relative imports
    }
  }
})
lspconfig.solargraph.setup({
  on_attach = on_attach,
	capabilities = capabilities,
  -- ...
})

-- Go LSP setup
lspconfig.gopls.setup({
  on_attach = go_on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,    -- Stricter formatting
    },
  },
})

local cmp = require('cmp')

cmp.setup({
  -- Enable snippet support (required if using snippets)
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  -- Key mappings
  mapping = cmp.mapping.preset.insert({
    -- Move to next item
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Move to previous item
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Confirm selection
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),

  -- The completion sources
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    -- more sources...
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.fixAll.eslint" } },  -- Tells ESLint to apply fixes
      apply = true,                                     -- Automatically apply the fixes
    })
  end,
})

-- Format Go files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Format Ruby files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rb", "*.rake", "*.ru", "Gemfile" },
  callback = function()
    -- Format with Solargraph if available
    vim.lsp.buf.format({ async = false })
  end,
})

-- Trim trailing whitespace on save for all file types
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",  -- Matches all file types
  callback = function()
    -- Save cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    
    -- Trim trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    
    -- Restore cursor position (only if the buffer still exists)
    if vim.api.nvim_buf_is_valid(0) then
      -- Ensure we don't position cursor outside buffer bounds after trimming
      local line_count = vim.api.nvim_buf_line_count(0)
      if cursor_pos[1] > line_count then
        cursor_pos[1] = line_count
      end
      vim.api.nvim_win_set_cursor(0, cursor_pos)
    end
  end,
})

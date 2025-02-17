local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, opts)
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

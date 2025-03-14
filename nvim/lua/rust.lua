-- Rust-tools setup (add this after your existing LSP configurations)
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(client, bufnr)
      -- Reuse your existing on_attach function
      on_attach(client, bufnr)
      
      -- Add Rust-specific keymaps
      local opts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, opts)
      vim.keymap.set("n", "<leader>rd", rt.debuggables.debuggables, opts)
      vim.keymap.set("n", "<leader>re", rt.expand_macro.expand_macro, opts)
      vim.keymap.set("n", "<leader>rc", rt.open_cargo_toml.open_cargo_toml, opts)
      vim.keymap.set("n", "<leader>rh", rt.hover_actions.hover_actions, opts)
      vim.keymap.set("n", "<leader>rt", function()
        vim.cmd("RustOpenExternalDocs")
      end, opts)
    end,
    capabilities = capabilities, -- Reuse your existing capabilities
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",  -- Use clippy for more thorough checks
        },
        cargo = {
          allFeatures = true,  -- Enable all cargo features
        },
        procMacro = {
          enable = true,       -- Enable procedural macro support
        },
        inlayHints = {         -- Enable useful inline hints
          enable = true,
          parameterHints = true,
          typeHints = true,
        },
      },
    },
  },
  tools = {
    inlay_hints = {
      auto = true,
    },
    hover_actions = {
      auto_focus = true,
    },
  },
})

-- Set up crates.nvim (optional but recommended for Cargo.toml management)
require('crates').setup({
  popup = {
    autofocus = true,
  },
  null_ls = {
    enabled = true,
  },
})

-- Format Rust files on save (optional)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

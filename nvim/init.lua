require("options")

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

	-- LSP
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'          -- The completion plugin
	use 'hrsh7th/cmp-nvim-lsp'      -- LSP source for nvim-cmp
	use 'hrsh7th/cmp-buffer'        -- Buffer completions
	use 'hrsh7th/cmp-path'          -- Path completions
	use 'hrsh7th/cmp-cmdline'       -- Cmdline completions
	use 'L3MON4D3/LuaSnip'          -- Snippet engine
	use 'saadparwaiz1/cmp_luasnip'  -- Snippet completions
	use 'tommcdo/vim-exchange'

  use 'tpope/vim-sensible'
  use 'vim-ruby/vim-ruby'
  use 'tpope/vim-rails'
  use 'tpope/vim-fugitive'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use {
		'nvim-tree/nvim-tree.lua',
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			vim.opt.termguicolors = true

			require("nvim-tree").setup({
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = false,
				},
				git = {
					ignore = false
				},
			})
		end,
		requires = {
			'nvim-tree/nvim-web-devicons',
		},
	}
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-commentary'
  use 'sainnhe/everforest'
  use 'morhetz/gruvbox'
	use "tpope/vim-endwise"
	use 'lewis6991/gitsigns.nvim'
	use 'nvim-treesitter/nvim-treesitter-context'
	use 'nvim-treesitter/nvim-treesitter'
	use 'ThePrimeagen/harpoon'
	use {
		"jaibhavaya/todo-nvim",
		config = function()
			require("todo-nvim").setup()
		end
	}
	use {
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			-- Set timeout settings
			vim.o.timeout = true
			vim.o.timeoutlen = 300 -- Delay in milliseconds

			-- Setup which-key with timeoutlen
			require("which-key").setup {
				timeoutlen = 300, -- Ensure consistency with vim.o.timeoutlen
			}
		end,
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	use {
		"SunnyTamang/select-undo.nvim",
		config = function()
			require("select-undo").setup()
		end
	}

	-- Required for avante
  use 'stevearc/dressing.nvim'
  use 'MunifTanjim/nui.nvim'
  use 'MeanderingProgrammer/render-markdown.nvim'

  -- Optional dependencies
  use 'HakonHarnes/img-clip.nvim'
  use 'zbirenbaum/copilot.lua'

  use {
    'yetone/avante.nvim',
    branch = 'main',
    run = 'make',
    config = function()
      require('avante_lib').load()
      require('avante').setup()
    end
  }

	use 'rachartier/tiny-glimmer.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 100,
			tabline = 100,
			winbar = 100,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<A-Tab>", "copilot#Accept('<CR>')", { silent = true, expr = true })

-- Set the background to light
vim.opt.background = "dark"

-- Customize Gruvbox options
vim.g.gruvbox_contrast_light = "hard" -- Available values: 'hard', 'medium', 'soft' (default)
vim.g.gruvbox_invert_selection = false -- Prevents inverted selection for better readability
vim.cmd("colorscheme gruvbox")

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

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next, 
        ["<C-k>"] = require('telescope.actions').move_selection_previous, 
        ["<C-q>"] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true -- Show hidden files
    },
  },
}
vim.api.nvim_set_keymap('n', '<leader>gb', ':Telescope git_branches<CR>', { noremap = true, silent = true })
require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope oldfiles<CR>', { noremap = true, silent = true })

-- git
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gvdiffsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Git pull<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gB', ':Git blame<CR>', { noremap = true, silent = true })

-- harpoon
-- Import Harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
require('harpoon').setup({ menu = { width = 100 }})

-- Add the current file to Harpoon
vim.api.nvim_set_keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hr', ':lua require("harpoon.mark").rm_file()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>hc", ':lua require("harpoon.mark").clear_all()<CR>', { noremap = true, silent = true })


-- Toggle the Harpoon menu
vim.api.nvim_set_keymap('n', '<leader>hm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })

-- Navigate to Harpoon files (1-4 as an example)
vim.api.nvim_set_keymap('n', '<leader>h1', ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h2', ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h3', ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h4', ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })

-- Navigate between Harpoon files
vim.api.nvim_set_keymap('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.lsp.buf.format = function() end
  end,
})

-- nvim-cmp setup
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- example mappings
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    -- more sources
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})

require('keymaps')
require('commands')
require('ruby')
require('typescript')
require('lsp')
require('plugins.nvim-tree')

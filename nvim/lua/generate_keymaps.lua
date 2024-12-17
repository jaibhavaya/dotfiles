local M = {}

-- Function to generate keymaps file
M.generate_keymaps = function()
  local keymaps = {
    {
      category = "General",
      mappings = {
        { mode = "n", keys = "<leader>\\", description = "Toggle comments in normal mode" },
        { mode = "v", keys = "<leader>\\", description = "Toggle comments in visual mode" },
        { mode = "n", keys = "<C-d>", description = "Scroll down and center" },
        { mode = "n", keys = "<C-u>", description = "Scroll up and center" },
        { mode = "n", keys = "<leader>p", description = "Replace word with register without overwriting it" },
        { mode = "v", keys = "<leader>p", description = "Replace selection with register without overwriting it" },
      },
    },
    {
      category = "File Management",
      mappings = {
        { mode = "n", keys = "-", description = "Toggle NERDTree in current file's directory" },
        { mode = "n", keys = "<leader>c", description = "Copy current file content to clipboard (normal)" },
        { mode = "v", keys = "<leader>c", description = "Copy selection to clipboard (visual)" },
        { mode = "n", keys = "<leader>m", description = "Maximize panel and save session" },
        { mode = "n", keys = "<leader>r", description = "Restore maximized session" },
        { mode = "n", keys = ":Scr", description = "Create a temporary scratch file" },
      },
    },
    {
      category = "Telescope",
      mappings = {
        { mode = "n", keys = "<leader>ff", description = "Find files" },
        { mode = "n", keys = "<leader>fg", description = "Live grep" },
        { mode = "n", keys = "<leader>fb", description = "List open buffers" },
        { mode = "n", keys = "<leader>fh", description = "Find recently opened files" },
        { mode = "n", keys = "<leader>gb", description = "Browse Git branches" },
      },
    },
    {
      category = "Git",
      mappings = {
        { mode = "n", keys = "<leader>gs", description = "Open Git status" },
        { mode = "n", keys = "<leader>gd", description = "Git diff" },
        { mode = "n", keys = "<leader>gc", description = "Git commit" },
        { mode = "n", keys = "<leader>gp", description = "Git push" },
        { mode = "n", keys = "<leader>gl", description = "Git pull" },
        { mode = "n", keys = "<leader>gB", description = "Git blame" },
      },
    },
    {
      category = "Harpoon",
      mappings = {
        { mode = "n", keys = "<leader>ha", description = "Add file to Harpoon" },
        { mode = "n", keys = "<leader>hm", description = "Toggle Harpoon menu" },
        { mode = "n", keys = "<leader>h1", description = "Navigate to Harpoon file 1" },
        { mode = "n", keys = "<leader>hn", description = "Navigate to next Harpoon file" },
      },
    },
		{
			category = "Copilot",
			mappings = {
				{ mode = "i", keys = "<A-Tab>", command = "copilot#Accept('<CR>')", description = "Accept Copilot suggestion" },
			},
		}
  }

  local filepath = vim.fn.stdpath("config") .. "/KEYMAPS.md"
  local file = io.open(filepath, "w")

  if not file then
    vim.api.nvim_err_writeln("Failed to write keymaps to " .. filepath)
    return
  end

  file:write("# Neovim Keymaps\n\n")

  for _, section in ipairs(keymaps) do
    file:write("## " .. section.category .. "\n\n")
    for _, map in ipairs(section.mappings) do
      file:write("- **Mode**: `" .. map.mode .. "` | **Keys**: `" .. map.keys .. "` | **Description**: " .. map.description .. "\n")
    end
    file:write("\n")
  end

  file:close()
  print("Keymaps saved to " .. filepath)
end

return M

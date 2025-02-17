-- Edit neovim config
vim.api.nvim_create_user_command('EConfig', function()
  local config_path = vim.fn.stdpath('config')
  vim.cmd('e ' .. config_path .. '/init.lua')
end, {})

-- Create new file in current directory
vim.api.nvim_create_user_command("Nf", function(opts)
  local new_file = opts.args
  local current_file_dir = vim.fn.expand("%:p:h")  -- Get current file's directory
  local base_dir = current_file_dir ~= "" and current_file_dir or vim.loop.os_homedir()  -- Use current file dir or home dir
  local full_path = vim.fn.expand(base_dir .. "/" .. new_file)  -- Full path to new file

  -- Create the directory if it doesn't exist
  vim.fn.mkdir(vim.fn.fnamemodify(full_path, ":h"), "p")

  -- Open the new file
  vim.cmd("edit " .. full_path)
end, { nargs = 1, desc = "Create and edit a new file in the current directory or home if none" })

vim.api.nvim_create_user_command(
  'Cpf',
  function()
    local filepath = vim.fn.expand('%:p')
    vim.fn.setreg('+', filepath) -- Copy to system clipboard
    print('File path copied to clipboard: ' .. filepath)
  end,
  {}
)

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

local function create_scratch_file(extension)
  -- Generate a unique filename
  local unique_name = tostring(math.random(100000000, 999999999))
  local file_extension = extension or ".txt"
  local file_name = unique_name .. file_extension
  local file_path = "/tmp/" .. file_name

  -- Create the file (empty)
  local file = io.open(file_path, "w")
  if file then
    file:close()
  else
    vim.api.nvim_err_writeln("Failed to create scratch file: " .. file_path)
    return
  end

  -- Open the file in Neovim
  vim.cmd("edit " .. file_path)
end

-- Create the :Scr command
vim.api.nvim_create_user_command("Scr", function(opts)
  local extension = opts.args ~= "" and opts.args or nil
  create_scratch_file(extension)
end, {
  nargs = "?",
})

vim.api.nvim_create_user_command("NextColumn", function(opts)
    require("csvview.jump").next_field_start()
end, {
    nargs = "?",
})

vim.api.nvim_create_user_command("PrevColumn", function(opts)
    require("csvview.jump").prev_field_start()
end, {
    nargs = "?",
})

-- Enable csvview only once when filetype is set
vim.api.nvim_create_autocmd("FileType", {
    pattern = "csv",
    desc = "Enable CSV View on .csv files",
    callback = function()
        require("csvview").enable()
    end,
})

-- Manage keymaps when entering/leaving CSV buffers
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.csv",
    desc = "Set CSV keymaps when entering CSV files",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'w', ':NextColumn<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'b', ':PrevColumn<CR>', { noremap = true, silent = true })
    end,
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*.csv",
    desc = "Remove CSV keymaps when leaving CSV files",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        pcall(vim.api.nvim_buf_del_keymap, bufnr, 'n', 'w')
        pcall(vim.api.nvim_buf_del_keymap, bufnr, 'n', 'b')
    end,
})

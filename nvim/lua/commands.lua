-- Edit neovim config
vim.api.nvim_create_user_command('EConfig', function()
  vim.cmd('e ~/.config/nvim/init.lua')
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


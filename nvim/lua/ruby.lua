vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ruby', 'eruby' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.commentstring = '# %s'
  end,
})

local function remove_binding_pry()
  local results = vim.fn.systemlist("rg --no-heading --line-number 'binding\\.pry'")

  for _, result in ipairs(results) do
    local file, line = result:match("([^:]+):(%d+)")
    if file and line then
      vim.cmd(string.format("e %s", file)) -- Open the file
      vim.cmd(string.format("%sdelete", line)) -- Delete the specific line
      vim.cmd("write") -- Save the file
    end
  end
end

vim.api.nvim_create_user_command("Byepry", remove_binding_pry, {})

vim.keymap.set("n", "<leader>rt", function()
    -- Get the current file path
    local file = vim.fn.expand("%")
    -- Run `bundle exec rspec` for the current file
    vim.cmd("terminal echo 'running " .. file .. " ¯\\_(ツ)_/¯\\n'; bundle exec rspec " .. file)
end, { desc = "Run bundle exec rspec on the current file" })

vim.keymap.set("n", "<leader>rl", function()
    -- Get the current file path and the line number
    local file = vim.fn.expand("%")
    local line = vim.fn.line(".")
    -- Run `bundle exec rspec` for the current file and line
    vim.cmd("terminal echo 'running " .. file .. ":" .. line .. " ¯\\_(ツ)_/¯\\n'; bundle exec rspec " .. file .. ":" .. line)
end, { desc = "Run bundle exec rspec on the current test line" })

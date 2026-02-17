local function check_version()
  local ver = tostring(vim.version())
  if vim.fn.has 'nvim-0.12.0' == 1 then
    vim.health.ok('Neovim version: ' .. ver)
  else
    vim.health.error('Neovim outdated: ' .. ver)
  end
end

local function check_external_reqs()
  for _, exe in ipairs {
    'git',
    'make',
    'unzip',
    'rg',
    'fd',
    'fzf',
    'tree-sitter',
    'node',
  } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok('Found: ' .. exe)
    else
      vim.health.warn('Could not find: ' .. exe)
    end
  end
end

local M = {}

M.check = function()
  vim.health.start 'config'
  vim.health.info('Printing system information and checking external dependencies...\nSystem Information:\n' .. vim.inspect(vim.uv.os_uname()))

  check_version()
  check_external_reqs()
end

return M

-- vim: ts=2 sts=2 sw=2 et

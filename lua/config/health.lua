local function check_version()
  local ver = tostring(vim.version())
  if vim.fn.has 'nvim-0.11.2' == 1 then
    vim.health.ok("Neovim version is: '" .. ver .. "'")
  else
    vim.health.error("Neovim out of date: '" .. ver .. "'. Upgrade to latest stable or nightly")
  end
end

local function check_external_reqs()
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg', 'fzf' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok("Found executable: '" .. exe .. "'")
    else
      vim.health.warn("Could not find executable: '" .. exe .. "'")
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

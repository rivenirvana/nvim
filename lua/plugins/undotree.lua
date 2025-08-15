---@module 'lazy'
---@type LazySpec
return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  keys = {
    { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle Undotree' },
  },
}

-- vim: ts=2 sts=2 sw=2 et

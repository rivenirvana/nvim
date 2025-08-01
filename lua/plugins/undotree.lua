---@module 'lazy'
---@type LazySpec
return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Toggle [U]ndotree' },
  },
}

-- vim: ts=2 sts=2 sw=2 et

---@module 'lazy'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  main = 'ibl',
  ---@module 'ibl'
  ---@type ibl.config
  opts = {},
}

-- vim: ts=2 sts=2 sw=2 et

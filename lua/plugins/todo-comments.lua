---@module 'lazy'
---@type LazySpec
return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  ---@module 'todo-comments'
  ---@type TodoOptions
  opts = { signs = false },
}

-- vim: ts=2 sts=2 sw=2 et

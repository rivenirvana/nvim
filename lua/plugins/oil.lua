---@module 'lazy'
---@type LazySpec
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ['<Esc>'] = { 'actions.close', mode = 'n' },
      ['q'] = { 'actions.close', mode = 'n' },
    },
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      -- 'echasnovski/mini.icons',
      opts = {},
    },
  },
  lazy = false,
  keys = {
    { '-', '<CMD>Oil --float<CR>', desc = 'Oil: Open parent directory' },
  },
}

-- vim: ts=2 sts=2 sw=2 et

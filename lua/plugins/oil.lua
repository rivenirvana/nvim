---@module 'lazy'
---@type LazySpec
return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', opts = {} }, -- 'echasnovski/mini.icons',
  },
  -- ---@module 'oil'
  -- ---@type oil.SetupOpts
  -- opts = {},
  config = function()
    local oil = require 'oil'
    oil.setup {
      keymaps = {
        ['<Esc>'] = { 'actions.close', mode = 'n' },
        ['q'] = { 'actions.close', mode = 'n' },
      },
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '-', oil.open_float, { desc = 'Oil: Open Parent Directory' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et

---@module 'lazy'
---@type LazySpec
return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    { 'nvim-mini/mini.icons', opts = {} },
  },
  init = function() vim.g.oil_detail = false end,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ['<Esc>'] = { 'actions.close', mode = 'n' },
      ['q'] = { 'actions.close', mode = 'n' },
      ['gd'] = {
        desc = 'Toggle file details',
        callback = function()
          vim.g.oil_detail = not vim.g.oil_detail
          if vim.g.oil_detail then
            require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
          else
            require('oil').set_columns { 'icon' }
          end
        end,
      },
    },
    view_options = {
      show_hidden = true,
    },
  },
  config = function(_, opts)
    local oil = require 'oil'
    oil.setup(opts)
    vim.keymap.set('n', '-', oil.open_float, { desc = 'Oil: Open Parent Directory' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et

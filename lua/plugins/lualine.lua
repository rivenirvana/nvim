---@module 'lazy'
---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/noice.nvim',
  },
  config = function()
    local noice = require 'noice'
    require('lualine').setup {
      sections = {
        lualine_b = {
          { 'branch', separator = ' ', padding = { left = 1, right = 0 } },
          { 'diff', padding = { left = 0, right = 1 } },
          { 'lsp_status', separator = ' ', padding = { left = 1, right = 0 } },
          { 'diagnostics', padding = { left = 0, right = 1 } },
        },
        lualine_c = {
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          {
            'filename',
            newfile_status = true,
            path = 1,
          },
          {
            noice.api.status.mode.get,
            cond = noice.api.status.mode.has,
            color = { fg = '#ff9e64' },
          },
        },
        lualine_x = {
          'selectioncount',
          'searchcount',
          -- {
          --   noice.api.status.search.get,
          --   cond = noice.api.status.search.has,
          --   color = { fg = '#ff9e64' },
          -- },
          'filesize',
          {
            'encoding',
            show_bomb = true,
          },
          'fileformat',
          -- {
          --   noice.api.status.message.get_hl,
          --   cond = noice.api.status.message.has,
          --   color = { fg = '#ff9e64' },
          -- },
          -- {
          --   noice.api.status.command.get,
          --   cond = noice.api.status.command.has,
          --   color = { fg = '#ff9e64' },
          -- },
        },
        lualine_y = {
          { 'progress', separator = '', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function() return ' ' .. os.date '%R' end,
        },
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et

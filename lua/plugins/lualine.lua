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
          'branch',
          'diff',
          'lsp_status',
          'diagnostics',
        },
        lualine_c = {
          {
            'filename',
            newfile_status = true,
            path = 3,
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
          {
            'encoding',
            show_bomb = true,
          },
          'fileformat',
          'filetype',
          'filesize',
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
          'location',
        },
        lualine_z = {
          'progress',
        },
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et

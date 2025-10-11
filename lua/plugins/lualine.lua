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
          'searchcount',
          {
            'encoding',
            show_bomb = true,
          },
          'fileformat',
          'filetype',
        },
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et

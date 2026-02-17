---@module 'lazy'
---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-mini/mini.icons',
    'folke/noice.nvim',
  },
  config = function()
    local noice = require 'noice'
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_b = {
          'branch',
          'lsp_status',
        },
        lualine_c = {
          { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
          {
            'filename',
            newfile_status = true,
            path = 1,
            padding = { left = 0, right = 1 },
            fmt = function(str, _) return vim.bo.filetype ~= '' and str or ' ' .. str end,
          },
          { noice.api.status.mode.get, cond = noice.api.status.mode.has, color = { fg = '#ff9e64' } },
        },
        lualine_x = {
          'selectioncount',
          'searchcount',
          'diff',
          'diagnostics',
          'filesize',
          'fileformat',
          { 'encoding', show_bomb = true, padding = { left = 0, right = 1 } },
        },
        lualine_y = {
          'progress',
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

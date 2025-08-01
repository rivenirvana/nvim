---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Load before all other plugins
    config = function()
      require('tokyonight').setup {
        -- transparent = true,
        dim_inactive = true,
        styles = {
          -- comments = { italic = false },
          sidebars = 'transparent',
          -- floats = 'transparent',
        },
      }

      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

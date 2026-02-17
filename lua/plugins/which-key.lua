---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  ---@type wk.Opts
  opts = {
    preset = 'helix',
    delay = 0,
    icons = { mappings = vim.g.has_nerd_font },

    spec = {
      { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
      { '<leader>N', group = 'Noice', mode = { 'n', 'v' } },
      { '<leader>t', group = 'Toggle' },
      { '<leader>x', group = 'Exec' },
      { '<leader>c', group = 'Conform' },
      { 'gr', group = 'LSP' },
    },

    -- Disable which-key popup when entering visual mode
    -- https://github.com/nvim-lua/kickstart.nvim/issues/1034#issuecomment-2238882133
    triggers = {
      { '<auto>', mode = 'nixsotc' },
      { '<leader>', mode = { 'v' } },
      { 'g', mode = { 'v' } },
      { 's', mode = { 'v' } },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

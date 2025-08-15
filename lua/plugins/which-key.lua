---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  ---@type wk.Opts
  opts = {
    delay = 200,
    icons = {
      mappings = vim.g.has_nerd_font,
      keys = vim.g.has_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },

    spec = {
      { '<leader>s', group = 'Search', mode = { 'n', 'v' } },
      { '<leader>t', group = 'Toggle' },
      { '<leader>x', group = 'Exec' },
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
      { 'gr', group = 'LSP', mode = { 'n' } },
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

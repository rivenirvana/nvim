---@module 'lazy'
---@type LazySpec
return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  dependencies = {
    'folke/lazydev.nvim',
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
      },
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- <c-y> to accept the completion.
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      preset = 'default',
      -- https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        buffer = {
          score_offset = -100,
          enabled = function()
            local enabled = {
              'markdown',
              'text',
            }
            return vim.tbl_contains(enabled, vim.bo.filetype)
          end,
        },
      },
    },
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      prebuilt_binaries = {
        force_version = 'v1.9.1',
      },
    },
    snippets = { preset = 'luasnip' },
    signature = { enabled = true },
    cmdline = {
      completion = {
        list = { selection = { preselect = false } },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

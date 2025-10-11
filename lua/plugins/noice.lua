---@module 'lazy'
---@type LazySpec
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    local noice = require 'noice'
    noice.setup {
      messages = {
        view_search = false,
      },
      lsp = {
        progress = {
          enabled = false,
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },

      vim.keymap.set('n', '<leader>Nm', function() noice.cmd 'pick' end, { desc = 'Noice: Messages' }),
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et

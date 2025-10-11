---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    { '<leader>f', function() require('conform').format { async = true, lsp_format = 'fallback' } end, mode = '', desc = 'Format buffer' },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = {
        c = true,
        cpp = true,
        python = false,
      }

      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- python = { 'ruff' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
    },
    formatters = {
      -- ruff = {
      --   command = 'ruff',
      --   args = { 'format', '-' },
      --   stdin = true,
      -- },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

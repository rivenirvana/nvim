---@module 'lazy'
---@type LazySpec
return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
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
          javascript = true,
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
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        -- python = { 'ruff' },
      },
      -- formatters = {
      --   ruff = {
      --     command = 'ruff',
      --     args = { 'format', '-' },
      --     stdin = true,
      --   },
      -- },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'stylua',
        'prettier',
        'prettierd',
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

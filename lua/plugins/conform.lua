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
      { '<leader>cf', function() require('conform').format { async = true, lsp_format = 'fallback' } end, mode = '', desc = 'Conform: Format buffer' },
      { '<leader>cb', '<cmd>FormatToggle<CR>', mode = '', desc = 'Conform: Toggle format-on-save (buffer)' },
      { '<leader>cg', '<cmd>FormatToggle!<CR>', mode = '', desc = 'Conform: Toggle format-on-save (global)' },
    },
    init = function()
      vim.b.disable_format_on_save = false
      vim.g.disable_format_on_save = false

      vim.api.nvim_create_user_command('FormatToggle', function(args)
        if args.bang then
          vim.g.disable_format_on_save = not vim.g.disable_format_on_save
          vim.api.nvim_echo({
            { 'Conform: Format-on-save (global) ' .. (vim.g.disable_format_on_save and 'disabled' or 'enabled') },
          }, true, {})
        else
          vim.b.disable_format_on_save = not vim.b.disable_format_on_save
          vim.api.nvim_echo({
            { 'Conform: Format-on-save (buffer) ' .. (vim.b.disable_format_on_save and 'disabled' or 'enabled') },
          }, true, {})
        end
      end, {
        desc = 'Toggle format-on-save',
        bang = true,
      })
    end,
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

        if disable_filetypes[vim.bo[bufnr].filetype] or vim.g.disable_format_on_save or vim.b[bufnr].disable_format_on_save then
          return
        end

        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
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

vim.diagnostic.config {
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = { source = 'if_many', spacing = 0 },
  signs = vim.g.has_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or true,
  float = { source = true },
  severity_sort = true,
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

vim.keymap.set(
  'n',
  '<leader>td',
  function() vim.diagnostic.enable(not vim.diagnostic.is_enabled { bufnr = 0 }, { bufnr = 0 }) end,
  { desc = 'Toggle Diagnostics' }
)

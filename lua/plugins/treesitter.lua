---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  ---@module 'nvim-treesitter'
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  -- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}

-- vim: ts=2 sts=2 sw=2 et

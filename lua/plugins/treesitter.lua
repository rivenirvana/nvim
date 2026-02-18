---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    ---@param buf integer
    ---@param lang string
    local function attach(buf, lang)
      vim.treesitter.start(buf, lang)
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    local available = ts.get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then return end
        local buf = args.buf

        if vim.treesitter.language.add(lang) then
          attach(buf, lang)
        elseif vim.tbl_contains(available, lang) then
          ts.install(lang):await(function() attach(buf, lang) end)
        end
      end,
    })

    local parsers = {
      'bash',
      'c',
      'diff',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'luadoc',
      'luap',
      'markdown',
      'markdown_inline',
      'printf',
      'python',
      'query',
      'regex',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
    }
    ts.install(parsers)
  end,

  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}

-- vim: ts=2 sts=2 sw=2 et

---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    ---@param buf integer
    ---@param lang string
    local function attach(buf, lang)
      if not vim.treesitter.language.add(lang) then return end

      vim.treesitter.start(buf, lang)
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    local available = require('nvim-treesitter').get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, ft = args.buf, args.match
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then return end

        local installed = require('nvim-treesitter').get_installed 'parsers'
        if vim.tbl_contains(installed, lang) then
          attach(buf, lang)
        elseif vim.tbl_contains(available, lang) then
          require('nvim-treesitter').install(lang):await(function() attach(buf, lang) end)
        else
          attach(buf, lang)
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
    require('nvim-treesitter').install(parsers)
  end,

  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}

-- vim: ts=2 sts=2 sw=2 et

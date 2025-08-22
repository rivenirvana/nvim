local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.treesitter',
  require 'plugins.noice',
  require 'plugins.lualine',
  require 'plugins.guess-indent',
  require 'plugins.gitsigns',
  require 'plugins.which-key',
  require 'plugins.fzf-lua',
  require 'plugins.lsp',
  require 'plugins.conform',
  require 'plugins.blink-cmp',
  require 'plugins.tokyonight',
  require 'plugins.todo-comments',
  require 'plugins.mini',
  require 'plugins.debug',
  require 'plugins.indent-blankline',
  require 'plugins.nvim-lint',
  require 'plugins.autopairs',
  require 'plugins.markview',
  require 'plugins.oil',
  require 'plugins.smart-splits',
  require 'plugins.undotree',
  require 'plugins.vim-matchup',
  require 'plugins.vim-suda',
}, {
  ui = {
    icons = vim.g.has_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et

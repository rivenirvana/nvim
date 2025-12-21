---@module 'lazy'
---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- dependencies = { 'nvim-mini/mini.icons' },
  opts = {
    winopts = {
      -- height = 0.95,
      -- width = 0.95,
      -- row = 0.50,
      fullscreen = true,
    },
    keymap = {
      fzf = {
        true,
        ['ctrl-q'] = 'select-all+accept',
      },
    },
    fzf_opts = {
      ['--cycle'] = '',
    },
    -- file_icon_padding = ' ',
    -- winopts = {
    --   preview = {
    --     default = 'bat',
    --   },
    -- },
  },
  config = function(_, opts)
    local fzflua = require 'fzf-lua'
    fzflua.setup(opts)
    fzflua.register_ui_select()

    vim.keymap.set({ 'n', 'x' }, '<leader>sb', fzflua.builtin, { desc = 'Search: Builtin Search Commands' })
    vim.keymap.set('n', '<leader>sr', fzflua.resume, { desc = 'Search: Resume' })
    vim.keymap.set('n', '<leader>sh', fzflua.helptags, { desc = 'Search: Help Docs' })
    vim.keymap.set('n', '<leader>sk', fzflua.keymaps, { desc = 'Search: Keymaps' })
    vim.keymap.set('n', '<leader>sf', fzflua.files, { desc = 'Search: Files' })
    vim.keymap.set('n', '<leader>sF', fzflua.oldfiles, { desc = 'Search: Recent Files' })
    vim.keymap.set('n', '<leader>st', fzflua.git_files, { desc = 'Search: Tracked Git Files' })
    vim.keymap.set('n', '<leader>sw', fzflua.grep_cword, { desc = 'Search: Current Word' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ss', fzflua.grep_visual, { desc = 'Search: Current Selection' })
    vim.keymap.set('n', '<leader>sg', fzflua.live_grep, { desc = 'Search: via Grep' })
    vim.keymap.set('n', '<leader>sd', fzflua.diagnostics_document, { desc = 'Search: Document Diagnostics' })
    vim.keymap.set('n', '<leader>sD', fzflua.diagnostics_workspace, { desc = 'Search: Workspace Diagnostics' })
    vim.keymap.set('n', '<leader>sn', function() fzflua.files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Search: Neovim Config' })
    vim.keymap.set('n', '<leader>sC', fzflua.blines, { desc = 'Search: Fuzz Current Buffer' })
    vim.keymap.set('n', '<leader>sA', fzflua.lines, { desc = 'Search: Fuzz All Buffers' })
    vim.keymap.set('n', '<leader><leader>', fzflua.buffers, { desc = 'Search: Buffers' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et

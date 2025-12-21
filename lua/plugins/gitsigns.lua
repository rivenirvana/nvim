---@module 'lazy'
---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  ---@module 'gitsigns'
  ---@type Gitsigns.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { buffer = bufnr, desc = 'Git: Jump to Next Change' })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { buffer = bufnr, desc = 'Git: Jump to Previous Change' })

      vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { buffer = bufnr, desc = 'Git: Stage Hunk' })
      vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { buffer = bufnr, desc = 'Git: Reset Hunk' })

      vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Git: Stage Hunk' })
      vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Git: Reset Hunk' })
      vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { buffer = bufnr, desc = 'Git: Stage Buffer' })
      vim.keymap.set('n', '<leader>hu', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Git: Undo Stage Hunk' })
      vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { buffer = bufnr, desc = 'Git: Reset Buffer' })
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Git: Preview Hunk' })
      vim.keymap.set('n', '<leader>hb', gitsigns.blame_line, { buffer = bufnr, desc = 'Git: Blame Line' })
      vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { buffer = bufnr, desc = 'Git: Diff against Index' })
      vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis '@' end, { buffer = bufnr, desc = 'Git: Diff against Last Commit' })

      vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Git: Toggle Line Blame' })
      vim.keymap.set('n', '<leader>tD', gitsigns.preview_hunk_inline, { buffer = bufnr, desc = 'Git: Toggle Deleted Hunk' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

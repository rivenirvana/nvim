---@module 'lazy'
---@type LazySpec
return {
  'mrjones2014/smart-splits.nvim',
  build = './kitty/install-kittens.bash',
  lazy = false,
  config = function()
    local smartsplits = require 'smart-splits'
    smartsplits.setup {
      default_amount = 1,
      float_win_behavior = 'mux',
      cursor_follows_swapped_bufs = true,
    }

    vim.keymap.set('n', '<C-h>', smartsplits.move_cursor_left)
    vim.keymap.set('n', '<C-j>', smartsplits.move_cursor_down)
    vim.keymap.set('n', '<C-k>', smartsplits.move_cursor_up)
    vim.keymap.set('n', '<C-l>', smartsplits.move_cursor_right)
    vim.keymap.set('n', '<C-\\>', smartsplits.move_cursor_previous)

    vim.keymap.set('n', '<C-M-h>', smartsplits.resize_left)
    vim.keymap.set('n', '<C-M-j>', smartsplits.resize_down)
    vim.keymap.set('n', '<C-M-k>', smartsplits.resize_up)
    vim.keymap.set('n', '<C-M-l>', smartsplits.resize_right)

    vim.keymap.set('n', '<C-S-h>', smartsplits.swap_buf_left)
    vim.keymap.set('n', '<C-S-j>', smartsplits.swap_buf_down)
    vim.keymap.set('n', '<C-S-k>', smartsplits.swap_buf_up)
    vim.keymap.set('n', '<C-S-l>', smartsplits.swap_buf_right)
  end,
}

-- vim: ts=2 sts=2 sw=2 et

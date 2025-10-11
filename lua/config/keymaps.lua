vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open Diagnostic Quickfix List' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

vim.keymap.set('n', '<leader>xn', vim.cmd.Ex, { desc = 'Exec Netrw' })
vim.keymap.set('n', '<leader>xs', vim.cmd.so, { desc = 'Exec Source Script' })
vim.keymap.set('n', '<leader>xc', '<cmd>!chmod +x %<CR>', { desc = 'Exec chmod +x', silent = true })
vim.keymap.set('n', '<leader>xr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Exec Search & Replace' })
-- vim.keymap.set('n', '<leader>xf', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Exec Find Project' })
-- vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { desc = 'Format Buffer via LSP' })

-- Refrain from using <Esc> for CTRL-C, instead learn i_CTRL-C as a separate and intended feature. Keep keybind for now.
-- vim.keymap.set('i', '<C-c>', '<Esc>')
-- https://github.com/nvim-lua/kickstart.nvim/issues/1121
-- vim.keymap.set('i', '<C-c>', '<C-c>')

vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
vim.keymap.set('x', '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })
vim.keymap.set('x', '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })
vim.keymap.set('x', '<', '<gv', { desc = 'Indent left (keep selection)' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent right (keep selection)' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line (retain cursor position)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

vim.keymap.set('n', 'zb', ':let save_so = &so<CR>:set so=0<CR>zb:let &so=save_so<CR>', { desc = 'Drag cursor line to bottom of window', silent = true })
vim.keymap.set('n', 'zt', ':let save_so = &so<CR>:set so=0<CR>zt:let &so=save_so<CR>', { desc = 'Drag cursor line to top of window', silent = true })

vim.keymap.set({ 'n', 'x' }, '<leader>y', [["+y]], { desc = 'Yank selection to system clipboard' })
-- This keymap doesn't seem to work correctly as the register command that it's mapped to. Probably needs to be reported.
-- https://neovim.io/doc/user/change.html#Y-default
vim.keymap.set({ 'n', 'x' }, '<leader>Y', [["+Y]], { desc = 'Yank cursor-to-EOL to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>P', [["+P]], { desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>v', [["_d]], { desc = 'Delete to void' })
vim.keymap.set('x', '<leader>V', [["_dP]], { desc = 'Paste over selection' })

-- vim: ts=2 sts=2 sw=2 et

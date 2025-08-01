vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.has_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

vim.o.signcolumn = 'yes'
vim.o.updatetime = 50
vim.o.timeoutlen = 200
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'
vim.o.inccommand = 'split'
vim.o.smoothscroll = true
vim.o.confirm = true

vim.o.mouse = 'a'
vim.o.colorcolumn = '80'
vim.o.showmode = false
vim.o.undofile = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

vim.opt.isfname:append { '@-@' }

-- vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- vim: ts=2 sts=2 sw=2 et

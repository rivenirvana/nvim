---@module 'lazy'
---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- dependencies = { 'echasnovski/mini.icons' },
  opts = {},
  config = function()
    local fzflua = require 'fzf-lua'
    fzflua.setup()

    vim.keymap.set('n', '<leader>sh', fzflua.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', fzflua.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', fzflua.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>st', fzflua.git_files, { desc = '[S]earch [T]racked Git Files' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sb', fzflua.builtin, { desc = '[S]earch [B]uiltin Search Commands' })
    vim.keymap.set('n', '<leader>sw', fzflua.grep_cword, { desc = '[S]earch Current [W]ord' })
    vim.keymap.set('v', '<leader>ss', fzflua.grep_visual, { desc = '[S]earch Current [S]election' })
    vim.keymap.set('n', '<leader>sg', fzflua.live_grep, { desc = '[S]earch Via [G]rep' })
    vim.keymap.set('n', '<leader>sd', fzflua.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', fzflua.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>so', fzflua.oldfiles, { desc = '[S]earch [O]pened Files' })
    vim.keymap.set('n', '<leader>sn', function() fzflua.files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim Config' })
    vim.keymap.set('n', '<leader>sC', fzflua.blines, { desc = '[S]earch [C]urrent Buffer' })
    vim.keymap.set('n', '<leader>sA', fzflua.lines, { desc = '[S]earch [A]ll Buffers' })
    vim.keymap.set('n', '<leader><leader>', fzflua.buffers, { desc = '[ ] Search Buffers' })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('SetLspKeymaps', {}),
      callback = function()
        vim.keymap.set('n', 'grr', fzflua.lsp_references, { desc = '[G]oto [R]eferences' })
        vim.keymap.set('n', 'gri', fzflua.lsp_implementations, { desc = '[G]oto [I]mplementation' })
        vim.keymap.set('n', 'gra', fzflua.lsp_code_actions, { desc = '[G]oto Code [A]ctions' })
        vim.keymap.set('n', 'grd', fzflua.lsp_definitions, { desc = '[G]oto [D]efinition' })
        vim.keymap.set('n', 'grt', fzflua.lsp_typedefs, { desc = '[G]oto [T]ype Definition' })
        vim.keymap.set('n', 'gD', fzflua.lsp_document_symbols, { desc = 'Open [D]ocument Symbols' })
        vim.keymap.set('n', 'gW', fzflua.lsp_document_symbols, { desc = 'Open [W]orkspace Symbols' })
      end,
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et

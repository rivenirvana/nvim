---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    ---@module 'lazydev'
    ---@type lazydev.Config
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'mason-org/mason.nvim',
        ---@module 'mason.settings'
        ---@type MasonSettings
        opts = {},
      },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
      'ibhagwan/fzf-lua',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('OnLspAttach', { clear = true }),
        callback = function(on_attach)
          local fzflua = require 'fzf-lua'

          vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = on_attach.buf, desc = 'LSP: Rename' })
          vim.keymap.set({ 'n', 'x' }, 'gra', fzflua.lsp_code_actions, { buffer = on_attach.buf, desc = 'LSP: Goto Code Action' })
          vim.keymap.set('n', 'grr', fzflua.lsp_references, { buffer = on_attach.buf, desc = 'LSP: Goto References' })
          vim.keymap.set('n', 'gri', fzflua.lsp_implementations, { buffer = on_attach.buf, desc = 'LSP: Goto Implementation' })
          vim.keymap.set('n', 'grd', fzflua.lsp_definitions, { buffer = on_attach.buf, desc = 'LSP: Goto Definition' })
          vim.keymap.set('n', 'grD', fzflua.lsp_declarations, { buffer = on_attach.buf, desc = 'LSP: Goto Declaration' })
          vim.keymap.set('n', 'grt', fzflua.lsp_typedefs, { buffer = on_attach.buf, desc = 'LSP: Goto Type Definition' })
          vim.keymap.set('n', 'gO', fzflua.lsp_document_symbols, { buffer = on_attach.buf, desc = 'LSP: Open Document Symbols' })
          vim.keymap.set('n', 'gW', fzflua.lsp_document_symbols, { buffer = on_attach.buf, desc = 'LSP: Open Workspace Symbols' })

          vim.keymap.set(
            'n',
            '<leader>td',
            function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
            { buffer = on_attach.buf, desc = 'LSP: Toggle Diagnostics' }
          )

          local client = vim.lsp.get_client_by_id(on_attach.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, on_attach.buf) then
            local hl_augroup = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = hl_augroup,
              buffer = on_attach.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              group = hl_augroup,
              buffer = on_attach.buf,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('OnLspDetach', { clear = true }),
              callback = function(on_detach)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = hl_augroup, buffer = on_detach.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, on_attach.buf) then
            vim.keymap.set(
              'n',
              '<leader>th',
              function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = on_attach.buf }) end,
              { buffer = on_attach.buf, desc = 'LSP: Toggle Inlay Hints' }
            )
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { source = 'if_many' },
        signs = vim.g.has_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
        },
        -- virtual_lines = true,
      }

      ---@class LspServersConfig
      ---@field mason table<string, vim.lsp.Config>
      ---@field others table<string, vim.lsp.Config>
      local servers = {
        mason = {
          clangd = {},
          gopls = {},
          basedpyright = {},
          -- ruff = {},
          rust_analyzer = {},
          -- https://github.com/pmizio/typescript-tools.nvim
          ts_ls = {},
          lua_ls = {
            -- cmd = {},
            -- filetypes = {},
            -- capabilities = {},
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
          bashls = {
            filetypes = { 'bash', 'sh', 'zsh' },
          },
        },
        others = {
          -- dartls = {},
        },
      }

      local ensure_installed = vim.tbl_keys(servers.mason)
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for server, config in pairs(vim.tbl_extend('keep', servers.mason, servers.others)) do
        if not vim.tbl_isempty(config) then
          vim.lsp.config(server, config)
        end
      end

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_enable = true,
      }

      if not vim.tbl_isempty(servers.others) then
        vim.lsp.enable(vim.tbl_keys(servers.others))
      end
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

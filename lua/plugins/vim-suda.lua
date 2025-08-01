---@module 'lazy'
---@type LazySpec
return {
  -- Workaround to sudo not working in-editor
  -- https://github.com/neovim/neovim/issues/1716
  'lambdalisue/vim-suda',
  init = function()
    if not vim.o.diff then
      vim.g.suda_smart_edit = 1
    end
  end,
}

-- vim: ts=2 sts=2 sw=2 et

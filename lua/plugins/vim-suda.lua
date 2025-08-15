---@module 'lazy'
---@type LazySpec
return {
  -- Workaround to sudo not working in-editor
  -- https://github.com/neovim/neovim/issues/1716
  'lambdalisue/vim-suda',
  cmd = { 'SudaRead', 'SudaWrite' },
}

-- vim: ts=2 sts=2 sw=2 et

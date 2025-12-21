---@module 'lazy'
---@type LazySpec
return {
  'andymass/vim-matchup',
  lazy = false,
  ---@type matchup.Config
  opts = {
    matchparen = {
      deferred = 1,
      offscreen = {
        method = 'popup',
      },
    },
    treesitter = {
      disable_virtual_text = false,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

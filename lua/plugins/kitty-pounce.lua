---@module 'lazy'
---@type LazySpec
return {
  dir = '~/dev/rivenirvana/kitty-pounce.nvim',
  build = {
    'cp -f pounce.py ~/.config/kitty/',
  },
  opts = {},
}

-- vim: ts=2 sts=2 sw=2 et

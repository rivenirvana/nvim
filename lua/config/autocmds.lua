vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('HighlightOnYank', { clear = true }),
  desc = 'Highlight yanked text',
  callback = function() vim.hl.on_yank() end,
})

if not vim.g.kitty_theme_tint then
  return
end

local kitty_op = {
  RESTORE = vim.api.nvim_create_augroup('KittyColorRestore', { clear = true }),
  SYNC_NORMAL = vim.api.nvim_create_augroup('KittyColorSyncNormal', { clear = true }),
  SYNC_BACKDROP = vim.api.nvim_create_augroup('KittyColorSyncBackdrop', { clear = true }),
}

local kitty_colors = {
  { key = 'background', group = kitty_op.SYNC_NORMAL, hl = 'Normal' },
  { key = 'transparent_background_color1', group = kitty_op.SYNC_NORMAL, hl = 'ColorColumn' },
  { key = 'transparent_background_color2', group = kitty_op.SYNC_NORMAL, hl = 'CursorLine' },
  { key = 'transparent_background_color3', group = kitty_op.SYNC_NORMAL, hl = 'StatusLine' },
  { key = 'transparent_background_color4', group = kitty_op.SYNC_NORMAL, hl = 'NormalFloat' },
  { key = 'transparent_background_color5', group = kitty_op.SYNC_BACKDROP, hl = 'Normal' },
  { key = 'transparent_background_color6', group = kitty_op.SYNC_BACKDROP, hl = 'NormalNC' },
  { key = 'transparent_background_color7', group = kitty_op.SYNC_BACKDROP, hl = 'CursorLine' },
}

local function rgb_blend(ratio, under, over)
  local inverse = 100 - ratio

  local r1 = bit.rshift(bit.band(under, 0xFF0000), 16)
  local g1 = bit.rshift(bit.band(under, 0x00FF00), 8)
  local b1 = bit.band(under, 0x0000FF)

  local r2 = bit.rshift(bit.band(over, 0xFF0000), 16)
  local g2 = bit.rshift(bit.band(over, 0x00FF00), 8)
  local b2 = bit.band(over, 0x0000FF)

  local mr = math.floor((ratio * r1 + inverse * r2) / 100)
  local mg = math.floor((ratio * g1 + inverse * g2) / 100)
  local mb = math.floor((ratio * b1 + inverse * b2) / 100)

  return bit.lshift(mr, 16) + bit.lshift(mg, 8) + mb
end

local function send_color_code(args)
  local code = { '\x1b]21' }

  local ratio = 0
  if args.group == kitty_op.SYNC_BACKDROP then
    local bufnr = vim.fn.win_findbuf(args.buf)[1]
    ratio = vim.wo[bufnr].winblend
  end

  for _, color in ipairs(kitty_colors) do
    if args.group == color.group and color.hl ~= '' or args.group == kitty_op.RESTORE then
      code[#code + 1] = ';'
      code[#code + 1] = color.key

      if args.group ~= kitty_op.RESTORE then
        local hl = vim.api.nvim_get_hl(0, { name = color.hl })
        local rgb_int = args.group == kitty_op.SYNC_BACKDROP and rgb_blend(ratio, hl.bg, 0) or hl.bg

        code[#code + 1] = '='
        code[#code + 1] = string.format('#%06x', rgb_int)
      end
    end
  end

  -- code[#code + 1] = '\x1b\x5c'
  code[#code + 1] = '\x07'
  io.stderr:flush()
  io.stderr:write(table.concat(code))
  io.stderr:flush()
  -- vim.fn.chansend(vim.v.stderr, table.concat(code))
end

vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimSuspend' }, {
  group = kitty_op.RESTORE,
  desc = 'Restore default kitty colors',
  callback = send_color_code,
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'VimResume', 'ColorScheme' }, {
  group = kitty_op.SYNC_NORMAL,
  desc = 'Set specified highlight groups as transparent',
  callback = send_color_code,
})

vim.api.nvim_create_autocmd('FileType', {
  group = kitty_op.SYNC_BACKDROP,
  pattern = { '*_backdrop' },
  desc = 'Set float window backdrops as transparent',
  callback = send_color_code,
})

-- vim: ts=2 sts=2 sw=2 et

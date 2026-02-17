vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('HighlightOnYank', { clear = true }),
  desc = 'Highlight yanked text',
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor position on file open',
  group = vim.api.nvim_create_augroup('RestoreFileCursor', { clear = true }),
  pattern = '*',
  callback = function()
    local line = vim.fn.line '\'"'
    if line > 1 and line <= vim.fn.line '$' then vim.cmd.normal { 'g`"', bang = true } end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Automatically create parent dirs on file save',
  group = vim.api.nvim_create_augroup('AutoCreateDirs', { clear = true }),
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand '<afile>:p:h'
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, 'p') end
  end,
})

if not vim.env.KITTY_WINDOW_ID then return end

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

local hl_cache = {}

local function get_hl(name)
  local hl = hl_cache[name]
  if not hl then
    hl = vim.api.nvim_get_hl(0, { name = name })
    hl_cache[name] = hl
  end
  return hl
end

local function send_color_code(args)
  local group = args.group
  local code = { '\x1b]21' }

  local ratio = 0
  if group == kitty_op.SYNC_BACKDROP then
    local winid = vim.fn.win_findbuf(args.buf)[1]
    ratio = vim.wo[winid].winblend
  end

  local op_restore = group == kitty_op.RESTORE

  for _, color in ipairs(kitty_colors) do
    if (group == color.group and color.hl ~= '') or op_restore then
      code[#code + 1] = ';'
      code[#code + 1] = color.key

      if not op_restore then
        local hl = get_hl(color.hl)
        local rgb_int = group == kitty_op.SYNC_BACKDROP and rgb_blend(ratio, hl.bg, 0) or hl.bg

        code[#code + 1] = '='
        code[#code + 1] = string.format('#%06x', rgb_int)
      end
    end
  end

  code[#code + 1] = '\x07'
  vim.api.nvim_ui_send(table.concat(code))
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

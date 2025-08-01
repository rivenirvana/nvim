local M = {}

M.augroup = vim.api.nvim_create_augroup('KittyColorSync', {})
M.colors = {
  background = 'Normal',
  transparent_background_color1 = 'ColorColumn',
  transparent_background_color2 = 'CursorLine',
  transparent_background_color3 = 'StatusLine',
  transparent_background_color4 = 'NormalFloat',
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

local function send_color_code(params)
  local code = { '\x1b]21' }
  for _, param in ipairs(params) do
    table.insert(code, param)
  end
  table.insert(code, '\x1b\\')
  io.stdout:write(table.concat(code, ''))
end

vim.api.nvim_create_autocmd({ 'UIEnter', 'BufWinEnter', 'ColorScheme', 'FileType', 'WinEnter' }, {
  group = M.augroup,
  callback = function()
    local params = {}
    for key, grp in pairs(M.colors) do
      local hl = vim.api.nvim_get_hl(0, { name = grp })
      if hl and hl.bg then
        table.insert(params, ';')
        table.insert(params, key)
        table.insert(params, '=')
        table.insert(params, string.format('#%06x', hl.bg))
      end
    end

    send_color_code(params)
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = M.augroup,
  pattern = { '*_backdrop' },
  callback = function(args)
    local id = vim.fn.win_findbuf(args.buf)[1]
    -- local ratio = vim.wo[id].winblend
    local ratio = vim.api.nvim_get_option_value('winblend', { win = id })
    local params = {}
    local hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if hl and hl.bg then
      local blend = rgb_blend(ratio, hl.bg, 0)
      table.insert(params, ';transparent_background_color5=')
      table.insert(params, string.format('#%06x', blend))
    end
    local hl2 = vim.api.nvim_get_hl(0, { name = 'NormalNC' })
    if hl and hl2.bg then
      local blend2 = rgb_blend(ratio, hl2.bg, 0)
      table.insert(params, ';transparent_background_color6=')
      table.insert(params, string.format('#%06x', blend2))
    end

    send_color_code(params)
  end,
})

vim.api.nvim_create_autocmd({ 'UILeave' }, {
  group = M.augroup,
  callback = function()
    local params = {}
    for key in pairs(M.colors) do
      table.insert(params, ';')
      table.insert(params, key)
    end
    table.insert(params, ';transparent_background_color5')
    table.insert(params, ';transparent_background_color6')

    send_color_code(params)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('HighlightOnYank', {}),
  callback = function() vim.hl.on_yank() end,
})

-- vim: ts=2 sts=2 sw=2 et

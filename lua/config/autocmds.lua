local kitty_augroup = vim.api.nvim_create_augroup('KittyColorSync', { clear = true })

local kitty_colors = {
  { key = 'background', blend = false, hl = 'Normal' },
  { key = 'transparent_background_color1', blend = false, hl = 'ColorColumn' },
  { key = 'transparent_background_color2', blend = false, hl = 'CursorLine' },
  { key = 'transparent_background_color3', blend = false, hl = 'StatusLine' },
  { key = 'transparent_background_color4', blend = false, hl = 'NormalFloat' },
  { key = 'transparent_background_color5', blend = true, hl = 'Normal' },
  { key = 'transparent_background_color6', blend = true, hl = 'NormalNC' },
  { key = 'transparent_background_color7', blend = true, hl = 'CursorLine' },
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

vim.api.nvim_create_autocmd({ 'UIEnter', 'BufWinEnter', 'ColorScheme', 'FileType', 'WinEnter' }, {
  group = kitty_augroup,
  callback = function()
    local code = { '\x1b]21' }

    for _, color in ipairs(kitty_colors) do
      if not color.blend and color.hl ~= '' then
        local hl = vim.api.nvim_get_hl(0, { name = color.hl })
        if hl and hl.bg then
          table.insert(code, ';')
          table.insert(code, color.key)
          table.insert(code, '=')
          table.insert(code, string.format('#%06x', hl.bg))
        end
      end
    end

    table.insert(code, '\x1b\\')
    io.stdout:write(table.concat(code))
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = kitty_augroup,
  pattern = { '*_backdrop' },
  callback = function(args)
    local id = vim.fn.win_findbuf(args.buf)[1]
    local ratio = vim.wo[id].winblend
    local code = { '\x1b]21' }

    for _, color in ipairs(kitty_colors) do
      if color.blend and color.hl ~= '' then
        local hl = vim.api.nvim_get_hl(0, { name = color.hl })
        if hl and hl.bg then
          local blend = rgb_blend(ratio, hl.bg, 0)
          table.insert(code, ';')
          table.insert(code, color.key)
          table.insert(code, '=')
          table.insert(code, string.format('#%06x', blend))
        end
      end
    end

    table.insert(code, '\x1b\\')
    io.stdout:write(table.concat(code))
  end,
})

vim.api.nvim_create_autocmd({ 'UILeave' }, {
  group = kitty_augroup,
  callback = function()
    local code = { '\x1b]21' }

    for _, color in ipairs(kitty_colors) do
      if color.hl ~= '' then
        table.insert(code, ';')
        table.insert(code, color.key)
      end
    end

    table.insert(code, '\x1b\\')
    io.stdout:write(table.concat(code))
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('HighlightOnYank', {}),
  callback = function() vim.hl.on_yank() end,
})

-- vim: ts=2 sts=2 sw=2 et

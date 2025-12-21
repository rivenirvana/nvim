---@module 'lazy'
---@type LazySpec
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('harpoon'):setup()

    local conf = require('telescope.config').values
    function Toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end
  end,
  keys = {
    { '<leader>a', function() require('harpoon'):list():add() end, desc = 'Add current file to harpoon' },
    { '<C-e>', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = 'Open harpoon window' },
    { '<leader>e', function() Toggle_telescope(require('harpoon'):list()) end, desc = 'Open harpoon window in Telescope' },

    { '<C-1>', function() require('harpoon'):list():select(1) end },
    { '<C-2>', function() require('harpoon'):list():select(2) end },
    { '<C-3>', function() require('harpoon'):list():select(3) end },
    { '<C-4>', function() require('harpoon'):list():select(4) end },

    -- Toggle previous & next buffers stored within require('harpoon') list
    { '<C-S-J>', function() require('harpoon'):list():next() end },
    { '<C-S-K>', function() require('harpoon'):list():prev() end },
  },
}

-- vim: ts=2 sts=2 sw=2 et

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local t = require 'telescope'
    local b = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local map = vim.keymap.set
    t.setup {
      pickers = {
        buffers = {
          mappings = {
            i = {
              ['<Del>'] = actions.delete_buffer,
            },
            n = {
              ['<Del>'] = actions.delete_buffer,
              ['d'] = actions.delete_buffer,
            },
          },
        },
      },
    }
    t.load_extension 'fzf'
    map('n', '<leader><leader>', b.buffers, { desc = 'Buffers' })
    map('n', '<leader>fg', b.live_grep, { desc = 'Grep' })
    map('n', '<leader>ff', b.find_files, { desc = 'Files' })
    map('n', '<leader>fb', b.builtin, { desc = 'Telescope Menu' })
  end,
}

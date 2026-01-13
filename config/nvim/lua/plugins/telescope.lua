return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local t = require 'telescope'
    local b = require 'telescope.builtin'
    local map = vim.keymap.set
    t.setup {}
    t.load_extension 'fzf'
    map('n', '<leader><leader>', b.buffers, { desc = 'Buffers' })
    map('n', '<leader>fg', b.live_grep, { desc = 'Grep' })
    map('n', '<leader>ff', b.find_files, { desc = 'Files' })
    map('n', '<leader>fb', b.builtin, { desc = 'Telescope Menu' })
  end,
}

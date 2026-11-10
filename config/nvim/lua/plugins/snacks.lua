return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        fzf = true,
      },
      sources = {
        files = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
      },
    },
    notifier = { enabled = true },
    indent = { enabled = false }, -- Disabled indent guides
    bufdelete = { enabled = true },
    terminal = { enabled = true },
    quickfile = { enabled = true },
  },
  keys = {
    -- Navigation & Pickers
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<leader>fg', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>fb', function() Snacks.picker.pickers() end, desc = 'Snacks Pickers Menu' },

    -- Buffer & Terminal Utilities
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    { '<leader>st', function() Snacks.terminal() end, desc = 'Toggle Terminal (Snacks)' },
    { '<A-t>', function() Snacks.terminal() end, mode = { 'n', 't' }, desc = 'Toggle Terminal' },
    { '<c-/>', function() Snacks.terminal() end, mode = { 'n', 't' }, desc = 'Toggle Terminal' },
  },
}

local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Window Navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus Left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus Right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus Down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus Up' })
map('n', '<C-w>e', ':Vexplore<CR>', { desc = 'Open Vexplore', noremap = true, silent = true })

-- Diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Quickfix' })
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Line Diagnostic' })
map('n', '<leader>Q', function()
  vim.cmd 'cclose'
end, { desc = 'Close Quickfix' })

-- Visual Move
map('x', '<A-k>', ":move '<-2<CR>gv=gv")
map('x', '<A-j>', ":move '>+1<CR>gv=gv")

-- Source file
map('n', '<leader>o', ':update<CR> :source<CR>')

require 'core.options'
require 'core.keymaps'

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Initialize Lazy with the 'plugins' folder
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
}

-- Transparency Fix (Applied after plugins load)
local s = vim.api.nvim_set_hl
s(0, 'Normal', { bg = 'none' })
s(0, 'NormalFloat', { bg = 'none' })

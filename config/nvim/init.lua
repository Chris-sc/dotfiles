require 'core.options'
require 'core.keymaps'

-- Bootstrap Lazy.nvim using modern vim.uv API
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

vim.filetype.add {
  extension = {
    bb = 'clojure',
  },
}

-- Initialize Lazy plugins
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
}

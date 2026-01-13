local opt = vim.opt

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.g.have_nerd_font = true
opt.winborder = 'rounded'

-- Persistent Undo
opt.undofile = true
opt.undolevels = 10000
local undo_path = vim.fn.stdpath 'state' .. '/undo'
if vim.fn.isdirectory(undo_path) == 0 then
  vim.fn.mkdir(undo_path, 'p')
end

-- Standard Options
opt.clipboard = 'unnamedplus'
opt.number = true
opt.relativenumber = false
opt.mouse = 'a'
opt.confirm = true
opt.breakindent = true
opt.termguicolors = true
opt.cursorline = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 10
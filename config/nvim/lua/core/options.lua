local opt = vim.opt

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.g.have_nerd_font = true
opt.winborder = 'rounded'

-- Persistent Undo (Neovim automatically creates stdpath('state')/undo)
opt.undofile = true
opt.undolevels = 10000

-- Standard Options
opt.clipboard = 'unnamedplus'
opt.number = true
opt.relativenumber = false
opt.mouse = 'a'
opt.confirm = true
opt.breakindent = true
opt.cursorline = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 10
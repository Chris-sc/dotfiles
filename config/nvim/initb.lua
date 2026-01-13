-- ========================================================================== --
--                                BASIC SETTINGS                              --
-- ========================================================================== --
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.g.have_nerd_font = true
vim.opt.winborder = 'rounded'

-- Persistent Undo
vim.opt.undofile = true
vim.opt.undolevels = 10000
local undo_path = vim.fn.stdpath 'state' .. '/undo'
if vim.fn.isdirectory(undo_path) == 0 then
  vim.fn.mkdir(undo_path, 'p')
end

-- Standard Options
local opt = vim.opt
opt.clipboard = 'unnamedplus'
opt.number = true
opt.relativenumber = true
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

-- ========================================================================== --
--                                 KEYBINDINGS                                --
-- ========================================================================== --
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

--To source file
map('n', '<leader>o', ':update<CR> :source<CR>')

-- ========================================================================== --
--                                PLUGINS (LAZY)                              --
-- ========================================================================== --
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Simple Plugins
  'tpope/vim-sleuth',
  'lewis6991/gitsigns.nvim',
  'folke/which-key.nvim',
  'rafamadriz/friendly-snippets',
  'HiPhish/rainbow-delimiters.nvim',
  { 'j-hui/fidget.nvim', opts = {} },

  -- Theme
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vscode').setup { transparent = true }
      require('vscode').load()
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  -- Conjure
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel', 'janet', 'python' },
    config = function()
      vim.g['conjure#mapping#prefix'] = '\\'
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>F',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        clojure = { 'cljfmt' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        c = { 'clang-format' },
        cs = { 'csharpier' },
      },
    },
  },
  -- Blink Completion
  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      snippets = {
        expand = function(s)
          vim.snippet.expand(s)
        end,
        active = function(f)
          return vim.snippet.active(f)
        end,
        jump = function(d)
          vim.snippet.jump(d)
        end,
      },
      keymap = {
        preset = 'default',
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<Tab>'] = { 'accept', 'fallback' },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local t = require 'telescope'
      local b = require 'telescope.builtin'
      t.setup {}
      t.load_extension 'fzf'
      map('n', '<leader>fb', b.buffers, { desc = 'Buffers' })
      map('n', '<leader>fg', b.live_grep, { desc = 'Grep' })
      map('n', '<leader>ff', b.find_files, { desc = 'Files' })
      map('n', '<leader><leader>', b.builtin, { desc = 'Telescope Menu' })
    end,
  },

  -- Surround
  { 'kylechui/nvim-surround', opts = {} },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    indent = true,
    config = function()
      local ts = require 'nvim-treesitter'

      ts.install {
        'bash',
        'c',
        'lua',
        'markdown',
        'clojure',
        'c_sharp',
        'json',
        'toml',
        'css',
      }

      -- 2. Use a smart autocmd to enable highlighting/indentation
      -- This checks if a parser exists before trying to start it.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local bufnr = args.buf
          local ft = vim.bo[bufnr].filetype

          -- Check if we have a parser for this filetype
          if vim.treesitter.get_parser(bufnr, ft, { error = false }) then
            vim.treesitter.start(bufnr, ft)
            -- Enable Treesitter-based folding
            --vim.wo.foldmethod = 'expr'
            --vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            -- Enable Treesitter indentation (experimental in core)
            -- Note: You can still use nvim-treesitter.indentexpr() if preferred
            --vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  }, -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'nvim-telescope/telescope.nvim', -- Added dependency for the 'gr' maps
    },
    config = function()
      require('mason').setup()
      local lsp = require 'lspconfig'
      local caps = require('blink.cmp').get_lsp_capabilities()
      local svrs = { 'lua_ls', 'clojure_lsp', 'jsonls', 'csharp_ls', 'clangd', 'ts_ls' }

      require('mason-tool-installer').setup { ensure_installed = { 'stylua', 'zprint' } }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local b = require 'telescope.builtin'
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'grd', b.lsp_definitions, { buffer = event.buf, desc = 'Goto Definition' })
          vim.keymap.set('n', 'grr', b.lsp_references, { buffer = event.buf, desc = 'References' })
          vim.keymap.set('n', 'gri', b.lsp_implementations, { buffer = event.buf, desc = 'Implementation' })
          vim.keymap.set('n', 'grt', b.lsp_type_definitions, { buffer = event.buf, desc = 'Type Definition' })
          vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'Rename' })
          vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'Code Action' })
          vim.keymap.set('n', 'L', vim.lsp.buf.hover, { buffer = event.buf, desc = 'Hover Documentation' })
        end,
      })

      require('mason-lspconfig').setup {
        ensure_installed = svrs,
        handlers = {
          function(server_name)
            lsp[server_name].setup {
              capabilities = caps,
            }
          end,
        },
      }
    end,
  },
}

-- Transparency Fix
local s = vim.api.nvim_set_hl
s(0, 'Normal', { bg = 'none' })
s(0, 'NormalFloat', { bg = 'none' })

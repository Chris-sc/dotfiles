return {
  'tpope/vim-sleuth',
  'lewis6991/gitsigns.nvim',
  'folke/which-key.nvim',
  'rafamadriz/friendly-snippets',

  -- Flash (Enhanced f/t/s motion navigation)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      highlight = {
        backdrop = false, -- Disable dimming backdrop
      },
      modes = {
        char = {
          enabled = true,
          jump_labels = false, -- Disable lettered labels (no 'a', 's', 'd' overlays)
          autojump = true,    -- Jump to first match instantly, then use ';' and ',' to iterate
          highlight = { backdrop = false },
        },
      },
    },
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    },
  },

  -- Rainbow Delimiters (Treesitter parens coloring)
  {
    'HiPhish/rainbow-delimiters.nvim',
    submodules = false,
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },

  -- Colorscheme with native transparency + float transparency fix + subtle indent highlights
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
    config = function(_, opts)
      local vscode = require 'vscode'
      vscode.setup(opts)
      vscode.load()

      -- Ensure floating windows (WhichKey, Snacks, LSP Hover, CMP) are transparent
      local transparent_groups = {
        'Normal',
        'NormalNC',
        'NormalFloat',
        'FloatBorder',
        'FloatTitle',
        'WhichKeyFloat',
        'SnacksPickerNormal',
        'SnacksPickerBorder',
        'SnacksNotifierNormal',
        'SnacksNotifierBorder',
        'Pmenu',
        'BlinkCmpMenu',
        'BlinkCmpMenuBorder',
        'BlinkCmpDoc',
        'BlinkCmpDocBorder',
      }

      local function apply_transparency()
        for _, group in ipairs(transparent_groups) do
          vim.api.nvim_set_hl(0, group, { bg = 'none' })
        end
        -- Make Snacks indent and scope lines subtle
        vim.api.nvim_set_hl(0, 'SnacksIndent', { fg = '#333333', bg = 'none' })
        vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = '#555555', bg = 'none' })
      end

      apply_transparency()

      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = apply_transparency,
      })
    end,
  },

  -- Surround textobjects
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      mappings = {
        add = 'sa',
        delete = 'sd',
        replace = 'sr',
        find = 'sf',
        find_left = 'sF',
        highlight = 'sh',
        update_n_lines = 'sn',
      },
    },
  },

  -- Markdown Preview
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    opts = {
      preview = {
        filetypes = { 'markdown' },
        ignore_buftypes = {},
      },
    },
  },

  -- Conjure
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel', 'janet', 'python' },
    config = function()
      vim.g['conjure#mapping#prefix'] = '\\'
    end,
  },

  -- Conform (Formatting)
  {
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
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
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
}

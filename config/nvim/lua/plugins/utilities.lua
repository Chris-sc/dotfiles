return {
  'tpope/vim-sleuth',
  'lewis6991/gitsigns.nvim',
  'folke/which-key.nvim',
  'rafamadriz/friendly-snippets',
  'HiPhish/rainbow-delimiters.nvim',
  { 'j-hui/fidget.nvim', opts = {} },
  { 'kylechui/nvim-surround', opts = {} },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true },

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

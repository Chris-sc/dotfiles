return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter.config'
    ts.setup {
      ensure_installed = { 'bash', 'c', 'lua', 'markdown', 'clojure', 'c_sharp', 'json', 'toml', 'css' },
      highlight = { enable = true },
      indent = { enable = true },
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype
        if vim.treesitter.get_parser(bufnr, ft, { error = false }) then
          vim.treesitter.start(bufnr, ft)
        end
      end,
    })
  end,
}

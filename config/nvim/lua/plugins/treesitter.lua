return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function()
<<<<<<< HEAD
    local ts = require 'nvim-treesitter.configs'
    ts.setup {
=======
    require('nvim-treesitter.config').setup {
>>>>>>> 4231dc86ae7c2135bf87bd85835f57e74816ca96
      ensure_installed = { 'bash', 'c', 'lua', 'markdown', 'clojure', 'c_sharp', 'json', 'toml', 'css' },
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

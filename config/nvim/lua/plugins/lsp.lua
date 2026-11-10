return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    require('mason').setup()

    local lsp = require 'lspconfig'
    local util = require 'lspconfig.util'

    local function get_caps()
      return require('blink.cmp').get_lsp_capabilities()
    end

    require('mason-tool-installer').setup {
      ensure_installed = { 'stylua', 'zprint' },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
      callback = function(event)
        vim.keymap.set('n', 'grd', function() Snacks.picker.lsp_definitions() end, { buffer = event.buf, desc = 'Goto Definition' })
        vim.keymap.set('n', 'grr', function() Snacks.picker.lsp_references() end, { buffer = event.buf, desc = 'References' })
        vim.keymap.set('n', 'gri', function() Snacks.picker.lsp_implementations() end, { buffer = event.buf, desc = 'Implementation' })
        vim.keymap.set('n', 'grt', function() Snacks.picker.lsp_type_definitions() end, { buffer = event.buf, desc = 'Type Definition' })
        vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'Rename' })
        vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'Code Action' })
        vim.keymap.set('n', 'L', vim.lsp.buf.hover, { buffer = event.buf, desc = 'Hover Documentation' })
      end,
    })

    require('mason-lspconfig').setup {
      ensure_installed = { 'lua_ls', 'clojure_lsp', 'jsonls', 'csharp_ls', 'clangd', 'ts_ls' },
      handlers = {
        function(server_name)
          lsp[server_name].setup { capabilities = get_caps() }
        end,
        ['clojure_lsp'] = function()
          lsp.clojure_lsp.setup {
            capabilities = get_caps(),
            single_file_support = true,
            root_dir = function(fname)
              return util.root_pattern(
                'project.clj',
                'deps.edn',
                'bb.edn',
                'shadow-cljs.edn',
                'build.boot',
                'workspace.edn',
                'project.edn',
                '.git'
              )(fname) or util.find_git_ancestor(fname) or vim.fs.dirname(fname)
            end,
            settings = {
              clojureLsp = {
                projectPaths = { 'bases/*', 'components/*', 'projects/*', '*' },
              },
            },
          }
        end,
      },
    }
  end,
}

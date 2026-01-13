return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('mason').setup()

    local lsp = require 'lspconfig'
    local util = require 'lspconfig.util'
    local caps = require('blink.cmp').get_lsp_capabilities()

    local svrs = {
      'lua_ls',
      'clojure_lsp',
      'jsonls',
      'csharp_ls',
      'clangd',
      'ts_ls',
    }

    require('mason-tool-installer').setup {
      ensure_installed = {
        'stylua',
        'zprint',
      },
    }

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
      callback = function(event)
        local b = require 'telescope.builtin'

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
        -- Default handler for most servers
        function(server_name)
          lsp[server_name].setup {
            capabilities = caps,
          }
        end,

        -- Polylith-aware clojure-lsp
        ['clojure_lsp'] = function()
          lsp.clojure_lsp.setup {
            capabilities = caps,

            root_dir = util.root_pattern('deps.edn', 'bb.edn', '.git'),

            settings = {
              clojureLsp = {
                projectPaths = {
                  'bases/*',
                  'components/*',
                  'projects/*',
                },
              },
            },
          }
        end,
      },
    }
  end,
}

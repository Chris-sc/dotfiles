return {
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
}

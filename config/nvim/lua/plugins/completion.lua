return {
  'saghen/blink.cmp',
  version = '*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },
  opts = {
    snippets = { preset = 'luasnip' },
    keymap = {
      preset = 'super-tab',
      ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-d>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'omni', 'snippets', 'buffer' },
      providers = {
        lsp = {
          score_offset = 20,
        },
        path = {
          score_offset = 15,
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
        omni = {
          score_offset = 10,
        },
        snippets = {
          score_offset = 5,
        },
        buffer = {
          score_offset = 0,
        },
      },
    },
    completion = {
      menu = {
        border = 'rounded',
        winblend = 15,
        max_height = 4, -- Set max height to 4 items
        draw = {
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      documentation = {
        auto_show = false,
        window = {
          max_width = 50,
          max_height = 12,
          border = 'rounded',
        },
      },
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
      },
    },
  },
}

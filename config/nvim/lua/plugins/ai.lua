return {
  'olimorris/codecompanion.nvim',
  version = '^18.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/mcphub.nvim',
  },
  keys = {
    -- Primary Actions
    { '<A-\\>', '<cmd>CodeCompanionChat Toggle<CR>', mode = { 'n', 'i', 'v' }, desc = 'Toggle CodeCompanion Chat' },
    { '<A-a>', '<cmd>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'CodeCompanion Actions' },
    { '<A-i>', '<cmd>CodeCompanion<CR>', mode = { 'n', 'v' }, desc = 'CodeCompanion Inline Prompt' },
    { '<A-b>', '<cmd>CodeCompanionChat Add<CR>', mode = { 'n', 'v' }, desc = 'Add to CodeCompanion Chat' },
    { '<A-s>', '<cmd>CodeCompanionChat Select<CR>', mode = 'n', desc = 'CodeCompanion Select' },
    -- Quick Inline Shortcuts
    { '<A-e>', '<cmd>CodeCompanionInline /explain<CR>', mode = 'v', desc = 'Explain Code' },
    { '<A-f>', '<cmd>CodeCompanionInline /fix<CR>', mode = 'v', desc = 'Fix Code' },
    -- MCP Hub
    { '<A-m>', '<cmd>MCPHub<CR>', mode = 'n', desc = 'MCP Hub' },
  },
  opts = {
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = 'Prompt ', -- Prompt used for interactive LLM calls
        opts = {
          show_preset_actions = true, -- Show the preset actions in the action palette?
          show_preset_prompts = true, -- Show the preset prompts in the action palette?
          title = 'CodeCompanion actions', -- The title of the action palette
        },
      },
    },
    interactions = {
      chat = { adapter = 'gemini_cli' },
      inline = { adapter = 'gemini_cli' },
      agent = { adapter = 'gemini_cli' },
    },
    adapters = {
      gemini_cli = function()
        return require('codecompanion.adapters').extend('gemini_cli', {
          commands = {
            default = {
              'gemini',
            },
          },
          defaults = {
            auth_method = 'oauth-personal',
          },
        })
      end,
    },
  },
}

return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  build = 'make install_jsregexp',
  dependencies = {
    {
      'rafamadriz/friendly-snippets',
      lazy = true,
    },
  },
  config = function()
    local luasnip = require 'luasnip'

    luasnip.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    }

    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets' } }
  end,
}

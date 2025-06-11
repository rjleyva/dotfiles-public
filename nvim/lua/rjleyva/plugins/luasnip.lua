return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = "make install_jsregexp",
  config = function()
    local luasnip = require("luasnip")
    luasnip.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
    })

    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { "./snippets" },
    })

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}

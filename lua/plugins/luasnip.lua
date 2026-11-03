return {
  "L3MON4D3/LuaSnip",
    config = function()
    local ls = require("luasnip")
    ls.setup({
      history = true,
      update_events = "TextChanged,TextChangedI",
      region_check_events = "CursorMoved",
      delete_check_events = "TextChanged",
    })
  end
}

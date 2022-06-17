-- Module: 0x2a.plugins.luasnip.snippets.all
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local func = ls.function_node

ls.add_snippets("all", {
  snip("shrug", text("¯\\_(ツ)_/¯")),

  snip({
    trig = "date",
    namr = "Date",
    dscr = "Date in the form of YYYY-MM-DD",
  }, {
    func(function()
      return { os.date("%Y-%m-%d") }
    end, {}),
  }),
})

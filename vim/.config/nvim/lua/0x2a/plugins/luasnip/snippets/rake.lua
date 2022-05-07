-- Module: 0x2a.plugins.luasnip.snippets.rake
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rake", {
  s(
    { trig = "task", dscr = "Rake task" },
    fmt(
      [[
        desc "{}"
        task {} do
          {}
        end
      ]],
      { i(1), i(2, "name: :environment"), i(0) }
    )
  ),
})

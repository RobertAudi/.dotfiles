-- Module: 0x2a.plugins.luasnip.snippets.rake
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rake", {
  snip(
    { trig = "task", dscr = "Rake task" },
    fmt(
      [[
        desc "{}"
        task {} do
          {}
        end
      ]],
      { insert(1), insert(2, "name: :environment"), insert(0) }
    )
  ),
})

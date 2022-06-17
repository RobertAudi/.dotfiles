-- Module: 0x2a.plugins.luasnip.snippets.rspec
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("rspec", { "ruby" })

ls.add_snippets("rspec", {
  snip(
    { trig = "desc", name = "describe", dscr = "Example group" },
    fmt(
      [[
        describe "{}" do
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "cont", name = "context", dscr = "Example group" },
    fmt(
      [[
        context "{}" do
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "it", name = "Example", dscr = "" },
    fmt(
      [[
        it "{}" do
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "bef", name = "Before hook", dscr = "" },
    fmt(
      [[
        before do
          {}
        end
      ]],
      { insert(0) }
    )
  ),

  snip(
    { trig = "aft", name = "After hook", dscr = "" },
    fmt(
      [[
        after do
          {}
        end
      ]],
      { insert(0) }
    )
  ),
})

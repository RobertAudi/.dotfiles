-- Module: 0x2a.plugins.luasnip.snippets.zsh
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("zsh", { "sh" })

ls.add_snippets("zsh", {
  snip(
    { trig = "fun", name = "...() { ... }", dscr = "Function" },
    fmt(
      [[
        {}() {{
          {}
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "fun", name = "function { ... }", dscr = "Anonymous function" },
    fmt(
      [[
        function {{
          {}
        }}
      ]],
      { insert(0) }
    )
  ),
})

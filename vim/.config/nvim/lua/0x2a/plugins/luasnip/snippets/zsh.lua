-- Module: 0x2a.plugins.luasnip.snippets.zsh
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("zsh", { "sh" })

ls.add_snippets("zsh", {
  s(
    { trig = "fun", name = "...() { ... }", dscr = "Function" },
    fmt(
      [[
        {}() {{
          {}
        }}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "fun", name = "function { ... }", dscr = "Anonymous function" },
    fmt(
      [[
        function {{
          {}
        }}
      ]],
      { i(0) }
    )
  ),
})

-- Module: 0x2a.plugins.luasnip.snippets.zsh
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local choice = ls.choice_node
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

  snip(
    { trig = "if" },
    fmt(
      [[
        if {} ; then
          {}
        fi
      ]],
      {
        choice(1, {
          insert(1),
          fmt("[[ {} ]]", { insert(1) }),
          fmt("(( {} ))", { insert(1) }),
        }),

        insert(0)
      }
    )
  ),

  snip(
    { trig = "for", name = "for ... in", dscr = "for-in loop" },
    fmt(
      [[
        for {} in {}; do
          {}
        done
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),
})

-- Module: 0x2a.plugins.luasnip.snippets.sh
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("sh", {
  snip(
    { trig = "case", name = "case ... in ... esac", dscr = "case statement" },
    fmt(
      [[
        case {} in
          {})
            {}
            ;;
        esac
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),

  snip(
    { trig = "if", name = "if ... then ... fi", dscr = "if statement" },
    fmt(
      [[
        if {} ; then
          {}
        fi
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "ifel", name = "if ... then ... else ... fi", dscr = "if-else statement" },
    fmt(
      [[
        if {} ; then
          {}
        else
          # ...
        fi
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "ifelif", name = "if ... then ... else ... fi", dscr = "if-else statement" },
    fmt(
      [[
        if {} ; then
          {}
        elif {} ; then
          # ...
        else
          # ...
        fi
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),
})

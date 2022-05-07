-- Module: 0x2a.plugins.luasnip.snippets.sh
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("sh", {
  s(
    { trig = "case", name = "case ... in ... esac", dscr = "case statement" },
    fmt(
      [[
        case {} in
          {})
            {}
            ;;
        esac
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "if", name = "if ... then ... fi", dscr = "if statement" },
    fmt(
      [[
        if {} ; then
          {}
        fi
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ifel", name = "if ... then ... else ... fi", dscr = "if-else statement" },
    fmt(
      [[
        if {} ; then
          {}
        else
          # ...
        fi
      ]],
      { i(1), i(0) }
    )
  ),

  s(
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
      { i(1), i(2), i(0) }
    )
  ),
})

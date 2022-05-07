-- Module: 0x2a.plugins.luasnip.snippets.javascript
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
  s({ trig = "log", dscr = "console.log" }, fmt("console.log({});", i(0))),

  s(
    { trig = "fun", name = "const ... = (...) => {} ", dscr = "Arrow function" },
    fmt(
      [[
        const {} = ({}) => {{
          {}
        }};
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "fun", name = "(...) => {} ", dscr = "Anonymous function" },
    fmt(
      [[
        ({}) => {{
          {}
        }};
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "if", name = "if ... ", dscr = "if statement" },
    fmt(
      [[
        if ({}) {{
          {}
        }}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ife", name = "if ... else ...", dscr = "if-else statement" },
    fmt(
      [[
        if ({}) {{
          {}
        }} else {{
          // ...
        }}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "switch", name = "switch ... case ...", dscr = "switch statement" },
    fmt(
      [[
        switch ({}) {{
          case "{}":
            {}
            break;
          default:
            // ...
        }}
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "case", name = [[case "...":]], dscr = "" },
    fmt(
      [[
        case "{}":
          {}
          break;
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "try", name = "try ... catch ...", dscr = "" },
    fmt(
      [[
        try {{
          {}
        }} catch (e) {{}}
      ]],
      i(0)
    )
  ),

  s(
    { trig = "ready", name = "document.ready", dscr = "" },
    fmt(
      [[
        $(document).ready(() => {{
          {}
        }});
      ]],
      i(0)
    )
  ),
})

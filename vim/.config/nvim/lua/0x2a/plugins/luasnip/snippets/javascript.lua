-- Module: 0x2a.plugins.luasnip.snippets.javascript
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("javascript", {
  snip({ trig = "log", dscr = "console.log" }, fmt("console.log({});", insert(0))),

  snip(
    { trig = "fun", name = "const ... = (...) => {} ", dscr = "Arrow function" },
    fmt(
      [[
        const {} = ({}) => {{
          {}
        }};
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),

  snip(
    { trig = "fun", name = "(...) => {} ", dscr = "Anonymous function" },
    fmt(
      [[
        ({}) => {{
          {}
        }};
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "if", name = "if ... ", dscr = "if statement" },
    fmt(
      [[
        if ({}) {{
          {}
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "ife", name = "if ... else ...", dscr = "if-else statement" },
    fmt(
      [[
        if ({}) {{
          {}
        }} else {{
          // ...
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
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
      { insert(1), insert(2), insert(0) }
    )
  ),

  snip(
    { trig = "case", name = [[case "...":]], dscr = "" },
    fmt(
      [[
        case "{}":
          {}
          break;
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "try", name = "try ... catch ...", dscr = "" },
    fmt(
      [[
        try {{
          {}
        }} catch (e) {{}}
      ]],
      insert(0)
    )
  ),

  snip(
    { trig = "ready", name = "document.ready", dscr = "" },
    fmt(
      [[
        $(document).ready(() => {{
          {}
        }});
      ]],
      insert(0)
    )
  ),
})

-- Module: 0x2a.plugins.luasnip.snippets.all
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local choice = ls.choice_node
local func = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("all", {
  snip("shrug", text("¯\\_(ツ)_/¯")),
  snip("tableflip", text("(╯°□°）╯︵ ┻━┻")),

  -- Source: https://github.com/RishabhRD/rdconfig/blob/ffe8d4e2e593ed829cec6f9b2f7c74d5c76ca323/.config/nvim/lua/rd/snippets/all.lua#L11-L33
  snip({
    trig = "date",
    name = "System date",
    dscr = "System date in different formats",
  }, {
    choice(1, {
      func(function()
        return os.date("%Y-%m-%d")
      end, {}),

      func(function()
        return os.date("%d-%m-%Y")
      end, {}),

      func(function()
        return os.date("%Y-%b-%d")
      end, {}),

      func(function()
        return os.date("%Y-%B-%d")
      end, {}),

      func(function()
        return os.date("%d-%b-%Y")
      end, {}),

      func(function()
        return os.date("%d-%B-%Y")
      end, {}),
    }),
  }),

  -- Source: https://github.com/RishabhRD/rdconfig/blob/ffe8d4e2e593ed829cec6f9b2f7c74d5c76ca323/.config/nvim/lua/rd/snippets/all.lua#L34-L56
  snip({
    trig = "time",
    name = "System time",
    dscr = "System time in different formats",
  }, {
    choice(1, {
      func(function()
        return os.date("%H:%M:%S")
      end, {}),

      func(function()
        return os.date("%H:%M:%S %Z")
      end, {}),

      func(function()
        return os.date("%H:%M:%S %z")
      end, {}),

      func(function()
        return os.date("%I:%M:%S %p")
      end, {}),

      func(function()
        return os.date("%I:%M:%S %p %Z")
      end, {}),

      func(function()
        return os.date("%I:%M:%S %p %z")
      end, {}),
    }),
  }),

  snip({
    trig = "timestamp",
    name = "Timestamp",
    dscr = "Generate a timestamp"
  }, {
    choice(1, {
      func(function()
        return os.time(os.date("!*t"))
      end, {}),

      -- Note: This is the format used for Rails DB migrations
      func(function()
        return os.date("%Y%m%d%H%M%S")
      end, {}),
    })
  }),

  snip(
    { trig = "todo", name = "TODO" },
    fmt("{}: {}", {
      choice(1, {
        text("TODO"),
        text("FIXME"),
        text("NOTE"),
        text("BUG"),
        text("DEBUG"),
        text("WARN"),
        text("???"),
        text("!!!"),
        text("INFO"),
        text("PERF"),
        text("OPTIMIZE"),
        text("HACK"),
        text("XXX"),
      }),

      insert(0),
    })
  ),

  snip(
    { trig = "license-mit", name = "MIT", dscr = "The MIT License" },

    fmt(
      [[
        The MIT License (MIT)

        Copyright (c) {} {}

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in
        all copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
        THE SOFTWARE.
      ]],
      {
        func(function()
          return { os.date("%Y") }
        end, {}),

        insert(0),
      }
    )
  ),

  snip(
    { trig = "license-wtf", name = "WTFPL", dscr = "Do What the Fuck You Want to Public License" },

    fmt(
      [[
                    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                            Version 2, December 2004

        Copyright (C) {} {}

        Everyone is permitted to copy and distribute verbatim or modified
        copies of this license document, and changing it is allowed as long
        as the name is changed.

                    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
          TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

          0. You just DO WHAT THE FUCK YOU WANT TO.
      ]],
      {
        func(function()
          return { os.date("%Y") }
        end, {}),

        insert(0),
      }
    )
  ),
})

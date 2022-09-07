-- Module: 0x2a.plugins.luasnip.snippets.markdown
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local func = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
  snip(
    { trig = "details", name = "Details section" },

    fmt(
      [[
        <details>
          <summary>
            {}
          </summary>
          <br>

          {}
        </details>
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "details-wtf", name = "WTFPL details section" },

    fmt(
      [[
        <details>
          <summary>
            <a href="http://www.wtfpl.net/" rel="nofollow">WTFPL</a> – Do What the Fuck You Want to Public License
          </summary>
          <br>

        ```text
                    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                            Version 2, December 2004

        Copyright (C) {} {}

        Everyone is permitted to copy and distribute verbatim or modified
        copies of this license document, and changing it is allowed as long
        as the name is changed.

                    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
          TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

          0. You just DO WHAT THE FUCK YOU WANT TO.
        ```

        </details>
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
    { trig = "details-mit", name = "MIT License details section" },

    fmt(
      [[
        <details>
          <summary>
            <a href="https://opensource.org/licenses/MIT" rel="nofollow">MIT License</a>
          </summary>
          <br>

        ```text
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
        ```

        </details>
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

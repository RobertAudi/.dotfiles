-- Module: 0x2a.plugins.luasnip.snippets.vim
-- Requires:
--   - L3MON4D3/LuaSnip
--   - 0x2a.luasnip.utils

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local func = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local utils = require("0x2a.plugins.luasnip.utils")

ls.add_snippets("vim", {
  snip(
    { trig = "header", name = "Header for vim plugin files", dscr = "" },
    fmt(
      [[
        " Plugin: {}
        " Description: PLUGIN DESCRIPTION
        " URL: https://github.com/USER/{}

        {}
      ]],
      { func(utils.TM_FILENAME(), {}), func(utils.TM_FILENAME(), {}), insert(0) }
    )
  ),

  snip(
    { trig = "if", name = "if ... endif", dscr = "if statement" },
    fmt(
      [[
        if {}
          {}
        endif
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "ifel", name = "if ... else ... endif", dscr = "if-else statement" },
    fmt(
      [[
        if {}
          {}
        else
          " ...
        endif
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "while", name = "while ... endwhile", dscr = "while loop" },
    fmt(
      [[
        while {}
          {}
        endwhile
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "for", name = "for ... in ... endfor", dscr = "for...in loop" },
    fmt(
      [[
        for {} in {}
          {}
        endfor
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),
})

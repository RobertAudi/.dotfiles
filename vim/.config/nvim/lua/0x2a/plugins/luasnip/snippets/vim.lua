-- Module: 0x2a.plugins.luasnip.snippets.vim
-- Requires:
--   - L3MON4D3/LuaSnip
--   - 0x2a.luasnip.utils

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local utils = require("0x2a.plugins.luasnip.utils")

ls.add_snippets("vim", {
  s(
    { trig = "header", name = "Header for vim plugin files", dscr = "" },
    fmt(
      [[
        " Plugin: {}
        " Description: PLUGIN DESCRIPTION
        " URL: https://github.com/USER/{}

        {}
      ]],
      { f(utils.TM_FILENAME(), {}), f(utils.TM_FILENAME(), {}), i(0) }
    )
  ),

  s(
    { trig = "if", name = "if ... endif", dscr = "if statement" },
    fmt(
      [[
        if {}
          {}
        endif
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ifel", name = "if ... else ... endif", dscr = "if-else statement" },
    fmt(
      [[
        if {}
          {}
        else
          " ...
        endif
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "while", name = "while ... endwhile", dscr = "while loop" },
    fmt(
      [[
        while {}
          {}
        endwhile
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "for", name = "for ... in ... endfor", dscr = "for...in loop" },
    fmt(
      [[
        for {} in {}
          {}
        endfor
      ]],
      { i(1), i(2), i(0) }
    )
  ),
})

-- Module: 0x2a.plugins.luasnip.snippets.ruby
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("ruby", {
  s(
    { trig = "module", name = "module ... end", dscr = "Module" },
    fmt(
      [[
        module {}
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "class", name = "class ... end", dscr = "Class" },
    fmt(
      [[
        class {}
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "controller", name = "Controller", dscr = "Ruby on Rails controller" },
    fmt(
      [[
        class {}Controller < ApplicationController
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "helper", name = "Helper", dscr = "Ruby on Rails helper" },
    fmt(
      [[
        module {}Helper
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "if", hidden = true },
    fmt(
      [[
        if {}
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "unless", hidden = true },
    fmt(
      [[
        unless {}
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ife", hidden = true },
    fmt(
      [[
        if {}
          {}
        else
          # ...
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "elsif", hidden = true },
    fmt(
      [[
        elsif {}
          {}
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "def", hidden = true },
    fmt(
      [[
        def {}
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "init", name = "def initialize", dscr = "" },
    fmt(
      [[
        def initialize
          {}
        end
      ]],
      { i(0) }
    )
  ),

  s(
    { trig = "case", name = "case ... when ... end", dscr = "case statement" },
    fmt(
      [[
        case {}
        when {}
          {}
        end
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s("pry", t("binding.pry")),
  s("pry!", t("require \"pry\"; binding.pry")),
  s("#frozen", t("# frozen_string_literal: true")),
})

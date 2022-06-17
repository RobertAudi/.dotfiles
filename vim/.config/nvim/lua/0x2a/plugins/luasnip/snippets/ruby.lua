-- Module: 0x2a.plugins.luasnip.snippets.ruby
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("ruby", {
  snip(
    { trig = "module", name = "module ... end", dscr = "Module" },
    fmt(
      [[
        module {}
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "class", name = "class ... end", dscr = "Class" },
    fmt(
      [[
        class {}
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "controller", name = "Controller", dscr = "Ruby on Rails controller" },
    fmt(
      [[
        class {}Controller < ApplicationController
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "helper", name = "Helper", dscr = "Ruby on Rails helper" },
    fmt(
      [[
        module {}Helper
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "if", hidden = true },
    fmt(
      [[
        if {}
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "unless", hidden = true },
    fmt(
      [[
        unless {}
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "ife", hidden = true },
    fmt(
      [[
        if {}
          {}
        else
          # ...
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "elsif", hidden = true },
    fmt(
      [[
        elsif {}
          {}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "def", hidden = true },
    fmt(
      [[
        def {}
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "init", name = "def initialize", dscr = "" },
    fmt(
      [[
        def initialize
          {}
        end
      ]],
      { insert(0) }
    )
  ),

  snip(
    { trig = "case", name = "case ... when ... end", dscr = "case statement" },
    fmt(
      [[
        case {}
        when {}
          {}
        end
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),

  snip("pry", text("binding.pry")),
  snip("pry!", text("require \"pry\"; binding.pry")),
  snip("#frozen", text("# frozen_string_literal: true")),
})

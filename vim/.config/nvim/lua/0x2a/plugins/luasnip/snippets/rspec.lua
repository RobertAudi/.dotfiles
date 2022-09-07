-- Module: 0x2a.plugins.luasnip.snippets.rspec
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local choice = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.filetype_extend("rspec", { "ruby" })

ls.add_snippets("rspec", {
  snip(
    { trig = "Desc", name = "RSpec.describe", dscr = "RSpec group" },
    fmt(
      [[
        require "{}_helper.rb"

        RSpec.describe {}{} do
          {}
        end
      ]],
      {
        choice(1, { text("spec"), text("rails") }),
        insert(2),
        choice(3, {
          fmt(", type: :{}", { insert(1) }),
          text(""),
          text(", type: :model"),
          text(", type: :controller"),
          text(", type: :request"),
          text(", type: :job"),
          text(", type: :policy"),
        }),

        insert(0)
      }
    )
  ),

  snip(
    { trig = "desc", name = "describe", dscr = "Example group" },
    fmt(
      [[
        {} do
          {}
        end
      ]],
      {
        choice(1, {
          fmt([[describe "{}"]], { insert(1) }),
          fmt([[context "{}"]], { insert(1) }),
        }),

        insert(0)
      }
    )
  ),

  snip(
    { trig = "cont", name = "context", dscr = "Example group" },
    fmt(
      [[
        context "{}" do
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "it", name = "Example", dscr = "" },
    fmt(
      [[
        {} do
          {}
        end
      ]],
      {
        choice(1, {
          fmt([[it "{}"]], { insert(1) }),
          fmt([[specify "{}"]], { insert(1) }),
        }),

        insert(0)
      }
    )
  ),

  snip(
    { trig = "bef", name = "Before hook", dscr = "" },
    fmt(
      [[
        before do
          {}
        end
      ]],
      { insert(0) }
    )
  ),

  snip(
    { trig = "aft", name = "After hook", dscr = "" },
    fmt(
      [[
        after do
          {}
        end
      ]],
      { insert(0) }
    )
  ),
})

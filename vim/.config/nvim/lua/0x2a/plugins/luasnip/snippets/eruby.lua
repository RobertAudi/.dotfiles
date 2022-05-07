-- Module: 0x2a.plugins.luasnip.snippets.eruby
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("eruby", {
  s({ trig = "%", hidden = true }, fmt("<% {} %>", i(0))),
  s({ trig = "=", hidden = true }, fmt("<%= {} %>", i(0))),
  s({ trig = "#", hidden = true }, fmt("<%# {} %>", i(0))),

  s(
    { trig = "if", hidden = true },
    fmt(
      [[
        <% if {} %>
          {}
        <% end %>
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "unless", hidden = true },
    fmt(
      [[
        <% unless {} %>
          {}
        <% end %>
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "ife", hidden = true },
    fmt(
      [[
        <% if {} %>
          {}
        <% else %>
          # ...
        <% end %>
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "elsif", hidden = true },
    fmt(
      [[
        <% elsif {} %>
          {}
      ]],
      { i(1), i(0) }
    )
  ),

  s({ trig = "else", hidden = true }, { t("<% else %>") }),
  s({ trig = "end", hidden = true }, { t("<% end %>") }),

  s({ trig = "lt", name = "link_to", dscr = "" }, fmt("<%= link_to {} %>", i(0))),
  s(
    { trig = "lt", name = "link_to ... do", dscr = "link_to with a block" },
    fmt(
      [[
        <%= link_to {} do %>
          {}
        <% end %>
      ]],
      { i(1), i(0) }
    )
  ),

  s({ trig = "t", hidden = true }, fmt("<%= t {} %>", i(0))),
  s({ trig = "t", hidden = true }, fmt("<%= l {} %>", i(0))),

  s({ trig = "debug", hidden = true }, fmt("<%= debug {} %>", i(0))),
  s({ trig = "yield", hidden = true }, t("<%= yield %>")),
  s({ trig = "yield" }, fmt("<%= yield :{} %>", i(0))),

  s({ trig = "render", hidden = true }, fmt("<%= render {} %>", i(0))),
  s({ trig = "renderp", name = "render partial", dscr = "" }, fmt("<%= render partial: {} %>", i(0))),
})

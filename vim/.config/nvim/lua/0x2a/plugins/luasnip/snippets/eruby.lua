-- Module: 0x2a.plugins.luasnip.snippets.eruby
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("eruby", {
  snip({ trig = "%", hidden = true }, fmt("<% {} %>", insert(0))),
  snip({ trig = "=", hidden = true }, fmt("<%= {} %>", insert(0))),
  snip({ trig = "#", hidden = true }, fmt("<%# {} %>", insert(0))),

  snip(
    { trig = "if", hidden = true },
    fmt(
      [[
        <% if {} %>
          {}
        <% end %>
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "unless", hidden = true },
    fmt(
      [[
        <% unless {} %>
          {}
        <% end %>
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "ife", hidden = true },
    fmt(
      [[
        <% if {} %>
          {}
        <% else %>
          # ...
        <% end %>
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "elsif", hidden = true },
    fmt(
      [[
        <% elsif {} %>
          {}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip({ trig = "else", hidden = true }, { text("<% else %>") }),
  snip({ trig = "end", hidden = true }, { text("<% end %>") }),

  snip({ trig = "lt", name = "link_to", dscr = "" }, fmt("<%= link_to {} %>", insert(0))),
  snip(
    { trig = "lt", name = "link_to ... do", dscr = "link_to with a block" },
    fmt(
      [[
        <%= link_to {} do %>
          {}
        <% end %>
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip({ trig = "t", hidden = true }, fmt("<%= t {} %>", insert(0))),
  snip({ trig = "t", hidden = true }, fmt("<%= l {} %>", insert(0))),

  snip({ trig = "debug", hidden = true }, fmt("<%= debug {} %>", insert(0))),
  snip({ trig = "yield", hidden = true }, text("<%= yield %>")),
  snip({ trig = "yield" }, fmt("<%= yield :{} %>", insert(0))),

  snip({ trig = "render", hidden = true }, fmt("<%= render {} %>", insert(0))),
  snip({ trig = "renderp", name = "render partial", dscr = "" }, fmt("<%= render partial: {} %>", insert(0))),
})

-- Module: 0x2a.plugins.luasnip.snippets.eruby
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local node = ls.snippet_node
local choice = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("eruby", {
  snip(
    { trig = "%", hidden = true },
    choice(1, {
      node(nil, { text("<% "), insert(1), text(" %>") }),
      node(nil, { text("<%= "), insert(1), text(" %>") }),
      node(nil, { text("<%# "), insert(1), text(" %>") }),
    })
  ),

  snip(
    { trig = "=", hidden = true },
    choice(1, {
      node(nil, { text("<%= "), insert(1), text(" %>") }),
      node(nil, { text("<% "), insert(1), text(" %>") }),
      node(nil, { text("<%# "), insert(1), text(" %>") }),
    })
  ),

  snip(
    { trig = "#", hidden = true },
    choice(1, {
      node(nil, { text("<%# "), insert(1), text(" %>") }),
      node(nil, { text("<% "), insert(1), text(" %>") }),
      node(nil, { text("<%= "), insert(1), text(" %>") }),
    })
  ),

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

  -- TODO: Use a choice node instead of duplicating the snippet
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

  snip(
    { trig = "t", hidden = true },
    fmt("<%= {} %>", {
      choice(1, {
        fmt("t {}", insert(1)),
        fmt("l {}", insert(1)),
      }),
    })
  ),

  snip({ trig = "debug", hidden = true }, fmt("<%= debug {} %>", insert(0))),

  snip(
    { trig = "yield", hidden = true },
    fmt("<%= {}%>", {
      choice(1, {
        fmt("yield {}", insert(1)),
        fmt("yield :{} ", insert(1)),
      }),
    })
  ),

  snip(
    { trig = "render", hidden = true },
    fmt("<%= render {}{} %>", {
      choice(1, {
        fmt([["{}"]], insert(1)),
        fmt([[partial: "{}"]], insert(1)),
      }),
      insert(2)
    })
  ),
})

-- Module: 0x2a.plugins.luasnip.snippets.rust
-- Requires:
--   - L3MON4D3/LuaSnip

local ls = require("luasnip")
local snip = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rust", {
  snip(
    { trig = "if", hidden = true },
    fmt(
      [[
        if {} {{
            {}
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "iflet", name = "if let … = … { … }" },
    fmt(
      [[
        if let {} = {} {{
            {}
        }}
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),

  snip(
    { trig = "for", name = "for … in … { … }" },
    fmt(
      [[
        for {} in {} {{
            {}
        }}
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),

  snip(
    { trig = "match", name = "match … { … }", desc = "Control flow based on pattern matching" },
    fmt(
      [[
        match {} {{
            Some({}) => {},
            None => {},
        }}
      ]],
      { insert(1), insert(2), insert(3), insert(0) }
    )
  ),

  snip(
    { trig = "enum", name = "enum … { … }", desc = "A type that can be any one of several variants" },
    fmt(
      [[
        #[derive(Debug)]
        enum {} {{
            {},
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "struct", name = "struct … { … }", desc = "Struct with named fields" },
    fmt(
      [[
        #[derive(Debug)]
        struct {} {{
            {},
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "impl", name = "impl … { … }", desc = "Implement some functionality for a type" },
    fmt(
      [[
        impl {} {{
            {}
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "fn", hidden = true },
    fmt(
      [[
        fn {}({}: {}) -> {} {{
            {}
        }}
      ]],
      { insert(1), insert(2), insert(3), insert(4), insert(0) }
    )
  ),

  snip(
    { trig = "modtest", name = "#[cfg(test)]", desc = "test module" },
    fmt(
      [[
        #[cfg(test)]
        mod tests {{
            {}
        }}
      ]],
      { insert(0) }
    )
  ),

  snip(
    { trig = "test", name = "#[test]" },
    fmt(
      [[
        #[test]
        fn {}() {{
            {}
        }}
      ]],
      { insert(1), insert(0) }
    )
  ),
})

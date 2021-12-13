-- Plugin: LuaSnip
-- Description: Snippet Engine for Neovim written in Lua.
-- URL: https://github.com/L3MON4D3/LuaSnip

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.snippets = {
  all = {
    s("shrug", t("¯\\_(ツ)_/¯"))
  },

  sh = {
    s({ trig = "case", name = "case ... in ... esac", dscr = "case statement" }, {
        t("case "), i(1),
        t({ " in", "  " }), i(2),
        t({ ")", "    " }), i(0),
        t({  "", "    ;;", "esac" }),
      }),

    s({ trig = "if", name = "if ... then ... fi", dscr = "if statement" }, {
        t("if "), i(1),
        t({ " ; then", "  " }), i(0),
        t({ "", "fi" }),
      }),

    s({ trig = "ifel", name = "if ... then ... else ... fi", dscr = "if-else statement" }, {
        t("if "), i(1),
        t({ " ; then", "  " }), i(0),
        t({ "", "else", "  # ...", "fi" }),
      }),

    s({ trig = "ifelif", name = "if ... then ... else ... fi", dscr = "if-else statement" }, {
        t("if "), i(1),
        t({ " ; then", "  " }), i(0),
        t({ "", "elif " }), i(2),
        t({ " ; then", "  # ...", "else", "  # ...", "fi" }),
      }),
  },

  zsh = {
    s({ trig = "fun", name = "...() { ... }", dscr = "Function" }, {
        i(1), t({ "() {", "  " }),
        i(0),
        t({ "", "}" }),
      }),

    s({ trig = "fun", name = "function { ... }", dscr = "Anonymous function" }, {
        t({ "function {", "  " }),
        i(0),
        t({ "", "}" }),
      }),
  },

  ruby = {
    s({ trig = "if", hidden = true }, {
        t("if "), i(1), t({ "", "  " }),
        i(0),
        t({ "", "end" })
      }),
    s({ trig = "ife", hidden = true }, {
        t("if "), i(1), t({ "", "  " }),
        i(2),
        t({ "", "else", "  " }),
        i(0),
        t({ "", "end" })
      }),
    s({ trig = "elsif", hidden = true }, {
        t("elsif "), i(1), t({ "", "  " }),
        i(0)
      }),

    s({ trig = "def", hidden = true }, {
        t("def "), i(1), t({ "", "  " }),
        i(0),
        t({ "", "end" })
      }),

    s({ trig = "init", name = "def initialize", dscr = "" }, {
        t({ "def initialize", "  " }),
        i(0),
        t({ "", "end" }),
      }),

    s({ trig = "case", name = "case ... when ... end", dscr = "case statement" }, {
        t("case "), i(1),
        t({ "", "when" }), i(2),
        t("", "  "), i(0),
        t("", "end"),
      }),

    s("pry", t("binding.pry")),
    s("pry!", t("require \"pry\"; binding.pry")),
    s("#frozen", t("# frozen_string_literal: true")),
  },

  eruby = {
    s({ trig = "%", hidden = true }, { t("<% "), i(0), t(" %>") }),
    s({ trig = "=", hidden = true }, { t("<%= "), i(0), t(" %>") }),

    s({ trig = "if", hidden = true }, {
        t("<% if "), i(1), t({ " %>", "  " }),
        i(0),
        t({ "", "<% end %>" })
      }),

    s({ trig = "ife", hidden = true }, {
        t("<% if "), i(1), t({ " %>", "  " }),
        i(2),
        t({ "", "<% else %>", "  " }),
        i(0),
        t({ "", "<% end %>" })
      }),

    s({ trig = "elsif", hidden = true }, {
        t("<% elsif "), i(1), t({ " %>", "  " }),
        i(0)
      }),

    s({ trig = "end", hidden = true }, { t("<% end %>") }),

    s({ trig = "lt", name = "link_to", dscr = "" }, { t("<%= link_to \""), i(1), t("\", "), i(0), t(" %>") }),
    s({ trig = "lt", name = "link_to ... do", dscr = "link_to with a block" }, {
      t("<%= link_to "), i(0), t({ " do %>", "  " }),
      i(0),
      t({ "", "<% end %>" })
    }),

    s({ trig = "t", hidden = true }, { t("<%= t "), i(0), t(" %>") }),
    s({ trig = "l", hidden = true }, { t("<%= l "), i(0), t(" %>") }),

    s({ trig = "debug" }, { t("<%= debug "), i(0), t(" %>") }),
    s({ trig = "yield", hidden = true }, { t("<%= yield %>") }),
    s({ trig = "yield" }, { t("<%= yield :"), i(0), t(" %>") }),

    s({ trig = "render", hidden = true }, { t("<%= render "), i(0), t(" %>") }),
    s({ trig = "renderp", name = "render partial", dscr = "" },
      { t("<%= render partial: \""), i(0), t("\" %>") }),
  },

  rspec = {
    s({ trig = "desc", name = "describe", dscr = "Example group" }, {
        t("describe "), i(1), t({ " do", "  " }),
        i(0),
        t({ "", "end" })
      }),

    s({ trig = "cont", name = "context", dscr = "Example group" }, {
        t("context "), i(1), t({ " do", "  " }),
        i(0),
        t({ "", "end" })
      }),

    s({ trig = "it", name = "Example", dscr = "" }, {
        t("it \""), i(1), t({ "\" do", "  " }),
        i(0),
        t({ "", "end" })
      }),

    s({ trig = "bef", name = "Before hook", dscr = "" }, {
        t({ "before do", "  " }), i(0), t({ "", "end" })
      }),

    s({ trig = "aft", name = "After hook", dscr = "" }, {
        t({ "after do", "  " }), i(0), t({ "", "end" })
      }),
  },

  javascript = {
    s({ trig = "log", dscr = "console.log" }, {
        t("console.log("), i(0), t(");")
      }),
  },
}

ls.filetype_extend("zsh", { "sh" })
ls.filetype_extend("rspec", { "ruby" })

vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>luasnip-expand-or-jump", {})

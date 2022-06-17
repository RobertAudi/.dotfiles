-- Module: 0x2a.plugins.luasnip.snippets.lua
-- Requires:
--   - L3MON4D3/LuaSnip
--   - 0x2a.luasnip.utils

local ls = require("luasnip")
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local choice = ls.choice_node
local insert = ls.insert_node
local func = ls.function_node
local dynamic = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local utils = require("0x2a.utils")
local string_utils = require("0x2a.utils.string")
local lsutils = require("0x2a.plugins.luasnip.utils")
local same = lsutils.same
local TM_FILENAME = lsutils.TM_FILENAME
local Path = require("plenary.path")

local lua_require_variable = function(args, _)
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })

  local options = {}
  for len = 0, #split - 1 do
    table.insert(options, text(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end

  return node(nil, { choice(1, options) })
end

local plugin_from_clipboard = function(_, _, opts)
  local clipboard = lsutils.CLIPBOARD({ strip = true })

  if not clipboard then
    return ""
  end

  opts = utils.normalize_options(opts)

  local plugin = string.gsub(clipboard, "https?://github%.com/", "")

  if not utils.is_empty(plugin) and opts.only_repo then
    plugin = string.gsub(plugin, "^[^/]+/", "")
  end

  return plugin
end

local module_name = function(_, snip, _)
  local filename = snip.env.TM_FILENAME

  if string_utils.ends_with(filename, "init.lua") then
    local parent = vim.fn.fnamemodify(Path:new(filename):parent().filename, ":t")

    if not utils.is_empty(parent) then
      filename = parent
    end
  else
    filename = filename:gsub("%.lua", "")
  end

  return filename
end

local plugin_header_component = function(_, snip, opts)
  opts = utils.normalize_options(opts)

  if opts.component == "module" then
    local name = plugin_from_clipboard(_, _, { only_repo = true })

    if utils.is_empty(name) then
      name = module_name(_, snip, _)
    end

    return "0x2a.plugins." .. name
  elseif opts.component == "plugin" then
    plugin = plugin_from_clipboard(_, _, _)

    if utils.is_empty(plugin) then
      plugin = "NAME/REPO"
    end

    return plugin
  elseif opts.component == "url" then
    local url = lsutils.CLIPBOARD({ strip = true })

    if utils.is_empty(url) then
      url = "https://github.com/USER/REPO"
    end

    return url
  else
    return "..."
  end
end

ls.add_snippets("lua", {
  snip(
    { trig = "header", name = "Vim plugin header", dscr = "Header for vim plugin files" },
    fmt(
      [[
        -- Plugin: {}
        -- Description: PLUGIN DESCRIPTION
        -- URL: https://github.com/USER/{}

        {}
      ]],
      { func(TM_FILENAME(), {}), func(TM_FILENAME(), {}), insert(0) }
    )
  ),

  snip(
    { trig = "mod", name = "Lua module" },
    fmt(
      [[
        -- Module: {}

        local {} = {{}}

        {}

        return {}
      ]],
      { func(module_name, {}), insert(1), insert(0), same(1) }
    )
  ),

  snip(
    { trig = "plugconf", name = "Plugin config file" },
    fmt(
      [[
        -- Module: {}
        -- Plugin: {}
        -- Description: PLUGIN DESCRIPTION
        -- URL: {}
        -- Requires:
        --   - ...

        local M = {{}}

        M.config = function()
          {}
        end

        return M
      ]],
      {
        func(plugin_header_component, {}, { user_args = { { component = "module" } } }),
        func(plugin_header_component, {}, { user_args = { { component = "plugin" } } }),
        func(plugin_header_component, {}, { user_args = { { component = "url" } } }),
        insert(0),
      }
    )
  ),

  snip(
    { trig = "fun", name = "function", dscr = "Lua function" },
    fmt(
      [[
        function {}({})
          {}
        end
      ]],
      { insert(1), insert(2), insert(0) }
    )
  ),

  snip(
    { trig = "fun", name = "anonymous function", dscr = "Lua anonymous function" },
    fmt(
      [[
        function({})
          {}
        end
      ]],
      { insert(1), insert(0) }
    )
  ),

  snip(
    { trig = "req", name = "require", dscr = "require file" },
    fmt([[local {} = require("{}")]], { dynamic(2, lua_require_variable, { 1 }), insert(1) })
  ),

  snip({ trig = "ins", name = "Inspect var" }, fmt("print(vim.inspect({})){}", { insert(1), insert(0) })),

  snip(
    { trig = "use", name = [[use({ "..." })]], dscr = "Packer plugin definition" },
    fmt(
      [[
        -- PLUGIN DESCRIPTION
        --   {}
        use({{ "{}", config = require("0x2a.plugins.{}").config }})
      ]],
      {
        func(lsutils.CLIPBOARD, {}, { user_args = { { strip = true } } }),
        func(plugin_from_clipboard, {}),
        func(plugin_from_clipboard, {}, { user_args = { { only_repo = true } } }),
      }
    )
  ),
})

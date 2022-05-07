-- Module: 0x2a.plugins.luasnip.snippets.lua
-- Requires:
--   - L3MON4D3/LuaSnip
--   - 0x2a.luasnip.utils

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.sn
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
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
    table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end

  return sn(nil, { c(1, options) })
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
  s(
    { trig = "header", name = "Vim plugin header", dscr = "Header for vim plugin files" },
    fmt(
      [[
        -- Plugin: {}
        -- Description: PLUGIN DESCRIPTION
        -- URL: https://github.com/USER/{}

        {}
      ]],
      { f(TM_FILENAME(), {}), f(TM_FILENAME(), {}), i(0) }
    )
  ),

  s(
    { trig = "mod", name = "Lua module" },
    fmt(
      [[
        -- Module: {}

        local {} = {{}}

        {}

        return {}
      ]],
      { f(module_name, {}), i(1), i(0), same(1) }
    )
  ),

  s(
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
        f(plugin_header_component, {}, { user_args = { { component = "module" } } }),
        f(plugin_header_component, {}, { user_args = { { component = "plugin" } } }),
        f(plugin_header_component, {}, { user_args = { { component = "url" } } }),
        i(0),
      }
    )
  ),

  s(
    { trig = "fun", name = "function", dscr = "Lua function" },
    fmt(
      [[
        function {}({})
          {}
        end
      ]],
      { i(1), i(2), i(0) }
    )
  ),

  s(
    { trig = "fun", name = "anonymous function", dscr = "Lua anonymous function" },
    fmt(
      [[
        function({})
          {}
        end
      ]],
      { i(1), i(0) }
    )
  ),

  s(
    { trig = "req", name = "require", dscr = "require file" },
    fmt([[local {} = require("{}")]], { d(2, lua_require_variable, { 1 }), i(1) })
  ),

  s({ trig = "ins", name = "Inspect var" }, fmt("print(vim.inspect({})){}", { i(1), i(0) })),

  s(
    { trig = "use", name = [[use({ "..." })]], dscr = "Packer plugin definition" },
    fmt(
      [[
        -- PLUGIN DESCRIPTION
        --   {}
        use({{ "{}", config = require("0x2a.plugins.{}").config }})
      ]],
      {
        f(lsutils.CLIPBOARD, {}, { user_args = { { strip = true } } }),
        f(plugin_from_clipboard, {}),
        f(plugin_from_clipboard, {}, { user_args = { { only_repo = true } } }),
      }
    )
  ),
})

-- Module: 0x2a.plugins.urlview
-- Plugin: axieax/urlview.nvim
-- Description: 🔎 Neovim plugin for viewing all the URLs in a buffer
-- URL: https://github.com/axieax/urlview.nvim

local M = {}

M.config = function()
  require("urlview").setup({
    -- Prompt title (`<context> <default_title>`, e.g. `Buffer Links:`)
    default_title = "Links:",

    -- Default picker to display links with
    -- Options: "native" (vim.ui.select) or "telescope"
    default_picker = "telescope",

    -- Set the default protocol for us to prefix URLs with if they don't start with http/https
    default_prefix = "https://",

    -- Command or method to open links with
    -- Options: "netrw", "system" (default OS browser); or "firefox", "chromium" etc.
    navigate_method = "system",

    -- Ensure links shown in the picker are unique (no duplicates)
    unique = true,

    -- Ensure links shown in the picker are sorted alphabetically
    sorted = true,

    -- Logs user warnings (recommended for error detection)
    debug = false,

    -- Custom search captures
    -- NOTE: captures follow Lua pattern matching
    -- https://riptutorial.com/lua/example/20315/lua-pattern-matching
    custom_searches = {
      -- KEY: search source name
      -- VALUE: custom search function or table (map with keys capture, format)
    },
  })
end

return M

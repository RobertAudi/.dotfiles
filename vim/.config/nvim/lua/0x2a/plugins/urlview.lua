-- Module: 0x2a.plugins.urlview
-- Plugin: axieax/urlview.nvim
-- Description: 🔎 Neovim plugin for viewing all the URLs in a buffer
-- URL: https://github.com/axieax/urlview.nvim
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.buffer

local M = {}

M.config = function()
  local ok, urlview = pcall(require, "urlview")

  if not ok then
    return
  end

  urlview.setup({
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
    custom_searches = {
      github = {
        capture = "['\"]([%w_.-]+/[%w_.-]+)['\"]",
        format = "https://github.com/%s",
      },
    },
  })

  -- FIXME: This code is puke, refactor it
  -- Open URL under the cursor
  vim.keymap.set({ "n", "x" }, "<Leader>o", function()
    local utils = require("0x2a.utils")
    local content = vim.fn.expand("<cWORD>")
    local selection = require("0x2a.utils").get_visual_selection()

    if utils.is_blank(content) and utils.is_blank(selection) then
      require("telescope").extensions.urlview.urlview({})
    else
      local url_utils = require("urlview.utils")
      local search = require("urlview.search")

      local links = ""

      if not utils.is_blank(selection) then
        links = require("urlview.search").github(selection)
      end

      if utils.is_blank(links) and not utils.is_blank(content) then
        links = require("urlview.search.helpers").content(content)
      end

      if utils.is_blank(links) then
        local current_line = vim.fn.getline(".")

        links = require("urlview.search").github(current_line)

        if utils.is_blank(links) then
          links = require("urlview.search.helpers").content(current_line)
        end
      end

      local opts = { title = string.format("Buffer %s", require("urlview.config").default_title) }

      links = url_utils.prepare_links(links, opts)

      if utils.is_blank(links) then
        require("telescope").extensions.urlview.urlview({})
      elseif #links > 1 then
        require("urlview.pickers").telescope(links, opts)
      else
        url_utils.navigate_url(links[1])
      end
    end
  end, { noremap = true, silent = true, desc = "Open URL under the cursor" })
end

return M

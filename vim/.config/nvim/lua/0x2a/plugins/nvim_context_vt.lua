-- Module: 0x2a.plugins.nvim_context_vt
-- Plugin: haringsrob/nvim_context_vt
-- Description: Virtual text context for neovim treesitter
-- URL: https://github.com/haringsrob/nvim_context_vt

local M = {}

M.config = function()
  local ok, _ = pcall(require, "nvim_context_vt")

  if not ok then
    return
  end

  require("nvim_context_vt").setup({
    -- Enable by default. You can disable and use :NvimContextVtToggle to maually enable.
    -- Default: true
    enabled = true,

    -- Override default virtual text prefix
    -- Default: '-->'
    prefix = "─",

    -- Override the internal highlight group name
    -- Default: 'ContextVt'
    highlight = "ContextVt",

    -- Disable virtual text for given filetypes
    -- Default: { 'markdown' }
    -- disable_ft = { "markdown" },

    -- Disable display of virtual text below blocks for indentation based languages like Python
    -- Default: false
    disable_virtual_lines = true,

    -- Same as above but only for spesific filetypes
    -- Default: {}
    -- disable_virtual_lines_ft = {},

    -- How many lines required after starting position to show virtual text
    -- Default: 1 (equals two lines total)
    min_rows = 1,

    -- Same as above but only for spesific filetypes
    -- Default: {}
    -- min_rows_ft = {},

    -- Custom virtual text node parser callback
    -- Default: nil
    -- custom_parser = function(node, ft, opts)
    --   local utils = require("nvim_context_vt.utils")
    --
    --   -- If you return `nil`, no virtual text will be displayed.
    --   if node:type() == "function" then
    --     return nil
    --   end
    --
    --   -- This is the standard text
    --   return "--> " .. utils.get_node_text(node)[1]
    -- end,

    -- Custom node validator callback
    -- Default: nil
    -- custom_validator = function(node, ft, opts)
    --   -- Internally a node is matched against min_rows and configured targets
    --   local default_validator = require("nvim_context_vt.utils").default_validator
    --   if default_validator(node, ft) then
    --     -- Custom behaviour after using the internal validator
    --     if node:type() == "function" then
    --       return false
    --     end
    --   end
    --
    --   return true
    -- end,

    -- Custom node virtual text resolver callback
    -- Default: nil
    -- custom_resolver = function(nodes, ft, opts)
    --   -- By default the last node is used
    --   return nodes[#nodes]
    -- end,
  })
end

return M

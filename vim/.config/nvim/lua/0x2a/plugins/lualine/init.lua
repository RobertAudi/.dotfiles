-- Module: 0x2a.plugins.lualine
-- Plugin: nvim-lualine/lualine.nvim
-- Description: A blazing fast and easy to configure neovim statusline plugin written in pure lua.
-- URL: https://github.com/nvim-lualine/lualine.nvim
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.plugins.lualine.components
--   - 0x2a.plugins.lualine.themes.eighties
--   - SmiteshP/nvim-gps

local M = {}

M.config = function()
  local symbols = require("0x2a.symbols")
  local components = require("0x2a.plugins.lualine.components")

  local gps = require("nvim-gps")

  -- Don't show the current mode
  -- Let lualine take care of that
  vim.api.nvim_set_option("showmode", false)

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = require("0x2a.plugins.lualine.themes.eighties"),
      component_separators = { left = symbols.separators.vertical, right = symbols.separators.vertical },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },

    sections = {
      lualine_a = { components.mode },
      lualine_b = { components.paste },
      lualine_c = {
        { "branch", icon = symbols.git.repo },

        components.filename,
        components.filetype,
        { gps.get_location, cond = gps.is_available },
      },

      lualine_x = {},
      lualine_y = { components.progress },
      lualine_z = { components.location },
    },

    inactive_sections = {
      lualine_a = { components.filename },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },

    tabline = {
      lualine_a = {
        {
          "tabs",
          mode = 2,

          tabs_color = {
            active = "lualine_x_normal",
            inactive = "lualine_b_inactive",
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  })
end

return M

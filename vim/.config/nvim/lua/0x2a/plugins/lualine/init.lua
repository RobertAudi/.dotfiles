-- Module: 0x2a.plugins.lualine
-- Plugin: nvim-lualine/lualine.nvim
-- Description: A blazing fast and easy to configure neovim statusline plugin written in pure lua.
-- URL: https://github.com/nvim-lualine/lualine.nvim
-- Requires:
--   - 0x2a.symbols
--   - 0x2a.plugins.lualine.components
--   - 0x2a.plugins.lualine.themes.eighties

local M = {}

M.config = function()
  local lualine = prequire("lualine")

  if not lualine then
    return
  end

  local symbols = require("0x2a.symbols")
  local components = require("0x2a.plugins.lualine.components")

  -- Don't show the current mode
  -- Let lualine take care of that
  vim.api.nvim_set_option("showmode", false)

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = require("0x2a.plugins.lualine.themes.eighties"),
      component_separators = { left = symbols.separators.vertical, right = symbols.separators.vertical },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha" },
      always_divide_middle = true,
      globalstatus = true,
    },

    extensions = { "aerial", "man", "fzf", "quickfix" },

    sections = {
      lualine_a = { components.mode }, -- TODO: Set custom colors for plugins and Hydra submodes
      lualine_b = { components.paste },
      lualine_c = {
        components.git,
        components.filename,
        components.filetype,
        components.navic,
      },

      lualine_x = {
        components.diff,
        components.diagnostics,
      },

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
          max_length = function()
            return vim.o.columns
          end,

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

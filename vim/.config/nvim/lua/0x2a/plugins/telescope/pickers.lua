-- Module: 0x2a.plugins.telescope.pickers
-- Plugin: nvim-telescope/telescope.nvim
-- Description: Find, Filter, Preview, Pick. All lua, all the time.
-- URL: https://github.com/nvim-telescope/telescope.nvim

local M = {}

-- Source: https://github.com/anuvyklack/dotfiles/blob/baf8b43e3d91236a3bd773278fd01895959f894e/roles/neovim/files/lua/anuvyklack/telescope/pickers.lua#L137,162
M.document_symbols = function()
  local symbols = {
    "All",
    "Variable",
    "Function",
    "Constant",
    "Class",
    "Property",
    "Method",
    "Enum",
    "Interface",
    "Boolean",
    "Number",
    "String",
    "Array",
    "Constructor",
  }

  vim.ui.select(symbols, { prompt = "Select which symbol" }, function(item)
    if item == "All" then
      require("telescope.builtin").lsp_document_symbols()
    else
      require("telescope.builtin").lsp_document_symbols({ symbols = item })
    end
  end)
end

return M

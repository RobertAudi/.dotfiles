-- Module: 0x2a.plugins.indent-blankline
-- Plugin: lukas-reineke/indent-blankline.nvim
-- Description: Indent guides for Neovim
-- URL: https://github.com/lukas-reineke/indent-blankline.nvim

local M = {}

M.config = function()
  require("indent_blankline").setup({
    char = "│",

    bufname_exclude = {},
    buftype_exclude = { "terminal", "telescope", "nofile" },
    filetype_exclude = {
      "Float",
      "NvimTree",
      "TelescopePrompt",
      "TelescopeResults",
      "Trouble",
      "Trouble",
      "aerial",
      "ctrlsf",
      "git",
      "gitblame",
      "help",
      "packer",
      "toggleterm",
    },

    show_trailing_blankline_indent = false,
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = false,
    show_end_of_line = false,
    space_char_blankline = " ",
  })
end

return M

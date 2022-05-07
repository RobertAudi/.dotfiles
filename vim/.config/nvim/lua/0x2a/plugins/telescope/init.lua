-- Module: 0x2a.plugins.telescope
-- Plugin: nvim-telescope/telescope.nvim
-- Description: Find, Filter, Preview, Pick. All lua, all the time.
-- URL: https://github.com/nvim-telescope/telescope.nvim
-- Requires:
--   - stevearc/aerial.nvim
--   - 0x2a.plugins.telescope.picker.yanky

local M = {}

M.config = function()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
        height = 0.5,
        width = 0.75,
        horizontal = {
          width_padding = 0.04,
          height_padding = 0.1,
          preview_width = 0,
        },
        vertical = {
          width_padding = 0.05,
          height_padding = 1,
          preview_width = 0,
        },
      },
    },

    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
      },

      symbols = {
        sources = { "0x2a" },
      },

      builtin = {
        include_extensions = true,
      },
    },

    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("ui-select")

  local aerial_ok, _ = pcall(require, "aerial")

  if aerial_ok then
    telescope.load_extension("aerial")
  end

  vim.keymap.set("n", "<C-p>", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]])
  vim.keymap.set("n", "<C-b>", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]])
  vim.keymap.set("n", "<C-Space>", [[<Cmd>lua require("telescope.builtin").builtin()<CR>]])

  local yanky_ok, _ = pcall(require, "yanky")

  if yanky_ok then
    vim.keymap.set("n", "<C-y>", [[<Cmd>lua require("0x2a.plugins.telescope.pickers.yanky").yank_history({})<CR>]])
  end
end

return M

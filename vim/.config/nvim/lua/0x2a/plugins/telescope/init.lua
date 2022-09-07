-- Module: 0x2a.plugins.telescope
-- Plugin: nvim-telescope/telescope.nvim
-- Description: Find, Filter, Preview, Pick. All lua, all the time.
-- URL: https://github.com/nvim-telescope/telescope.nvim
-- Requires:
--   - 0x2a.symbols

local M = {}

M.config = function()
  local telescope = prequire("telescope")

  if not telescope then
    return
  end

  local symbols = require("0x2a.symbols").telescope

  telescope.setup({
    defaults = {
      prompt_prefix = symbols.prompt,
      selection_caret = symbols.selection,
      borderchars = symbols.borders,
      winblend = 10,
      sorting_strategy = "ascending",
      layout_strategy = "flex",
      layout_config = {
        flex = {
          flip_columns = 120,
        },

        horizontal = {
          prompt_position = "top",
          height = 0.75,
          width = 0.85,
          preview_width = 0.5,
        },
        vertical = {
          prompt_position = "bottom",
          width = 0.85,
          height = 0.85,
          preview_height = 0.65,
        },
      },
    },

    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
        mappings = {
          i = {
            ["<Esc>"] = "close",
          },
        },
      },

      buffers = {
        show_all_buffers = true,
        sort_lastused = true,
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

  if prequire("urlview") then
    telescope.load_extension("urlview")
  end

  telescope.load_extension("conflicts")
  telescope.load_extension("tabs")

  vim.keymap.set("n", "<C-p>", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], { noremap = true })
  vim.keymap.set("n", "<C-b>", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], { noremap = true })
  vim.keymap.set("n", "<C-Space>", [[<Cmd>lua require("telescope.builtin").builtin()<CR>]], { noremap = true })

  vim.keymap.set("n", "gr", function()
    require("telescope.builtin").lsp_references({
      layout_config = {
        horizontal = {
          preview_width = 80,
        },
      },
    })
  end, { noremap = true })

  vim.keymap.set("n", "gd", function()
    require("telescope.builtin").lsp_definitions({
      layout_config = {
        horizontal = {
          preview_width = 80,
        },
      },
    })
  end, { noremap = true })
end

return M

-- Module: 0x2a.plugins.renamer
-- Plugin: filipdutescu/renamer.nvim
-- Description: VS Code-like renaming UI for Neovim, writen in Lua
-- URL: https://github.com/filipdutescu/renamer.nvim

local M = {}

M.config = function()
  local renamer = prequire("renamer")

  if not renamer then
    return
  end

  local mappings_utils = require("renamer.mappings.utils")

  renamer.setup({
    -- The popup title, shown if `border` is true
    title = "Rename",

    -- The padding around the popup content
    padding = {
      top = 0,
      left = 0,
      bottom = 0,
      right = 0,
    },

    -- The minimum width of the popup
    min_width = 30,

    -- The maximum width of the popup
    max_width = 80,

    -- Whether or not to shown a border around the popup
    border = true,

    -- The characters which make up the border
    border_chars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

    -- Whether or not to highlight the current word references through LSP
    show_refs = true,

    -- Whether or not to add resulting changes to the quickfix list
    with_qf_list = false,

    -- Whether or not to enter the new name through the UI or Neovim's `input`
    -- prompt
    with_popup = true,

    -- The keymaps available while in the `renamer` buffer. The example below
    -- overrides the default values, but you can add others as well.
    mappings = {
      ["<C-a>"] = mappings_utils.set_cursor_to_start,
      ["<C-e>"] = mappings_utils.set_cursor_to_end,
      ["<C-u>"] = mappings_utils.clear_line,
    },

    -- Custom handler to be run after successfully renaming the word. Receives
    -- the LSP 'textDocument/rename' raw response as its parameter.
    handler = nil,
  })

  vim.keymap.set(
    { "n", "x" },
    "<LocalLeader>rr",
    [[<Cmd>lua require("renamer").rename()<CR>]],
    { noremap = true, silent = true }
  )
end

return M

-- Module: 0x2a.plugins.nvim-tree.callbacks
-- Plugin: kyazdani42/nvim-tree.lua
-- Description: A file explorer tree for neovim written in lua
-- URL: https://github.com/kyazdani42/nvim-tree.lua

local tree = require("nvim-tree")
local tree_diagnostics = require("nvim-tree.diagnostics")
local tree_movements = require("nvim-tree.actions.movements")
local tree_lib = require("nvim-tree.lib")
local tree_renderer = require("nvim-tree.renderer")
local tree_view = require("nvim-tree.view")
local tree_utils = require("nvim-tree.utils")

local M = {}

M.expand = function(node)
  if tree_view.is_help_ui() then
    return
  end

  node = node or tree_lib.get_node_at_cursor()

  if not node then
    return
  end

  if not node.open or #node.nodes == 0 then
    tree.on_keypress("edit")
  end
end

M.collapse = function(node)
  if tree_view.is_help_ui() then
    return
  end

  node = node or tree_lib.get_node_at_cursor()

  if not node or node.name == ".." then
    return
  end

  if node.nodes == nil then
    tree_movements.parent_node(false)(node)
  elseif node.open then
    node.open = false
    tree_renderer.draw()
    tree_diagnostics.update()
  else
    tree_movements.parent_node(false)(node)
  end
end

local is_zoomed = false

M.zoom = function(node)
  if tree_view.is_vertical() then
    local size = is_zoomed and 30 or math.floor(vim.o.columns * 35 / 100)

    vim.api.nvim_win_set_width(tree_view.get_winnr(), size)
  else
    local size = is_zoomed and 30 or math.floor(vim.o.lines * 35 / 100)

    vim.api.nvim_win_set_height(tree_view.get_winnr(), size)
  end

  is_zoomed = not is_zoomed
end

-- FIXME: The code is broken
M.quit_or_close_help = function(node)
  if tree_view.is_help_ui() then
    tree.on_keypress("toggle_help")
  else
    tree.on_keypress("close")
  end
end

-- Improvements:
--
-- - Support other markdown extentions
-- - Support other filetypes with exceptions:
--   - the file is a non-binary readable file (ie: not a directory)
--   - the file is not too big
-- - Open the file if it's not previewable but is readable
-- - Expand/collapse directories
M.preview = function(node)
  node = node or tree_lib.get_node_at_cursor()

  if not string.match(node.name, ".+%.md$") then
    tree_utils.warn("E000: Not a markdown file")
    return
  end

  if not os.execute("marked " .. node.name .. " &> /dev/null") then
    tree_utils.warn("E000: Unable to preview markdown file")
  end
end

return M

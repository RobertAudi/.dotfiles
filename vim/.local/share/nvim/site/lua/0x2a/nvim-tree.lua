local tree = require("nvim-tree")
local tree_lib = require("nvim-tree.lib")
local tree_view = require("nvim-tree.view")

local M = {}

local function nvim_tree_callback(callback_name)
  return string.format(":lua require('0x2a.nvim-tree').%s()<CR>", callback_name)
end

function M.expand()
  if tree_view.is_help_ui() then return end

  local node = tree_lib.get_node_at_cursor()
  if not node then return end

  if not node.open or #node.entries == 0 then
    tree.on_keypress("edit")
  end
end

function M.collapse()
  if tree_view.is_help_ui() then return end

  local node = tree_lib.get_node_at_cursor()
  if not node then return end

  if not node.entries or #node.entries == 0 then
    tree_lib.parent_node(node, false)
  elseif node.open then
    node.open = false
    tree_lib.redraw()
  else
    tree_lib.parent_node(node, false)
  end
end

local is_zoomed = false

function M.zoom()
  if is_zoomed then
    tree.resize(30)
  else
    tree.resize("35%")
  end

  is_zoomed = not is_zoomed
end

function M.quit_or_close_help()
  if tree_view.is_help_ui() then
    tree_lib.toggle_help()
  else
    tree.close()
  end
end

local callbacks = {
  expand = true,
  collapse = true,
  zoom = true,
  quit_or_close_help = true,
}

function M.callback(callback_name)
  if callbacks[callback_name] ~= nil then
    return nvim_tree_callback(callback_name)
  else
    return require("nvim-tree.config").nvim_tree_callback(callback_name)
  end
end

return M

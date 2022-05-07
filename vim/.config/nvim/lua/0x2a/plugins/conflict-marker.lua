-- Module: 0x2a.plugins.conflict-marker
-- Plugin: rhysd/conflict-marker.vim
-- Description: Weapon to fight against conflicts in Vim.
-- URL: https://github.com/rhysd/conflict-marker.vim

local M = {}

M.config = function()
  vim.g.conflict_marker_enable_mappings = false
  vim.g.conflict_marker_highlight_group = ""

  -- Include text after begin and end markers
  vim.g.conflict_marker_begin = "^<<<<<<< .*$"
  vim.g.conflict_marker_end = "^>>>>>>> .*$"

  vim.keymap.set("n", "]x", "<Plug>(conflict-marker-next-hunk)", { remap = true, buffer = true })
  vim.keymap.set("n", "[x", "<Plug>(conflict-marker-prev-hunk)", { remap = true, buffer = true })
end

return M

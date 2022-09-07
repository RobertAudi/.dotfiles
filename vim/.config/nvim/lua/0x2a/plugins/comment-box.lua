-- Module: 0x2a.plugins.comment-box
-- Plugin: LudoPinelli/comment-box.nvim
-- Description: ✨ Clarify and beautify your comments using boxes and lines.
-- URL: https://github.com/LudoPinelli/comment-box.nvim

local M = {}

M.config = function()
  local comment_box = prequire("comment-box")

  if not comment_box then
    return
  end

  comment_box.setup({
    -- width of the document
    doc_width = 80,

    -- width of the boxes
    box_width = 60,

    -- symbols used to draw a box
    borders = {
      top = "─",
      bottom = "─",
      left = "│",
      right = "│",
      top_left = "┌",
      top_right = "┐",
      bottom_left = "└",
      bottom_right = "┘",
    },

    -- width of the lines
    line_width = 70,

    -- symbols used to draw a line
    line = {
      line = "─",
      line_start = "─",
      line_end = "─",
    },

    -- insert a blank line above and below the box
    outer_blank_lines = false,

    -- insert a blank line above and below the text
    inner_blank_lines = false,

    -- insert a blank line above the line
    line_blank_line_above = false,

    -- insert a blank line below the line
    line_blank_line_below = false,
  })
end

return M

-- Module: 0x2a.plugins.Comment
-- Plugin: numToStr/Comment.nvim
-- Description: Smart and powerful comment plugin for neovim.
-- URL: https://github.com/numToStr/Comment.nvim

local M = {}

M.config = function()
  require("Comment").setup({
    -- Add a space b/w comment and the line
    padding = true,

    -- Whether the cursor should stay at its position
    sticky = true,

    -- Lines to be ignored while comment/uncomment.
    -- Could be a regex string or a function that returns a regex string.
    -- Example: Use '^$' to ignore empty lines
    ignore = nil,

    -- LHS of toggle mappings in NORMAL + VISUAL mode
    toggler = {
      -- Line-comment toggle keymap
      line = "gcc",

      -- Disable block-comment toggle keymap
      block = "<Nop>",
    },

    -- LHS of operator-pending mappings in NORMAL + VISUAL mode
    opleader = {
      -- Line-comment keymap
      line = "gc",

      -- Disable block-comment keymap
      block = "<Nop>",
    },

    -- LHS of extra mappings
    extra = {
      -- Add comment on the line above
      above = "gcO",

      -- Add comment on the line below
      below = "gco",

      -- Add comment at the end of line
      eol = "gcA",
    },

    -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    mappings = {
      -- Operator-pending mapping
      -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
      basic = true,

      -- Extra mapping
      -- Includes `gco`, `gcO`, `gcA`
      extra = true,

      -- Extended mapping
      -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },

    pre_hook = function(ctx)
      local U = require("Comment.utils")

      local location = nil

      if ctx.ctype == U.ctype.block then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring({
        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
        location = location,
      })
    end,
  })

  vim.keymap.set("n", "gx", "gccyypgcc", { remap = true, desc = "Duplicate line and comment out the original" })
end

return M

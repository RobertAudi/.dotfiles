-- Module: 0x2a.plugins.marks
-- Plugin: chentoast/marks.nvim
-- Description: A better user experience for viewing and interacting with Vim marks.
-- URL: https://github.com/chentoast/marks.nvim

local M = {}

M.config = function()
  require("marks").setup({
    -- whether to map keybinds or not. default true
    default_mappings = true,

    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,

    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,

    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,

    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },

    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = { "NvimTree", "aerial" },

    mappings = {},

    -- Which builtin marks to show. default {}
    --
    -- Don't include z/Z as a mark because it is used
    -- in some plugins and it's fucking annoying
    builtin_marks = {
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
    },
  })
end

return M

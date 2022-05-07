-- Module: 0x2a.plugins.lualine.themes.eighties
-- Description: The eighties theme for lualine.nvim
-- Genarated by lightline to lualine theme converter
--   https://gist.github.com/shadmansaleh/000871c9a608a012721c6acc6d7a19b9

local colors = {
  color0 = "#2d2d2d",
  color1 = "#393939",
  color2 = "#515151",
  color3 = "#747369",
  color4 = "#a09f93",
  color5 = "#d3d0c8",
  color6 = "#e8e6df",
  color7 = "#f2f0ec",
  color8 = "#f2777a",
  color9 = "#f99157",
  color10 = "#ffcc66",
  color11 = "#99cc99",
  color12 = "#66cccc",
  color13 = "#6699cc",
  color14 = "#cc99cc",
  color15 = "#d27b53",
}

local eighties = {
  normal = {
    a = { fg = colors.color1, bg = colors.color13 },
    b = { fg = colors.color0, bg = colors.color14 },
    c = { fg = colors.color7, bg = colors.color2 },
    x = { fg = colors.color7, bg = colors.color1 },
    y = { fg = colors.color6, bg = colors.color2 },
    z = { fg = colors.color1, bg = colors.color4 },
  },
  inactive = {
    a = { fg = colors.color4, bg = colors.color1 },
    b = { fg = colors.color7, bg = colors.color3 },
  },
  command = {
    a = { fg = colors.color9, bg = colors.color1 },
    b = { fg = colors.color7, bg = colors.color2 },
    c = { fg = colors.color7, bg = colors.color2 },
    x = { fg = colors.color7, bg = colors.color1 },
    y = { fg = colors.color6, bg = colors.color2 },
    z = { fg = colors.color1, bg = colors.color4 },
  },
  terminal = {
    a = { fg = colors.color11, bg = colors.color1 },
    b = { fg = colors.color7, bg = colors.color2 },
    c = { fg = colors.color7, bg = colors.color2 },
    x = { fg = colors.color7, bg = colors.color1 },
    y = { fg = colors.color6, bg = colors.color2 },
    z = { fg = colors.color1, bg = colors.color4 },
  },
  replace = {
    a = { fg = colors.color1, bg = colors.color8 },
    b = { fg = colors.color7, bg = colors.color2 },
    c = { fg = colors.color7, bg = colors.color2 },
    x = { fg = colors.color7, bg = colors.color1 },
    y = { fg = colors.color6, bg = colors.color2 },
    z = { fg = colors.color1, bg = colors.color4 },
  },
  visual = {
    a = { fg = colors.color1, bg = colors.color14 },
    b = { fg = colors.color7, bg = colors.color2 },
    c = { fg = colors.color7, bg = colors.color2 },
    x = { fg = colors.color7, bg = colors.color1 },
    y = { fg = colors.color6, bg = colors.color2 },
    z = { fg = colors.color1, bg = colors.color4 },
  },
  insert = {
    a = { fg = colors.color1, bg = colors.color11 },
    b = { fg = colors.color7, bg = colors.color2 },
    c = { fg = colors.color7, bg = colors.color2 },
    x = { fg = colors.color7, bg = colors.color1 },
    y = { fg = colors.color6, bg = colors.color2 },
    z = { fg = colors.color1, bg = colors.color4 },
  },
}

return eighties

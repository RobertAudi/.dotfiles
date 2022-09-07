-- Module: 0x2a.theme.utils

local utils = require("0x2a.utils")

local M = {}

-- Source: https://github.com/euclidianAce/dotfiles/blob/6aa5a71cae2e7e8c97fa2d1d2c06fd5e0de7bd9b/nvim/lua/euclidian/lib/color.lua#L81-L83
M.hex_to_rgb = function(hex)
  vim.validate({
    hex = { hex, { "string", "number" } },
  })

	if type(hex) == "string" then
		if string.sub(hex, 1, 1) == "#" then
			hex = string.sub(hex, 2, -1)
		end

		hex = tonumber(hex, 16)
	end

  return bit.rshift(hex, 16), bit.band((bit.rshift(hex, 8)), 0xff), bit.band(hex, 0xff)
end

-- Source: https://github.com/euclidianAce/dotfiles/blob/6aa5a71cae2e7e8c97fa2d1d2c06fd5e0de7bd9b/nvim/lua/euclidian/lib/color.lua#L85-L87
M.rgb_to_hex = function(r, g, b)
  vim.validate({
    r = { r, "number" },
    g = { g, "number" },
    b = { b, "number" },
  })

  return bit.bor(bit.bor((bit.lshift(r, 16)), (bit.lshift(g, 8))), b)
end

-- Source: https://github.com/euclidianAce/dotfiles/blob/6aa5a71cae2e7e8c97fa2d1d2c06fd5e0de7bd9b/nvim/lua/euclidian/lib/color.lua#L89,112
M.rgb_to_hsv = function(r, g, b)
  vim.validate({
    r = { r, "number" },
    g = { g, "number" },
    b = { b, "number" },
  })

  local rs = r / 255
  local gs = g / 255
  local bs = b / 255
  local mmax = math.max(rs, gs, bs)
  local mmin = math.min(rs, gs, bs)
  local delta = mmax - mmin

  local h

  if delta > 0 then
    if mmax == rs then
      h = (gs - bs) / delta
    elseif mmax == gs then
      h = (bs - rs) / delta + 2
    elseif mmax == bs then
      h = (rs - gs) / delta + 4
    end
  end

  local v = mmax
  local s = v == 0 and 0 or delta / v

  return h, s, v
end

-- Source: https://github.com/euclidianAce/dotfiles/blob/6aa5a71cae2e7e8c97fa2d1d2c06fd5e0de7bd9b/nvim/lua/euclidian/lib/color.lua#L117,145
M.hsv_to_rgb = function(h, s, v)
  vim.validate({
    h = { h, "number" },
    s = { s, "number" },
    v = { v, "number" },
  })

  local alpha = v * (1 - s)
  local beta = h and v * (1 - (h - math.floor(h)) * s)
  local gamma = h and v * (1 - (1 - (h - math.floor(h))) * s)

  if not h then
    return v, v, v
  end

  h = h % 6

  assert(alpha)
  assert(beta)
  assert(gamma)

  if h < 1 then
    return v, gamma, alpha
  elseif h < 2 then
    return beta, v, alpha
  elseif h < 3 then
    return alpha, v, gamma
  elseif h < 4 then
    return alpha, beta, v
  elseif h < 5 then
    return gamma, alpha, v
  elseif h < 6 then
    return v, alpha, beta
  end

  error("bad h value: h=" .. tostring(h))
end

-- Source: https://github.com/RRethy/nvim-base16/blob/da2a27cbda9b086c201b36778e7cdfd00966627a/lua/base16-colorscheme.lua#L45-L52
M.darken = function(hex, pct)
  pct = 1 - pct

  local r, g, b = M.hex_to_rgb(string.sub(hex, 2))

  r = math.floor(r * pct)
  g = math.floor(g * pct)
  b = math.floor(b * pct)

  return string.format("#%s", M.rgb_to_hex(r, g, b))
end

M.lighten = function(hex, pct)
  pct = 1 - pct

  local r, g, b = M.hex_to_rgb(string.sub(hex, 2))

  r = math.floor(r / pct)
  g = math.floor(g / pct)
  b = math.floor(b / pct)

  return string.format("#%s", M.rgb_to_hex(r, g, b))
end

M.highlight = function(group, definitions)
  vim.validate({
    group = { group, "string" },
    definitions = { definitions, "table" },
  })

  vim.api.nvim_set_hl(0, group, definitions)
end

M.get_highlight = function(group, opts)
  vim.validate({
    group = { group, "string" },
    opts = { opts, { "table", "nil" } },
  })

  opts = utils.normalize_options(opts)

  local theme_name = utils.if_blank(opts.theme, M.current_colorscheme(), opts.theme)
  local theme = require("0x2a.colors.themes." .. theme_name)

  return theme.colors[group]
end

M.restore_highlight = function(group, opts)
  vim.validate({
    group = { group, "string" },
    opts = { opts, { "table", "nil" } },
  })

  opts = utils.normalize_options(opts)

  local theme_name = utils.if_blank(opts.theme, M.current_colorscheme(), opts.theme)
  local theme = require("0x2a.colors.themes." .. theme_name)

  M.highlight(group, theme.colors[group])
end

M.current_colorscheme = function()
  return vim.g.colors_name or vim.g.default_colorscheme or "default"
end

M.use = function(name)
  vim.validate({ name = { name, "string" } })

  if vim.fn.exists("syntax_on") then
    vim.cmd.syntax("reset")
  end

  if vim.g.colors_name then
    vim.cmd.highlight("clear")
  end

  local theme = require("0x2a.colors.themes." .. name)

  for option, value in pairs(theme.options) do
    vim.o[option] = value
  end

  vim.g.fzf_colors = theme.fzf

  for key, color in pairs(theme.terminal) do
    vim.g["terminal_" .. key] = color
  end

  for group, definitions in pairs(theme.colors) do
    M.highlight(group, definitions)
  end

  vim.g.colors_name = name
end

return M

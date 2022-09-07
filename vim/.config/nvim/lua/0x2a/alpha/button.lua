-- Module: 0x2a.alpha.button

local M = {}

M.build = function(key, title, keybind, keybind_opts)
  local opts = {
    position = "center",
    shortcut = key,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "Keyword",
  }

  -- keybind_opts = keybind_opts or { noremap = true, silent = true, nowait = true }
  keybind_opts = vim.tbl_extend("force", { noremap = true, silent = true, nowait = true }, keybind_opts or {})
  opts.keymap = { "n", key, keybind, keybind_opts }

  return {
    type = "button",
    val = title,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(key .. "<Ignore>", true, false, true)
      vim.api.nvim_feedkeys(key, "t", false)
    end,

    opts = opts,
  }
end

setmetatable(M, {
  __call = function(tbl, ...)
    return tbl.build(...)
  end
})

return M

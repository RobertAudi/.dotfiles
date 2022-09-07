-- Module: 0x2a.plugins.hydra.pickers

local M = {}

M.builtin = function(name, opts)
  vim.validate({
    name = { name, { "string", "nil" } },
    opts = { opts, { "table", "nil" } },
  })

  return function()
    if require("0x2a.utils").is_blank(name) then
      name = "builtin"
    end

    require("telescope.builtin")[name](opts or {})
  end
end

M.sandbox = function()
  local fsutils = require("0x2a.utils.fs")

  if fsutils.in_dotfiles_directory() then
    return M.builtin("find_files", { cwd = fsutils.dotfiles_directory("sandbox") })
  else
    return M.builtin("find_files")
  end
end

M.urlview = function()
  return function()
    require("telescope").extensions.urlview.urlview({})
  end
end

M.conflicts = function()
  return function()
    require("telescope").extensions.conflicts.conflicts({})
  end
end

return M

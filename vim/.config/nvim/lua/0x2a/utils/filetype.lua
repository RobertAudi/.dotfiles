-- Module: 0x2a.utils.filetype

local M = {}

M.set = function(filetype, force)
  vim.validate({
    filetype = { filetype, "string" },
    force = { force, "boolean" }
  })

  if force then
    vim.opt_local.filetype = filetype
  else
    vim.cmd.setfiletype(filetype)
  end
end

-- Source: https://github.com/kballard/.vim/blob/8ad9711b7c4781bead66f25b942ca1d8997efa48/vimrc#L1984-L1990
M.reload = function()
  local old_filetype = vim.bo.filetype

  M.set("none", false)

  vim.cmd.syntax("clear")

  M.set(old_filetype, true)
end

return M

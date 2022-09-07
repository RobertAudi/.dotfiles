-- Module: 0x2a.utils.plugins
-- Requires:
--   - wbthomason/packer.nvim
--   - 0x2a.utils

local M = {}

M.is_installed = function(plugin)
  vim.validate({ plugin = { plugin, "string" } })

  return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

M.is_available = function(plugin)
  return M.is_installed(plugin) and packer_plugins[plugin].loaded
end

-- load plugin after entering vim ui
-- Source: https://github.com/NvChad/NvChad/blob/f9f03e7eaf095607f90ec4df96f786acc8427edc/lua/core/utils.lua#L99,107
M.packer_lazy_load = function(plugin, timer)
  if require("0x2a.utils").is_blank(plugin) then
    vim.notify("Argument required: plugin", vim.log.levels.ERROR)
  else
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

M.luapad = {
  is_active = function()
    local luapad_state = prequire("luapad.state")

    return luapad_state and luapad_state.current()
  end
}

return M

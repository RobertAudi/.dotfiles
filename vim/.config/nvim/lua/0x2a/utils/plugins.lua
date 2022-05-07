-- Module: 0x2a.utils.plugins

local M = {}

M.is_available = function(plugin)
  return packer_plugins ~= nil and packer_plugins[plugin] ~= nil and packer_plugins[plugin].loaded
end

return M

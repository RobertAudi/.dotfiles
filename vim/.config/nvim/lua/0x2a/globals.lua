-- Global functions and variables

-- Source: https://github.com/creativenull/nvim-config/blob/7f2aa3a6dcd431f7e8d19f2008ecfd794c2822bb/lua/cnull/core/lib/prequire.lua#L1,12
--- Protected require, just like pcall but for require()
_G.prequire = function(modname, verbose)
  local success, mod_or_err = pcall(require, modname)

  if success then
    return mod_or_err
  end

  vim.notify("Failed to require module: " .. modname, vim.log.levels.ERROR, { title = "An error occurred." })

  if verbose then
    vim.api.nvim_echo({ { mod_or_err, "WarningMsg" } }, true, {})
  end

  return false
end

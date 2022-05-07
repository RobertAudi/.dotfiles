--- automatically clear commandline messages after a few seconds delay
--- source: http://unix.stackexchange.com/a/613645
--  source: https://github.com/akinsho/dotfiles/blob/0f796af4cda8e9b1fde890dd33d0ed359fcdf43e/.config/nvim/plugin/autocommands.lua#L141,159
---@return function
local function clear_commandline()
  --- Track the timer object and stop any previous timers before setting
  --- a new one so that each change waits for 10secs and that 10secs is
  --- deferred each time
  local timer

  return function()
    if timer then
      timer:stop()
    end

    timer = vim.defer_fn(function()
      if vim.fn.mode() == "n" then
        vim.cmd("echon ''")
      end
    end, 10000)
  end
end

vim.api.nvim_create_autocmd({ "CmdlineLeave", "CmdlineChanged" }, {
  group = vim.api.nvim_create_augroup("ClearCommandMessages", { clear = true }),
  pattern = { ":" },
  callback = clear_commandline(),
})

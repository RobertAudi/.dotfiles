-- Module: 0x2a.git
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.files
--   - 0x2a.notifications
--   - nvim-lua/plenary.nvim

local utils = require("0x2a.utils")
local futils = require("0x2a.utils.files")
local notifications = require("0x2a.notifications")
local Job = require("plenary.job")

local M = {}

M.link = function(opts)
  if vim.api.nvim_buf_get_option(0, "buftype") ~= "" then
    notifications.warning("Buffer is not a file")
    return ""
  end

  if not futils.is_executable("git-permalink") then
    notifications.error("Command not found: git-permalink")
    return ""
  end

  local cmd = "git-permalink"

  opts = opts or {}

  if opts.verbose == nil then
    opts.verbose = true
  end

  if opts.permalink == true then
    cmd = cmd .. " --raw"
  end

  cmd = cmd .. " " .. vim.api.nvim_exec("echo shellescape(expand('%'))", true)
  cmd = string.gsub(cmd, "'", "")

  local line1 = tonumber(opts.line1) or 0
  local line2 = tonumber(opts.line2) or 0
  local range = tonumber(opts.range) or 0

  if line1 == line2 then
    if range == 0 then
      line1 = 0
    end

    line2 = 0
  end

  if line1 > 0 then
    cmd = cmd .. " " .. line1

    if line2 > 0 then
      cmd = cmd .. "," .. line2
    end
  end

  local result = vim.api.nvim_exec("echo substitute(system('" .. cmd .. "'), '\\v\\n$', '', '')", true)

  if vim.api.nvim_get_vvar("shell_error") then
    if opts.verbose then
      notifications.info(result, { title = "Git link" })
    end

    return result
  else
    notifications.error(result)
    return ""
  end
end

M.browse = function(opts)
  opts = utils.normalize_options(opts)

  if opts.verbose == nil then
    opts.verbose = false
  end

  local file_link = M.link(opts)

  if file_link == "" then
    return
  end

  local browser = os.getenv("BROWSER")

  if utils.is_empty(browser) then
    if futils.is_executable("launch") then
      browser = "launch"
    elseif futils.is_executable("open") then
      browser = "open"
    else
      notifications.warning("Unable to resolve web browser or URL handler")
      return
    end
  end

  if not futils.is_executable(browser) then
    notifications.warning("Web browser or URL handler not executable: " .. browser)
    return
  end

  local args = {}

  if opts.background then
    if browser == "launch" then
      table.insert(args, "-b")
    elseif browser == "open" then
      table.insert(args, "-g")
    else
      opts.background = false
    end
  end

  table.insert(args, file_link)

  Job
    :new({
      command = browser,
      args = args,
      on_exit = function(_, return_val)
        if return_val == 0 then
          if opts.background then
            notifications.info(file_link, { title = "File opened in the browser" })
          end
        else
          notifications.error("Unable to open file in the browser")
        end
      end,
    })
    :sync()
end

M.copy_link = function(opts)
  opts = utils.normalize_options(opts)

  if opts.verbose == nil then
    opts.verbose = false
  end

  local file_link = M.link(opts)

  if file_link == "" then
    return
  end

  utils.copy_to_clipboard(file_link, {
    success = function()
      local link_type = "link"

      if opts.permalink then
        link_type = "permalink"
      end

      local message = "Git file " .. link_type .. " copied to the system clipboard"
      message = message .. "\n\n  " .. file_link .. "\n"

      notifications.success(message, { title = "Git link copied" })
    end,

    failure = function()
      notifications.error("Failed to copy git link")
    end,
  })
end

return M

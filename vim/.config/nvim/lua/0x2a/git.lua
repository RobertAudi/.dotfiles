-- Module: 0x2a.git
-- Requires:
--   - git
--   - git-permalink
--   - git-repo-url
--   - 0x2a.utils
--   - 0x2a.utils.fs
--   - 0x2a.notifications
--   - nvim-lua/plenary.nvim

local utils = require("0x2a.utils")
local fsutils = require("0x2a.utils.fs")
local notifications = require("0x2a.notifications")
local Job = require("plenary.job")

local M = {}

M.repo_url = function()
  if not fsutils.is_executable("git-repo-url") then
    notifications.error("Command not found: git-repo-url")
    return ""
  end

  local result = vim.api.nvim_exec("echo substitute(system('git-repo-url'), '\\v\\n$', '', '')", true)

  if vim.api.nvim_get_vvar("shell_error") == 0 then
    return result
  else
    vim.api.nvim_err_writeln(result)
    vim.v.errmsg = result

    return ""
  end
end

M.link = function(opts)
  if vim.api.nvim_buf_get_option(0, "buftype") ~= "" then
    notifications.warning("Buffer is not a file")
    return ""
  end

  if not fsutils.is_executable("git-permalink") then
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

  if vim.api.nvim_get_vvar("shell_error") == 0 then
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

  utils.browse(file_link, opts)
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

      notifications.success(message, { title = "Git link copied", echo = "Git link copied: " .. file_link })
    end,

    failure = function()
      notifications.error("Failed to copy git link")
    end,
  })
end

M.conflicts = function()
  local job = Job:new({ command = "git", args = { "diff", "--name-only", "--diff-filter=U", "--relative" } })
  job:sync()

  local result = nil

  if job.code == 0 then
    result = require("0x2a.utils.string").trim_lines(table.concat(job:result(), "\n"))
  else
    vim.defer_fn(function()
      result = job:result()

      if utils.is_blank(result) then
        result = job:stderr_result()
      end

      if utils.is_present(result) then
        return utils.fatal(table.concat(result, "\n"))
      end
    end, 100)
  end

  local files = {}

  for token in string.gmatch(result, "[^%s]+") do
    table.insert(files, token)
  end

  return files
end

return M

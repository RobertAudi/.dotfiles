-- Module: 0x2a.alpha.dashboards.ghq
-- Requires:
--   - 0x2a.git
--   - 0x2a.utils.string
--   - 0x2a.utils.fs
--   - 0x2a.utils.headers
--   - 0x2a.alpha.buttons
--   - 0x2a.alpha.dashboard

local fsutils = require("0x2a.utils.fs")
local string_utils = require("0x2a.utils.string")
local headers = require("0x2a.utils.headers")
local buttons = require("0x2a.alpha.buttons")

if not fsutils.in_ghq_directory({ strict = true }) then
  return require("0x2a.alpha.dashboard").build()
end

local ghq_directory = fsutils.ghq_directory()
local user, repo = unpack(string_utils.split(ghq_directory, "/"))
local header = "    by " .. user

if #repo <= 8 then
  header = headers.h2(repo) .. "\n" .. header
elseif #repo <= 25 then
  header = headers.h3(repo) .. "\n\n" .. header
elseif #repo <= 40 then
  header = headers.h4(repo) .. "\n\n" .. header
end

return require("0x2a.alpha.dashboard").build({
  header = string_utils.split(header, "\n"),
  buttons = {
    buttons.find_file,
    buttons.file_tree,
    buttons.browse,
    buttons.quit,
  },
  footer = require("0x2a.git").repo_url(),
})

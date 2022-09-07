-- Plugin: 0x2a.utils.project
-- Source: https://github.com/ahmedkhalf/project.nvim
--         https://github.com/ahmedkhalf/project.nvim/blob/541115e762764bc44d7d3bf501b6e367842d3d4f/lua/project_nvim/project.lua
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.globtopattern
--   - nvim-lua/plenary.nvim

local glob = require("0x2a.utils.globtopattern")
local Path = require("plenary.path")

local M = {}

M.find_lsp_root = function()
  -- Get lsp client for current buffer
  -- Returns nil or string
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.buf_get_clients()

  if next(clients) == nil then
    return nil
  end

  for _, client in pairs(clients) do
    local filetypes = client.config.filetypes

    if filetypes and vim.tbl_contains(filetypes, buf_ft) then
      return client.config.root_dir
    end
  end

  return nil
end

M.find_pattern_root = function()
  local patterns = { ".git", "Gemfile", "Makefile", "package.json" }
  local search_dir = vim.fn.expand("%:p:h", true)
  local last_dir_cache = ""
  local curr_dir_cache = {}

  local function get_files(file_dir)
    last_dir_cache = file_dir
    curr_dir_cache = {}

    local dir = vim.loop.fs_scandir(file_dir)
    if dir == nil then
      return
    end

    while true do
      local file = vim.loop.fs_scandir_next(dir)
      if file == nil then
        return
      end

      table.insert(curr_dir_cache, file)
    end
  end

  local function is(dir, identifier)
    return dir:match(".*/(.*)") == identifier
  end

  local function sub(dir, identifier)
    local path = Path:new(dir):parent()

    while true do
      if is(path, identifier) then
        return true
      end

      local current = path

      path = Path:new(path):parent()

      if current == path then
        return false
      end
    end
  end

  local function has(dir, identifier)
    if last_dir_cache ~= dir then
      get_files(dir)
    end

    local pattern = glob.globtopattern(identifier)

    for _, file in ipairs(curr_dir_cache) do
      if file:match(pattern) ~= nil then
        return true
      end
    end

    return false
  end

  local function match(dir, pattern)
    local first_char = pattern:sub(1, 1)
    if first_char == "=" then
      return is(dir, pattern:sub(2))
    elseif first_char == "^" then
      return sub(dir, pattern:sub(2))
    elseif first_char == ">" then
      return is(Path:new(dir):parent(), pattern:sub(2))
    else
      return has(dir, pattern)
    end
  end

  -- breadth-first search
  while true do
    for _, pattern in ipairs(patterns) do
      local exclude = false
      if pattern:sub(1, 1) == "!" then
        exclude = true
        pattern = pattern:sub(2)
      end

      if match(search_dir, pattern) then
        if exclude then
          break
        else
          return search_dir
        end
      end
    end

    local parent = Path:new(search_dir):parent()

    if parent == search_dir or parent == nil then
      return nil
    end

    search_dir = parent:absolute()
  end
end

M.get_project_root = function()
  return require("0x2a.utils").presence(M.find_lsp_root()) or M.find_pattern_root()
end

return M

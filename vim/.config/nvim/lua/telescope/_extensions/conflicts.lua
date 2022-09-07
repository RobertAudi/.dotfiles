-- Description: Git conflicts Telescope extension
-- Requires:
--   - 0x2a.git
--   - nvim-telescope/telescope.nvim

local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  error("This plugin requires nvim-telescope/telescope.nvim")
end

M = {}

M.pick = function(opts)
  opts = vim.F.if_nil(opts, {}, opts)

  local files = require("0x2a.git").conflicts()

  require("telescope.pickers").new(opts, {
    prompt_title = "Git conflicts",
    finder = require("telescope.finders").new_table({ results = files }),
    previewer = require("telescope.previewers").git_file_diff.new({}),
    sorter = require("telescope.config").values.generic_sorter(opts),
  }):find()
end

return telescope.register_extension({
  exports = {
    conflicts = M.pick,
  },
})

-- Module: TODO: Add module name
-- Description: TODO: Add description
-- Requires:
--   - nvim-telescope/telescope.nvim

local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local list = function(opts)
  opts = opts or {}

  local results = {}

  pickers.new(opts, {
    prompt_title = "TODO: Add title",
    finder = finders.new_table({
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1],
          ordinal = entry[1],
        }
      end,
    }),

    sorter = conf.generic_sorter(opts),

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)

        local selection = action_state.get_selected_entry()

        -- print(vim.inspect(selection))

        vim.api.nvim_put({ selection[1] }, "", false, true)
      end)

      return true
    end,
  }):find()
end

return require("telescope").register_extension({
  exports = {
    list = list,
  },
})

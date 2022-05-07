-- Module: 0x2a.plugins.telescope.picker.yanky
-- Description: This is the default yanky extension except that
--              the selection is copied to the system clipboard
--              instead of being inserted in the buffer.
-- Requires:
--   - gbprod/yanky.nvim

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

M.get_exports = function()
  return { yanky = M.yank_history }
end

M.previewer = function()
  return require("telescope.previewers").new_buffer_previewer({
    dyn_title = function(_, entry)
      if "v" == entry.value.regtype then
        return "charwise"
      end

      if "V" == entry.value.regtype then
        return "linewise"
      end

      return "blockwise"
    end,

    define_preview = function(self, entry)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, true, vim.split(entry.value.regcontents, "\n"))

      if entry.value.filetype ~= nil then
        vim.bo[self.state.bufnr].filetype = entry.value.filetype
      end
    end,
  })
end

M.attach_mappings = function(_, map)
  actions.select_default:replace(function(prompt_bufnr)
    actions.close(prompt_bufnr)
    require("0x2a.utils").copy_to_clipboard(action_state.get_selected_entry().content)
  end)

  return true
end

M.gen_from_history = function(opts)
  local displayer = require("telescope.pickers.entry_display").create({
    separator = " ",

    items = {
      { width = #tostring(opts.history_length) },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    local content = entry.content

    return displayer({
      { entry.value.history_index, "TelescopeResultsNumber" },
      content:gsub("\n", "\\n"),
    })
  end

  return function(entry)
    return {
      valid = true,
      value = entry,
      ordinal = entry.regcontents,
      content = entry.regcontents,
      display = make_display,
    }
  end
end

M.yank_history = function(opts)
  local history = {}

  for index, value in pairs(require("yanky.history").all()) do
    -- Ignore blank values
    if require("0x2a.utils").is_present(value.regcontents) then
      value.history_index = index
      history[index] = value
    end
  end

  opts.history_length = #history
  opts.layout_strategy = "horizontal"
  opts.layout_config = {
    prompt_position = "top",
    horizontal = { preview_width = 80 },
  }

  require("telescope.pickers").new(opts, {
    prompt_title = "Yank history",

    finder = require("telescope.finders").new_table({
      results = history,
      entry_maker = M.gen_from_history(opts),
    }),

    attach_mappings = M.attach_mappings,
    previewer = M.previewer(),
    sorter = require("telescope.config").values.generic_sorter(opts),
  }):find()
end

return M

-- Plugin: telescope.nvim
-- Description: Find, Filter, Preview, Pick. All lua, all the time.
-- URL: https://github.com/nvim-telescope/telescope.nvim

require('telescope').setup {
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
    sorting_strategy = 'ascending',
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = 'top',
      height = 0.5,
      width = 0.75,
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_width = 0
      }
    }
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
}

require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<C-p>', '<Cmd>Telescope find_files find_command=rg,--hidden,--files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-b>', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })

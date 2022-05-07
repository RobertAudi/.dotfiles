-- Plugin: vim-utils/vim-interruptless
-- Description: Makes vim interrupt you less
-- Author: Bruno Sutic
-- License: MIT license
-- URL: https://github.com/vim-utils/vim-interruptless

vim.api.nvim_create_autocmd("FileChangedShell", {
  group = vim.api.nvim_create_augroup("RAPluginsInterruptless", { clear = true }),
  pattern = "*",
  callback = function()
    vim.v.fcs_choice = "just do nothing"

    local filename = vim.fn.expand("<afile>", false, false)

    if vim.v.fcs_reason == "conflict" then
      require("0x2a.notifications").warning(
        [[Warning: File "]] .. filename .. [[" has changed and the buffer was changed in Vim as well]]
      )
    end
  end,
})

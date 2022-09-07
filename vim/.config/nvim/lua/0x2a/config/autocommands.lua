-- Module: 0x2a.config.autocommands
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.fs

local utils = require("0x2a.utils")

local augroup = vim.api.nvim_create_augroup("RANVimAutocommands", { clear = true })

-- Update the 'scrolloff' according to the height of the window
-- Source: https://github.com/uplus/vimrc/blob/80b6dc96d08bf00ed59e545448ea031aee194230/autocmds.vim#L8
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "VimResized" }, {
  desc = "Update the 'scrolloff' according to the height of the window",
  group = augroup,
  command = "let &scrolloff = float2nr(winheight('') * 0.1)"
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.signcolumn = "no"
    vim.opt_local.buflisted = false
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "TermOpen" }, {
  group = augroup,
  pattern = { "term://*", "shell" },
  command = "startinsert",
})

vim.api.nvim_create_autocmd("TermEnter", { group = augroup, command = "startinsert" })
vim.api.nvim_create_autocmd("TermLeave", { group = augroup, command = "stopinsert" })

-- More eager than 'autoread'.
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, { group = augroup, command = "silent! checktime" })

-- Update diff.
vim.api.nvim_create_autocmd("InsertLeave", { group = augroup, command = "if &l:diff | diffupdate | endif" })

-- Don't track changes, keep .viminfo information or swap files for files in
-- temporary directories. This is because they're used as scratch spaces for
-- tools like sudoedit(8) and pass(1) and hence could present a security problem
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  group = augroup,
  pattern = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*",
  callback = function()
    vim.opt_local.shada = {}
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*",
  callback = function()
    vim.opt_local.undofile = false
  end,
})

if utils.is_empty(os.getenv("SUDO_USER")) or os.getenv("USER") ~= os.getenv("SUDO_USER") then
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
    group = augroup,
    pattern = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*",
    callback = function()
      vim.opt_local.swapfile = false
    end,
  })
end

-- Don't show whitespace in readonly and nomodifiable buffers
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Don't show whitespace in readonly and nomodifiable buffers",
  group = augroup,
  callback = function()
    if vim.bo.readonly or not vim.bo.modifiable then
      vim.wo.list = false
    end
  end,
})

-- Open new tabs at the end
vim.api.nvim_create_autocmd("TabNew", {
  desc = "Open new tabs at the end",
  group = augroup,
  command = "tabmove",
})

-- Set timeoutlen to 0 for help and man buffers only
-- The conditionnal is required because timeoutlen is
-- a global option (can't be set locally)
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  callback = function()
    if vim.bo.filetype == "help" or vim.bo.filetype == "man" or vim.bo.filetype == "bufferize" then
      vim.o.timeoutlen = 0
    else
      vim.o.timeoutlen = vim.g.default_timeoutlen or 1000
    end
  end,
})

-- Back to normal mode when Vim loses focus
vim.api.nvim_create_autocmd({ "FocusLost", "TabLeave" }, {
  desc = "Leave insert mode when Vim loses focus",
  group = augroup,
  callback = function()
    local mode = vim.fn.mode()

    if mode ~= "c" and mode ~= "t" then
      vim.cmd.stopinsert()
    end
  end,
})

-- Make scripts executable on save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup,
  callback = function()
    require("0x2a.utils.fs").make_executable()
  end,
})

-- Highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup,
  callback = function()
    vim.highlight.on_yank({
      higroup = vim.fn.hlexists("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "IncSearch",
    })
  end,
})

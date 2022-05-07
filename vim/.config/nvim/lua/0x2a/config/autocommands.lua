local utils = require("0x2a.utils")

local augroup = vim.api.nvim_create_augroup("RANVimAutocommands", { clear = true })

-- Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
vim.api.nvim_create_autocmd({ "VimEnter", "GUIEnter" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd("set visualbell t_vb=")
  end,
})

-- Set "TODO" & "FIXME" strings to be bold and standout as hell.
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd("highlight Todo cterm=NONE ctermfg=196 ctermbg=226 gui=NONE guifg=#ff4500 guibg=#eeee00")
  end,
})

-- Update the 'scrolloff' according to the height of the window
-- Source: https://github.com/uplus/vimrc/blob/80b6dc96d08bf00ed59e545448ea031aee194230/autocmds.vim#L8
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "VimResized" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd("let &scrolloff = float2nr(winheight('') * 0.1)")
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.wo.signcolumn = "no"
    vim.bo.buflisted = false
    vim.wo.spell = false
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.api.nvim_command("startinsert")
  end,
})

vim.api.nvim_create_autocmd("TermLeave", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.api.nvim_command("stopinsert")
  end,
})

-- More eager than 'autoread'.
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd("silent! checktime")
  end,
})

-- Update diff.
vim.api.nvim_create_autocmd("InsertLeave", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd("if &l:diff | diffupdate | endif")
  end,
})

-- Don't track changes, keep .viminfo information or swap files for files in
-- temporary directories. This is because they're used as scratch spaces for
-- tools like sudoedit(8) and pass(1) and hence could present a security problem
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  group = augroup,
  pattern = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*",
  callback = function()
    vim.cmd("setlocal viminfo=")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*",
  callback = function()
    vim.cmd("setlocal noundofile")
  end,
})

if utils.is_empty(os.getenv("SUDO_USER")) or os.getenv("USER") ~= os.getenv("SUDO_USER") then
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
    group = augroup,
    pattern = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*",
    callback = function()
      vim.cmd("setlocal noswapfile")
    end,
  })
end

-- Don't show whitespace in readonly and nomodifiable buffers
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.bo.readonly or not vim.bo.modifiable then
      vim.wo.list = false
    end
  end,
})

-- Open new tabs at the end
vim.api.nvim_create_autocmd("TabNew", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.api.nvim_command("tabmove")
  end,
})

-- Set timeoutlen to 0 for help and man buffers only
-- The conditionnal is required because timeoutlen is
-- a global option (can't be set locally)
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "help" or vim.bo.filetype == "man" or vim.bo.filetype == "bufferize" then
      vim.fn["x2a#vim#remove_timeout"]()
    else
      vim.fn["x2a#vim#restore_timeout"]()
    end
  end,
})

-- Back to normal mode when Vim loses focus
vim.api.nvim_create_autocmd({ "FocusLost", "TabLeave" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    local mode = vim.fn.mode()

    if mode ~= "c" and mode ~= "t" then
      vim.api.nvim_command("stopinsert")
    end
  end,
})

-- Make scripts executable on save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup,
  pattern = "*",
  callback = function()
    require("0x2a.utils.files").make_executable()
  end,
})

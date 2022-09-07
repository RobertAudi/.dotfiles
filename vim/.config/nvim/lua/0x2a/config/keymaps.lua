-- Module: 0x2a.config.keymaps
-- Requires:
--   - 0x2a.utils.buffer

vim.g.mapleader = ","

-- Disabled keys {{{
-- ------------------------------------------------------------------------------

-- No Help, please
vim.keymap.set({ "i", "n", "v" }, "<F1>", "<Esc>", { noremap = true })

-- Disable arrow keys
vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>", { noremap = true, desc = "Disabled" })

-- Remap U to nothing, I hate U!
vim.keymap.set("n", "U", "<Nop>", { noremap = true, desc = "Disabled" })

-- Disable ZZ and ZQ.
vim.keymap.set("n", "ZZ", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set("n", "ZQ", "<Nop>", { noremap = true, desc = "Disabled" })

-- ------------------------------------------------------------------------------ }}}

-- Improvements and overrides {{{
-- ------------------------------------------------------------------------------

-- Don't store changed text
vim.keymap.set({ "n", "x" }, "c", [["_c]], { noremap = true })
vim.keymap.set({ "n", "x" }, "C", [["_C]], { noremap = true })

-- Use the black hole register if deleting a blank line
--
-- Source: https://www.reddit.com/r/neovim/comments/w0jzzv/smart_dd/igfjx5y/
vim.keymap.set({ "n" }, "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end, { noremap = true, expr = true, silent = true })

-- Get more information from ctrl-g:
vim.keymap.set("n", "<C-g>", "2<C-g>", { noremap = true, desc = "Get more information from ctrl-g" })

-- Alternate buffer
vim.keymap.set("n", "g<C-b>", "<C-^>", { noremap = true, desc = "Alternate buffer" })

-- Universal opposite of J
vim.keymap.set(
  "n",
  "S",
  "<Cmd>call x2a#breakhere#BreakHere()<CR>",
  { noremap = true, silent = true, desc = "Universal opposite of J" }
)

-- Use aesthetic middle of screen for "zz"
vim.keymap.set(
  "n",
  "zz",
  "<Cmd>call x2a#movements#window#CenterCursorAesthetically()<CR>",
  { noremap = true, silent = true, desc = [[Use aesthetic middle of screen for "zz"]] }
)

-- Stay in the center!!
vim.keymap.set(
  "n",
  "<C-d>",
  "<C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<C-u>",
  "<C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>",
  { noremap = true, silent = true }
)

-- Do not exit visual mode when shifting
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })

-- ------------------------------------------------------------------------------ }}}

-- Movements {{{
-- ------------------------------------------------------------------------------

-- Movement through splits in normal and visual mode (but not in select mode)
vim.keymap.set({ "n", "x" }, "<C-h>", "<C-w>h", { noremap = true, desc = "Move to the split on the left" })
vim.keymap.set({ "n", "x" }, "<C-j>", "<C-w>j", { noremap = true, desc = "Move to the split below" })
vim.keymap.set({ "n", "x" }, "<C-k>", "<C-w>k", { noremap = true, desc = "Move to the split above" })
vim.keymap.set({ "n", "x" }, "<C-l>", "<C-w>l", { noremap = true, desc = "Move to the split on the right" })

-- Linewise movement should work on screen lines
vim.keymap.set({ "n", "v" }, "$", "x2a#movements#line#Dollar()", { noremap = true, expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "g$", "x2a#movements#line#gDollar()", { noremap = true, expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "0", "x2a#movements#line#Zero()", { noremap = true, expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "g0", "x2a#movements#line#gZero()", { noremap = true, expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "^", "x2a#movements#line#Caret()", { noremap = true, expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "g^", "x2a#movements#line#gCaret()", { noremap = true, expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "k", "x2a#movements#line#Up()", { noremap = true, expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "gk", "x2a#movements#line#gUp()", { noremap = true, expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "j", "x2a#movements#line#Down()", { noremap = true, expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "gj", "x2a#movements#line#gDown()", { noremap = true, expr = true, silent = true })

-- Remap H and L to beggining and end of
-- the line (Smart Home/End)
vim.keymap.set(
  { "n", "v" },
  "H",
  "x2a#movements#line#Home()",
  { noremap = true, expr = true, desc = "Move to the start of the line" }
)

vim.keymap.set(
  { "n", "v" },
  "L",
  "x2a#movements#line#End()",
  { noremap = true, expr = true, desc = "Move to the end of the line" }
)

-- Position the cursor at the top (gzh), middle (gzm) or bottom (gzl) of the screen
vim.keymap.set("n", "gzh", "H", { noremap = true, desc = "Position the cursor at the top of the screen" })
vim.keymap.set("n", "gzm", "M", { noremap = true, desc = "Position the cursor at the middle of the screen" })
vim.keymap.set("n", "gzl", "L", { noremap = true, desc = "Position the cursor at the bottom of the screen" })

-- gi already moves to "last place you exited insert mode", so we'll map gI to
-- something similar: move to last change
vim.keymap.set("n", "gI", "`.i", { noremap = true, desc = "Move to the last change" })

-- Repeat f/t/F/T movements without ,/;
vim.keymap.set({ "n", "v" }, "f<Enter>", ";", { noremap = true, desc = "Repeat the last f movement" })
vim.keymap.set({ "n", "v" }, "t<Enter>", ";", { noremap = true, desc = "Repeat the last t movement" })
vim.keymap.set({ "n", "v" }, "f<BS>", ",", { noremap = true, desc = "Repeat the last F movement" })
vim.keymap.set({ "n", "v" }, "t<BS>", ",", { noremap = true, desc = "Repeat the last T movement" })

-- ------------------------------------------------------------------------------ }}}

-- Folding {{{
-- ------------------------------------------------------------------------------

-- Open fold
vim.keymap.set(
  "n",
  "l",
  "x2a#folding#can_open_fold('.') ? 'zo' : 'l'",
  { noremap = true, expr = true, desc = "Open fold" }
)

-- Double-click to toggle folds
vim.keymap.set(
  "n",
  "<2-LeftMouse>",
  [[x2a#folding#can_toggle_fold(".") ? "za" : "]]
    .. vim.api.nvim_replace_termcodes("<2-LeftMouse>", true, true, true)
    .. [["]],
  { noremap = true, expr = true, desc = "Toggle fold" }
)

-- Close all folds except the current one
vim.keymap.set(
  "n",
  "g<Space>",
  "<Cmd>call x2a#folding#focus_fold('.')<CR>",
  { noremap = true, silent = true, desc = "Close all folds except the current one" }
)

-- ------------------------------------------------------------------------------ }}}

-- Visual mode {{{
-- ------------------------------------------------------------------------------

-- In VISUAL mode:
--   v switches to VISUAL BLOCK mode
-- In VISUAL BLOCK mode:
--   v switches to VISUAL mode
-- In any VISUAL mode:
--   <C-v> goes back to NORMAL mode
vim.keymap.set(
  "v",
  "v",
  [[mode() == "v" ? '<C-v>' : 'v']],
  { noremap = true, expr = true, replace_keycodes = false, desc = "Toggle between visual mode and visual block mode" }
)

vim.keymap.set("v", "<C-v>", "<Esc>", { noremap = true, desc = "Get out of visual mode" })

-- Select the contents of the current line,
-- excluding indentation.
vim.keymap.set(
  "n",
  "vv",
  "^vg_",
  { noremap = true, desc = "Select the contents of the current line, excluding indentation." }
)

-- Source: https://vim.fandom.com/wiki/Selecting_your_pasted_text
-- Select the last changed (or pasted) text
vim.keymap.set("n", "gv", function()
  return string.format("`[%s`]", vim.fn.strpart(vim.fn.getregtype(), 0, 1))
end, { noremap = true, expr = true, desc = "Select the last changed (or pasted) text" })

-- ------------------------------------------------------------------------------ }}}

-- Command mode {{{
-- ------------------------------------------------------------------------------

-- Disable some annoying mappings
vim.keymap.set("c", "<C-x>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set("c", "<C-_>", "<Nop>", { noremap = true, desc = "Disabled" })

vim.keymap.set("c", "<C-p>", "<Up>", { noremap = true, desc = "Previous command" })
vim.keymap.set("c", "<C-n>", "<Down>", { noremap = true, desc = "Next command" })

-- Move to next/previous character.
-- Calling `<Space><BS>` makes sure that
-- we get out of the wildmenu if it's active.
--
-- Credit: The `<Space><BS>` was taken from ryvnf/readline.vim
-- URL:    https://github.com/ryvnf/readline.vim/commit/e32951b
vim.keymap.set("c", "<C-b>", "<Space><BS><Left>", { noremap = true, desc = "Move to the previous character" })
vim.keymap.set("c", "<C-f>", "<Space><BS><Right>", { noremap = true, desc = "Move to the next character" })

vim.keymap.set("c", "<C-d>", "<Del>", { noremap = true, desc = "Delete the next character" })
vim.keymap.set("c", "<C-y>", "<C-r>+", { noremap = true, desc = "Paste the yanked text" })

-- ------------------------------------------------------------------------------ }}}

-- List all matches for a search
-- with their line number
vim.keymap.set(
  "n",
  "<Leader>/",
  "<Cmd>lvimgrep //gj %<CR>:rightbelow lwindow 10<CR>",
  { noremap = true, desc = "List all matches for a search with their line number" }
)

-- Remove search highlight and
-- clear any message already displayed.
vim.keymap.set(
  "n",
  "<Enter>",
  "<Cmd>nohlsearch<Bar>match<Bar>echo<CR>",
  { noremap = true, silent = true, desc = "Remove search highlight and clear any message already displayed." }
)

-- Extend a previous match
-- Source: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc#L1257
vim.keymap.set("n", "g/", "/<C-R>/", { noremap = true, desc = "Extend a previous match" })

-- Easier search
vim.keymap.set({ "n", "x" }, "<Leader>s", ":%s//<Left>", { noremap = true, desc = "Easier search" })

-- Same as */# but in a new split
vim.keymap.set("n", "<C-w>*", "<C-w>s*", { noremap = true, desc = "Same as * but in a new split" })
vim.keymap.set("n", "<C-w>#", "<C-w>s#", { noremap = true, desc = "Same as # but in a new split" })

-- use c* to change current word. than can use . to repeat action
vim.keymap.set("n", "c*", "*Ncgn", { noremap = true, desc = "Change current word. than can use . to repeat action" })

-- Select the entire file
vim.keymap.set(
  "n",
  "<Leader>a",
  require("0x2a.utils.buffer").select,
  { noremap = true, silent = true, desc = "Select the entire file" }
)

-- Yank the entire file
vim.keymap.set(
  "n",
  "<Leader>y",
  require("0x2a.utils.buffer").yank,
  { noremap = true, silent = true, desc = "Yank the entire file" }
)

vim.keymap.set(
  "n",
  [[<LocalLeader>rf]],
  [[:Rename <C-r>=expand("%:t")<CR>]],
  { noremap = true, desc = "Rename the current file" }
)

-- Matchit!
vim.keymap.set({ "n", "x", "o" }, "<BS>", "%", { remap = true, desc = "Matchit!" })
vim.keymap.set({ "n", "x", "o" }, "<S-BS>", "g%", { remap = true, desc = "Reverse Matchit!" })

-- Uppercase/Lowercase word under the cursor.
vim.keymap.set("n", "gU", "gUiw`]", { noremap = true, desc = "Uppercase word under the cursor." })
vim.keymap.set("n", "gu", "guiw`]", { noremap = true, desc = "Lowercase word under the cursor." })

-- Change the filetype of the current buffer
vim.keymap.set(
  "n",
  "<Leader>ff",
  ":SetFiletype<Space>",
  { noremap = true, desc = "Change the filetype of the current buffer" }
)

-- backgrounding in insert mode
vim.keymap.set("i", "<C-z>", "<C-o>:stop<CR>", { noremap = true, desc = "backgrounding in insert mode" })

-- Next/Previous tab
vim.keymap.set(
  "n",
  "]t",
  "<Cmd>call x2a#tabs#TabForward(v:count1)<CR>",
  { noremap = true, silent = true, desc = "Next tab" }
)

vim.keymap.set(
  "n",
  "[t",
  "<Cmd>call x2a#tabs#TabBaward(v:count1)<CR>",
  { noremap = true, silent = true, desc = "Previous tab" }
)

-- Got to tab by index/number
vim.keymap.set("n", "<leader>gt", "gt", { noremap = true, desc = "Got to tab by index/number" })

-- Next/Previous buffer
vim.keymap.set("n", "gb", "<Cmd>bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "gB", "<Cmd>bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Delete the contents of a line but not the line itself
vim.keymap.set(
  "n",
  "dL",
  [["_cc<Esc>]],
  { noremap = true, desc = "Delete the contents of a line but not the line itself" }
)

-- Go to file/tag in vertical split
-- Source: https://stackoverflow.com/a/52548754/123016
vim.keymap.set(
  "n",
  "<C-w><C-v>f",
  [[:execute "vertical normal <C-v><C-w>f"<CR>]],
  { noremap = true, desc = "Go to file in vertical split" }
)

vim.keymap.set(
  "n",
  "<C-w><C-v>[",
  [[:execute "vertical normal <C-v><C-w>["<CR>]],
  { noremap = true, desc = "Go to tag in vertical split" }
)

-- Macros {{{
-- ------------------------------------------------------------------------------

-- Disable Ex mode
-- Instead use Q to reapeat the last macro
vim.keymap.set("n", "Q", "@@", { noremap = true, desc = "reapeat the last macro" })

-- Repeats macro on every line
vim.keymap.set("v", "@", ":normal @", { noremap = true, desc = "Repeats macro on every line" })

-- ------------------------------------------------------------------------------ }}}

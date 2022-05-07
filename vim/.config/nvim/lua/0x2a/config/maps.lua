vim.g.mapleader = ","

-- Disabled keys {{{
-- ------------------------------------------------------------------------------

-- No Help, please
vim.keymap.set({ "i", "n", "v" }, "<F1>", "<Esc>")

-- Disable arrow keys
vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>")
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>")
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>")

-- Remap U to nothing, I hate U!
vim.keymap.set("n", "U", "<Nop>")

-- Disable ZZ and ZQ.
vim.keymap.set("n", "ZZ", "<Nop>")
vim.keymap.set("n", "ZQ", "<Nop>")

-- ------------------------------------------------------------------------------ }}}

-- Improvements and overrides {{{
-- ------------------------------------------------------------------------------

-- Don't store changed text
vim.keymap.set({ "n", "x" }, "c", [["_c]])
vim.keymap.set({ "n", "x" }, "C", [["_C]])

-- match 'Y' behavior with 'C' and 'D' : Y = yy -> y$
vim.keymap.set("n", "Y", "y$", { remap = true })

-- Get more information from ctrl-g:
vim.keymap.set("n", "<C-g>", "2<C-g>")

-- Alternate buffer
vim.keymap.set("n", "<C-e>", "<C-^>")

-- Universal opposite of J
vim.keymap.set("n", "S", "<Cmd>call x2a#breakhere#BreakHere()<CR>", { silent = true })

-- Use aesthetic middle of screen for "zz"
vim.keymap.set("n", "zz", "<Cmd>call x2a#movements#window#CenterCursorAesthetically()<CR>", { silent = true })

-- Stay in the center!!
vim.keymap.set("n", "<C-d>", "<C-d>:call x2a#movements#window#CenterCursorAesthetically()<CR>", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>:call x2a#movements#window#CenterCursorAesthetically()<CR>", { silent = true })

-- Do not exit visual mode when shifting
vim.keymap.set("x", ">", ">gv", { silent = true })
vim.keymap.set("x", "<", "<gv", { silent = true })

-- ------------------------------------------------------------------------------ }}}

-- Movements {{{
-- ------------------------------------------------------------------------------

-- Movement through splits in normal and visual mode (but not in select mode)
vim.keymap.set({ "n", "x" }, "<C-h>", "<C-w>h")
vim.keymap.set({ "n", "x" }, "<C-j>", "<C-w>j")
vim.keymap.set({ "n", "x" }, "<C-k>", "<C-w>k")
vim.keymap.set({ "n", "x" }, "<C-l>", "<C-w>l")

-- Linewise movement should work on screen lines
vim.keymap.set({ "n", "v" }, "$", "x2a#movements#line#Dollar()", { expr = true })
vim.keymap.set({ "n", "v" }, "g$", "x2a#movements#line#gDollar()", { expr = true })

vim.keymap.set({ "n", "v" }, "0", "x2a#movements#line#Zero()", { expr = true })
vim.keymap.set({ "n", "v" }, "g0", "x2a#movements#line#gZero()", { expr = true })

vim.keymap.set({ "n", "v" }, "^", "x2a#movements#line#Caret()", { expr = true })
vim.keymap.set({ "n", "v" }, "g^", "x2a#movements#line#gCaret()", { expr = true })

vim.keymap.set({ "n", "v" }, "k", "x2a#movements#line#Up()", { expr = true })
vim.keymap.set({ "n", "v" }, "gk", "x2a#movements#line#gUp()", { expr = true })

vim.keymap.set({ "n", "v" }, "j", "x2a#movements#line#Down()", { expr = true })
vim.keymap.set({ "n", "v" }, "gj", "x2a#movements#line#gDown()", { expr = true })

-- Remap H and L to beggining and end of
-- the line (Smart Home/End)
vim.keymap.set({ "n", "v" }, "H", "x2a#movements#line#Home()", { expr = true })
vim.keymap.set({ "n", "v" }, "L", "x2a#movements#line#End()", { expr = true })

-- Position the cursor at the top (gzh), middle (gzm) or bottom (gzl) of the screen
vim.keymap.set("n", "gzh", "H")
vim.keymap.set("n", "gzm", "M")
vim.keymap.set("n", "gzl", "L")

-- gi already moves to "last place you exited insert mode", so we'll map gI to
-- something similar: move to last change
vim.keymap.set("n", "gI", "`.i")

-- Repeat f/t/F/T movements without ,/;
vim.keymap.set({ "n", "v" }, "f<CR>", ";")
vim.keymap.set({ "n", "v" }, "t<CR>", ";")
vim.keymap.set({ "n", "v" }, "f<BS>", ",")
vim.keymap.set({ "n", "v" }, "t<BS>", ",")

-- ------------------------------------------------------------------------------ }}}

-- Folding {{{
-- ------------------------------------------------------------------------------

-- Open fold
vim.keymap.set("n", "l", "x2a#folding#can_open_fold('.') ? 'zo' : 'l'", { expr = true })

-- Toggle fold
vim.keymap.set(
  "n",
  "<Space>",
  [[x2a#folding#can_toggle_fold(".") ? "za" : "]]
    .. vim.api.nvim_replace_termcodes("<Space>", true, true, true)
    .. [["]],
  { expr = true }
)

-- Close all folds except the current one
vim.keymap.set("n", "g<Space>", "<Cmd>call x2a#folding#focus_fold('.')<CR>", { silent = true })

-- ------------------------------------------------------------------------------ }}}

-- Visual mode {{{
-- ------------------------------------------------------------------------------

-- In VISUAL mode:
--   v switches to VISUAL BLOCK mode
-- In VISUAL BLOCK mode:
--   v switches to VISUAL mode
-- In any VISUAL mode:
--   <C-v> goes back to NORMAL mode
vim.keymap.set("v", "v", [[mode() == "v" ? '<C-v>' : 'v']], { expr = true })
vim.keymap.set("v", "<C-v>", "<Esc>")

-- Select the contents of the current line,
-- excluding indentation.
vim.keymap.set("n", "vv", "^vg_")

-- Source: https://vim.fandom.com/wiki/Selecting_your_pasted_text
-- Select the last changed (or pasted) text
vim.keymap.set("n", "gv", function()
  return string.format("`[%s`]", vim.fn.strpart(vim.fn.getregtype(), 0, 1))
end, { expr = true })

-- ------------------------------------------------------------------------------ }}}

-- Command mode {{{
-- ------------------------------------------------------------------------------

-- Disable some annoying mappings
vim.keymap.set("c", "<C-x>", "<Nop>")
vim.keymap.set("c", "<C-_>", "<Nop>")

vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- Move to next/previous character.
-- Calling `<Space><BS>` makes sure that
-- we get out of the wildmenu if it's active.
--
-- Credit: The `<Space><BS>` was taken from ryvnf/readline.vim
-- URL:    https://github.com/ryvnf/readline.vim/commit/e32951b
vim.keymap.set("c", "<C-b>", "<Space><BS><Left>")
vim.keymap.set("c", "<C-f>", "<Space><BS><Right>")

vim.keymap.set("c", "<C-d>", "<Del>")
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<C-y>", "<C-r>+")

vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-f>", "<S-Right>")
vim.keymap.set("c", "<M-d>", "<S-Right><C-w>")
vim.keymap.set("c", "<M-BS>", "<C-w>")

-- ------------------------------------------------------------------------------ }}}

-- List all matches for a search
-- with their line number
vim.keymap.set("n", "<Leader>/", "<Cmd>lvimgrep //gj %<CR>:rightbelow lwindow 10<CR>")

-- Remove search highlight and
-- clear any message already displayed.
vim.keymap.set("n", "<CR>", "<Cmd>nohlsearch<Bar>match<Bar>echo<CR>", { silent = true })

-- Extend a previous match
-- Source: https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc#L1257
vim.keymap.set("n", "g/", "/<C-R>/")

-- Easier search
vim.keymap.set({ "n", "x" }, "<Leader>s", ":%s//<Left>")

-- Same as */# but in a new split
vim.keymap.set("n", "<C-w>*", "<C-w>s*")
vim.keymap.set("n", "<C-w>#", "<C-w>s#")

-- use c* to change current word. than can use . to repeat action
vim.keymap.set("n", "c*", "*Ncgn")

-- Select or yank the entire file
vim.keymap.set("n", "<Leader>a", "<Cmd>call x2a#buffers#Select()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>y", "<Cmd>YankBuffer<CR>", { silent = true })

vim.keymap.set("n", [[\rf]], [[:Rename <C-r>=expand("%:t")<CR>]])

-- Complete whole line
vim.keymap.set("i", "<C-l>", "<C-x><C-l>")

-- Matchit!
vim.keymap.set({ "n", "x", "o" }, "<BS>", "%", { remap = true })
vim.keymap.set({ "n", "x", "o" }, "<S-BS>", "g%", { remap = true })

-- Uppercase/Lowercase word under the cursor.
vim.keymap.set("n", "gU", "gUiw`]")
vim.keymap.set("n", "gu", "guiw`]")

-- Change the filetype of the current buffer
vim.keymap.set("n", "<Leader>ff", ":SetFiletype<Space>")

-- backgrounding in insert mode
vim.keymap.set("i", "<C-z>", "<C-o>:stop<CR>")

-- Next/Previous tab
vim.keymap.set("n", "gt", "<Cmd>call x2a#tabs#TabForward(v:count1)<CR>", { silent = true })
vim.keymap.set("n", "gT", "<Cmd>call x2a#tabs#TabBaward(v:count1)<CR>", { silent = true })

-- Got to tab by index/number
vim.keymap.set("n", "<leader>gt", "gt")

-- Next/Previous buffer
vim.keymap.set("n", "gb", "<Cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "gB", "<Cmd>bprevious<CR>", { silent = true })

-- Delete the contents of a line but not the line itself
vim.keymap.set("n", "dL", [["_cc<Esc>]])

-- Go to file/tag in vertical split
-- Source: https://stackoverflow.com/a/52548754/123016
vim.keymap.set("n", "<C-w><C-v>f", [[:execute "vertical normal <C-v><C-w>f"<CR>]])
vim.keymap.set("n", "<C-w><C-v>[", [[:execute "vertical normal <C-v><C-w>["<CR>]])

-- Macros {{{
-- ------------------------------------------------------------------------------

-- Disable Ex mode
-- Instead use Q to reapeat the last macro
vim.keymap.set("n", "Q", "@@")

-- Repeats macro on every line
vim.keymap.set("v", "@", ":normal @")

-- ------------------------------------------------------------------------------ }}}

-- Use escape to get out of insert mode in terminals
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- Module: 0x2a.config.options
-- Requires:
--   - 0x2a.utils
--   - 0x2a.utils.fs
--   - 0x2a.symbols
--   - 0x2a.winbar

local utils = require("0x2a.utils")
local fsutils = require("0x2a.utils.fs")
local symbols = require("0x2a.symbols")

-- Setup {{{
-- ------------------------------------------------------------------------------

vim.o.termguicolors = true

-- Python setup {{{
-- ------------------------------------------------------------------------------

-- @todo Rewrite in Lua
vim.api.nvim_exec(
  [[
    if filereadable(expand('~/.pyenv/versions/neovim2/bin/python'))
      let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    endif

    if filereadable(expand('~/.pyenv/versions/neovim3/bin/python'))
      let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
    endif
  ]],
  false
)

-- ------------------------------------------------------------------------------ }}}

-- Enable filetype.lua
vim.g.do_filetype_lua = 1

-- @todo Rewrite in Lua
vim.api.nvim_exec(
  [[
    filetype plugin indent on

    if !exists('g:syntax_on')
      syntax enable
    endif
  ]],
  false
)

-- Disable pre-bundled plugins {{{
-- ------------------------------------------------------------------------------

vim.g.loaded_2html_plugin = true
vim.g.loaded_getscript = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_gzip = true
vim.g.loaded_logiPat = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_rrhelper = true
vim.g.loaded_spellfile_plugin = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_tutor_mode_plugin = true
vim.g.loaded_vimball = true
vim.g.loaded_vimballPlugin = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true

-- ------------------------------------------------------------------------------ }}}

-- Disable the Perl provider
vim.g.loaded_perl_provider = false

-- ------------------------------------------------------------------------------ }}}

-- default shell
if utils.is_empty(vim.loop.os_getenv("SHELL")) then
  vim.o.shell = "/opt/homebrew/bin/zsh"
else
  vim.o.shell = vim.loop.os_getenv("SHELL")
end

-- Use the System Clipboard
if vim.fn.has("unnamedplus") then
  vim.opt.clipboard:prepend({ "unnamedplus" })
end

vim.opt.clipboard:prepend({ "unnamed" })

-- Disable all the fucking beeps, bells and flashes, ALL THE FUCKING TIME!
vim.o.errorbells = false
vim.o.visualbell = true
vim.o.belloff = "all"

-- Always tell me the number of lines changed by a command
vim.o.report = 0

-- Keep plenty of command and search history, because disk space is cheap
vim.o.history = 2000

-- Number format to use. Unsetting bascially only allows decimal.
-- Octal and hex may make trouble if tried to increment/decrement
-- certain numberformats (e.g. 007 will be incremented to 010, because vim thinks its octal)
vim.o.nrformats = ""

vim.opt.iskeyword:append({ "_", "$", "@", "%", "#", "-" })

-- Automatically update buffers when the
-- filesystem file changes
vim.o.autoread = true

-- Buffers and splits {{{
-- ------------------------------------------------------------------------------

vim.o.hidden = true
vim.opt.switchbuf = { "useopen", "uselast" }

-- Don't force all windows to have the same
-- size when creating new splits
vim.o.equalalways = false

-- New window goes below
vim.o.splitbelow = true

-- New windows goes right
vim.o.splitright = true

-- ------------------------------------------------------------------------------ }}}

-- Looks {{{
-- ------------------------------------------------------------------------------

-- UI {{{
-- ------------------------------------------------------------------------------

-- A slightly higher command-line window reduces
-- the chance of "window jumping" if more than one
-- line of text is displayed.
vim.o.cmdheight = 2
vim.o.cmdwinheight = 3
vim.o.more = false
vim.g.default_cmdheight = vim.o.cmdheight

-- Show the current file's name at the top of buffers
require("0x2a.winbar").setup()

-- Always show status line.
vim.o.laststatus = 3
vim.g.default_laststatus = vim.o.laststatus

-- Show open tabs. Always.
vim.o.showtabline = 2
vim.g.default_showtabline = vim.o.showtabline

-- Display an incomplete command in the
-- lower right corner of the Vim window
vim.o.showcmd = true
vim.g.default_showcmd = vim.o.showcmd

-- Pop-up menu's line height
vim.o.pumheight = 20

-- Pop-up menu's minimum width
vim.o.pumwidth = 25

-- Enable pseudo-transparency for the popup-menu
vim.o.pumblend = 5

-- Minimum help window height
vim.o.helpheight = 12

-- Completion preview height
vim.o.previewheight = 8

-- Window title
vim.o.title = true
vim.o.titlelen = 95
vim.o.titlestring = "%{x2a#TitleString#build()}"

-- I hate line numbers
vim.o.number = false
vim.o.relativenumber = false

-- Resize to accommodate multiple signs up to 4 signs
vim.o.signcolumn = "auto:3"

-- ------------------------------------------------------------------------------ }}}

-- Stop highlighting lines midway if they're too long
vim.o.synmaxcol = 1200
vim.o.colorcolumn = 120

-- prefer a slight higher line height
vim.o.linespace = 2

-- Don't highlight the current line
vim.o.cursorline = false

vim.opt.guicursor = {
  -- Block cursor in normal and visual modes
  -- set |'showmatch'| in insert mode
  "n-v-c-sm:block",

  -- Vertical line cursor in insert and command-line insert modes
  "i-ci-ve:ver25",

  -- Underbar cursor in replace, command-line replace and operator-pending modes
  "r-cr-o:hor20"
}

-- Don't delay redrawing
vim.o.lazyredraw = false

-- Show matching brackets.
vim.o.showmatch = true
vim.opt.matchpairs = { "(:)", "[:]", "{:}", "《:》", "〈:〉", "「:」", "『:』", "‘:’", "“:”" }

vim.o.list = true
vim.opt.listchars = {
  extends = symbols.word.truncate,
  nbsp = symbols.whitespace.nbsp,
  precedes = symbols.word.truncate,
  tab = symbols.whitespace.tab,
  trail = symbols.whitespace.trailing,
}

vim.opt.fillchars = {
  diff = "⣿",
  fold = "-",
  foldopen = symbols.fold.open,
  foldclose = symbols.fold.closed,
  horiz = symbols.separators.horizontal,
  horizup = symbols.separators.horizontal_up,
  horizdown = symbols.separators.horizontal_down,
  vert = symbols.separators.vertical,
  vertleft = symbols.separators.vertical_left,
  vertright = symbols.separators.vertical_right,
  verthoriz = symbols.separators.vertical_horizontal,
  eob = symbols.infinity,
}

vim.opt.showbreak = symbols.word["break"]
vim.o.ambiwidth = "single"

-- Whitespace {{{
-- ------------------------------------------------------------------------------

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.autoindent = true -- carry over indenting from previous line
vim.o.copyindent = true -- make autoindent use the same characters to indent
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.smarttab = true

-- ------------------------------------------------------------------------------ }}}

-- Color scheme
vim.o.background = "dark"

-- ------------------------------------------------------------------------------ }}}

-- Completion {{{
-- ------------------------------------------------------------------------------

-- Find recursively in directories
vim.opt.path:append({ "**" })

-- @todo Remove duplicates
vim.opt.tags:append({ "./tags", "./.git/tags" })

vim.o.dictionary = "/usr/share/dict/words"

-- Show more information while completing tags.
vim.o.showfulltag = true

vim.o.wildmenu = true
vim.o.wildignorecase = true
vim.opt.wildmode = { "longest", "full" }

-- wildignore {{{
-- ------------------------------------------------------------------------------

vim.opt.wildignore:append({
  -- version control
  ".git",
  ".hg",
  ".svn",
  "*.orig", -- Merge resolution files
  ".gitkeep",
  ".keep",

  -- latex intermediate files
  "*.aux",
  "*.fdb_latexmk",
  "*.fls",
  "*.idx",
  "*.out",
  "*.toc",

  -- binary documents and office documents
  "*.djvu",
  "*.doc", -- Microsoft Word
  "*.docx", -- Microsoft Word
  "*.dvi",
  "*.ods", -- Open Document spreadsheet
  "*.odt", -- Open Document spreadsheet template
  "*.pdf",
  "*.ps",
  "*.xls", -- Microsoft Excel
  "*.xlsx", -- Microsoft Excel

  -- binary images
  "*.bmp",
  "*.gif",
  "*.jpeg",
  "*.jpg",
  "*.png",

  -- fonts
  "*.eot",
  "*.ttf",
  "*.otf",
  "*.woff",
  "*.woff2",
  "*.svg",

  -- music
  "*.mp3",
  "*.flac",

  -- special vim files
  ".*.sw?", -- Vim swap files
  "*.spl", -- compiled spell word lists

  -- OS specific files
  ".DS_Store",

  -- Backups, caches, logs
  ".sass-cache",
  "*~",
  "*.zwc",
  "*.zwc.old",
  "*.cache",
  "*.log",

  -- compiled and binary files
  "*.class", -- java
  "*.dll", -- windows libraries
  "*.exe", -- windows executeables
  "*.o", -- object files
  "*.obj", -- ?
  "*.pyc", -- Python byte code
  "*.luac", -- Lua byte code
  "__pycache__", -- python stuff
  "*.egg-info", -- python stuff
  "*.p12",

  -- Xcode files
  "*.storyboard",
  "*.xib",
  "*.xcassets",
  "*.xcodeproj",
  "*.xcworkspace",
  "*.framework",

  -- unsuported archives and images
  "*.dmg",
  "*.iso",
  "*.tar",
  "*.tar.bz2",
  "*.tar.gz",
  "*.tbz2",
  "*.tgz",
  "*.zip",

  -- Other
  "tags",
})

-- ------------------------------------------------------------------------------ }}}

vim.opt.complete = {
  ".", -- Scan the current buffer
  "b", -- Scan other loaded buffers that are in the buffer list
  "w", -- Scan buffers from other windows
  "u", -- Scan the unloaded buffers that are in the buffer list
  "U", -- Scan the buffers that are not in the buffer list
}

vim.opt.completeopt = {
  "menuone", -- Show menu even if only 1 item long
  "noselect", -- Do not select a match in the menu, force the user to select one
}

vim.opt.suffixes:append({ ".log", ".out" })

-- ------------------------------------------------------------------------------ }}}

-- Timeouts {{{
-- ------------------------------------------------------------------------------

vim.o.timeout = true
vim.o.timeoutlen = 1000
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50
vim.g.default_timeoutlen = vim.o.timeoutlen
vim.g.default_ttimeoutlen = vim.o.ttimeoutlen

-- Time of inactivity to trigger CursorHold
vim.o.updatetime = 1000

-- ------------------------------------------------------------------------------ }}}

-- Search {{{
-- ------------------------------------------------------------------------------

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.gdefault = true
vim.o.inccommand = "nosplit"

if fsutils.is_executable("rg") then
  vim.o.grepprg = "rg --hidden --smart-case --vimgrep"
  vim.o.grepformat = "%f:%l:%c:%m"

  vim.cmd.cnoreabbrev("rg grep")
elseif fsutils.is_executable("ag") then
  vim.o.grepprg = "ag --hidden --smart-case --vimgrep"
  vim.o.grepformat = "%f:%l:%c:%m"

  vim.cmd.cnoreabbrev("ag grep")
end

-- ------------------------------------------------------------------------------ }}}

-- Movements {{{
-- ------------------------------------------------------------------------------

-- Make j/k respect the columns
vim.o.startofline = false

-- When the page starts to scroll, keep the cursor 4 lines
-- from the top and 4 lines from the bottom
vim.o.scrolloff = 4

-- Line to scroll when cursor leaves screen
vim.o.scrolljump = 4

-- Same as above but for horizontal scrolling
vim.o.sidescrolloff = 12

-- Number of cols to scroll at a time
vim.o.sidescroll = 1

-- Allow backspace beyond insertion point
vim.opt.backspace = { "indent", "eol", "start" }

-- Enable to select past the end of line in blockwise visual mode
vim.o.virtualedit = "block"

-- Do not fucking move the cursor for no fucking reason!!!
vim.o.whichwrap = ""

-- ------------------------------------------------------------------------------ }}}

-- Formatting {{{
-- ------------------------------------------------------------------------------

-- Wrapping shit
vim.o.wrap = false

-- Setup automatic text formatting/wrapping (formatoptions) {{{
-- ------------------------------------------------------------------------------

vim.opt.formatoptions = {
  c = true, -- Automatically wrap comment lines
  j = true, -- Remove comment string when joining lines
  r = true, -- Automatically continue comments
  ["2"] = true, -- Indent based on second line of para, not first
  o = true, -- Automatically continue comments when hitting 'o' or 'O'
  q = true, -- Allow formating of comments with 'gq'
  n = true, -- Automatically indent numbered lists
  l = true, -- Don't break long lines that were already there
  B = true, -- Don't insert space between multi-byte characters when joining lines
  ["1"] = true, -- Don't break a line after a one-letter word
}

-- ------------------------------------------------------------------------------ }}}

-- Only insert single space after a '.', '?' and '!' with a join command.
vim.o.joinspaces = false

vim.o.textwidth = 121

-- ------------------------------------------------------------------------------ }}}

-- Short message settings ('shortmess')
vim.opt.shortmess = {
  I = true, -- Skip the intro
  o = true, -- Overwrite message for writing a file with subsequent message for reading a file.
  O = true, -- Message for reading a file overwrites any previous message.
  t = true, -- Truncate long file messages at the start
  T = true, -- Truncate long messages in the middle
  W = true, -- Don't give "written" or "[w]" when writing a file
  a = true, -- Use short version of stuff (Same as filmnrwx)
  c = true, -- Shut off completion messages
}

-- Folding {{{
-- ------------------------------------------------------------------------------

-- Use markers for folds
vim.o.foldmethod = "marker"
vim.o.foldmarker = "{{{,}}}"

-- Size of the fold column
vim.o.foldcolumn = "0"

-- Start will all folds open
vim.o.foldlevelstart = 99

-- Better fold text
vim.o.foldtext = "AwesomeFoldText#foldtext()"

-- Type of commands that folds will open
vim.opt.foldopen = {
  "block", -- "(", "{", "[[", "[{", etc.
  "hor", -- horizontal movements: "l", "w", "fx", etc.
  "insert", -- any command in Insert mode
  "mark", -- jumping to a mark: "'m", CTRL-O, etc.
  "percent", -- "%"
  "quickfix", -- ":cn", ":crew", ":make", etc.
  "search", -- search for a pattern: "/", "n", "*", "gd", etc.
  "tag", -- jumping to a tag: ":ta", CTRL-T, etc.
  "undo", -- undo or redo: "u" and CTRL-R
}

-- ------------------------------------------------------------------------------ }}}

-- Swaps, backups, and undos {{{
-- ------------------------------------------------------------------------------

vim.o.backup = true
vim.o.writebackup = true

-- Keep backups with a .bak extension
vim.o.backupext = ".bak"

if utils.is_empty(os.getenv("SUDO_USER")) or os.getenv("USER") ~= os.getenv("SUDO_USER") then
  vim.o.swapfile = false
  vim.o.undofile = true

  vim.o.directory = vim.env.XDG_STATE_HOME .. "/nvim/swap//,.,/var/tmp"
  vim.o.backupdir = vim.env.XDG_STATE_HOME .. "/nvim/backup//,.,/var/tmp"
  vim.o.undodir = vim.env.XDG_STATE_HOME .. "/nvim/undo//,.,/var/tmp"

  vim.o.undolevels = 1000
  vim.o.undoreload = 10000

  -- Make important directories if they don't exist
  -- @todo Rewrite in Lua
  vim.api.nvim_exec(
    [[
      for s:dir in [&backupdir, &directory, &undodir, &viewdir]
        if empty(finddir(s:dir))
          call mkdir(s:dir, 'p', 0700)
        endif
      endfor
    ]],
    false
  )
else
  vim.o.shada = ""

  vim.opt.directory:remove({ vim.env.XDG_STATE_HOME .. "/nvim/swap//", "~/tmp" })
  vim.opt.backupdir:remove({ vim.env.XDG_STATE_HOME .. "/nvim/backup//", "~/tmp" })

  vim.o.undodir = ""
  vim.o.viewdir = ""
  vim.o.undofile = false
end

-- ------------------------------------------------------------------------------ }}}

-- Sessions {{{
-- ------------------------------------------------------------------------------

-- :h shada
vim.opt.shada = { "!", "'300", "<50", "s10", "h" }

-- Session options
vim.opt.sessionoptions = {
  -- Save empty windows
  "blank",

  -- Save the current directory
  "curdir",

  -- Save manually created folds, opened/closed folds and local fold options
  "folds",

  -- Save all tab pages
  "tabpages",

  -- Save window sizes
  "winsize",
}

-- ------------------------------------------------------------------------------ }}}

-- Diff options
vim.opt.diffopt = {
  -- Use the internal diff library.
  "internal",

  -- Show filler lines, to keep the text synchronized with a
  -- window that has inserted lines at the same position.
  "filler",

  -- Use the indent heuristic for the internal diff library.
  "indent-heuristic",

  -- Ignore changes in amount of white space
  "iwhite",

  -- Diff in vertical mode
  "vertical",

  -- Use the patience diff algorithm when creating a diff
  "algorithm:patience",
}

-- Mouse {{{
-- ------------------------------------------------------------------------------

-- Use the mouse only in normal mode and for hit-enter and more-prompt prompts
vim.o.mouse = "nr"

-- Hide the mouse when typing
vim.o.mousehide = true

-- Disable the right click
vim.o.mousemodel = ""

-- ------------------------------------------------------------------------------ }}}

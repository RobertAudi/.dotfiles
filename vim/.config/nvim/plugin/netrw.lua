-- 30% of the screen for the netrw window, 70% for the file window
vim.g.netrw_winsize = -30

-- hide banner
vim.g.netrw_banner = 0

-- ignore case on sorting
vim.g.netrw_sort_options = "i"

-- buffer setting
vim.g.netrw_bufsettings = "nomodifiable nomodified readonly nobuflisted nowrap"

-- keep current directory immune from the browsing directory.
vim.g.netrw_keepdir = 1

-- set tree style listing
vim.g.netrw_liststyle = 3

-- open file in a previous buffer (right window)
vim.g.netrw_browse_split = 4

-- hide swp, DS_Store files
vim.g.netrw_list_hide = ".*\\.swp$,\\.DS_Store"

-- display directories first
vim.g.netrw_sort_sequence = "[\\/]$"

-- Do not store netrw history in a location `.netrwhist` file.
vim.g.netrw_dirhistmax = 0

vim.opt_local.matchpairs:remove({ "<:>" })

-- `,` is NEVER a keyword. WTF!
vim.opt_local.iskeyword:remove({ "," })

local git = require("0x2a.git")

vim.api.nvim_create_user_command("GitPermalink", function(args)
  git.link({
    permalink = args.bang,
    line1 = args.line1,
    line2 = args.line2,
    range = args.range,
  })
end, {
  bang = true,
  range = 0,
  nargs = 0,
})

vim.api.nvim_create_user_command("GitBrowse", function(args)
  git.browse({
    permalink = args.bang,
    line1 = args.line1,
    line2 = args.line2,
    range = args.range,
  })
end, {
  bang = true,
  range = 0,
  nargs = 0,
})

vim.api.nvim_create_user_command("GitCopyPermalink", function(args)
  git.copy_link({
    permalink = args.bang,
    line1 = args.line1,
    line2 = args.line2,
    range = args.range,
  })
end, {
  bang = true,
  range = 0,
  nargs = 0,
})

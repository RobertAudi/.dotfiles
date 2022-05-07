local move_to_sanbox = require("0x2a.sandbox").move_to_sanbox

vim.api.nvim_create_user_command("Sandbox", function(args)
  move_to_sanbox({
    move = args.bang,
    line1 = args.line1,
    line2 = args.line2,
    range = args.range,
  })
end, {
  bang = true,
  range = 0,
  nargs = 0,
})

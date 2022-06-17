local Runner = require("nvim-test.runner")

local command = "rspec"

if require("0x2a.utils.files").file_exists("Gemfile") then
  command = "bundle exec " .. command
end

if require("0x2a.utils.files").file_exists(".envrc") then
  command = "DIRENV_LOG_FORMAT= direnv exec . " .. command
end

local rspec = Runner:init({
  command = { command },
  file_pattern = "\\v(spec_[^.]+|[^.]+_spec)\\.rb$",
  find_files = { "{name}_spec.rb" },
}, {
  ruby = [[
    (
      (call
        method: (identifier) @method-name
        (#match? @method-name "(describe|it|context)")
        arguments: (argument_list (string (string_content) @test-name))
      )
    @scope-root)
  ]],
})

function rspec:build_test_args(args, tests)
  table.insert(args, "--example")
  table.insert(args, table.concat(tests, " "))
end

return rspec

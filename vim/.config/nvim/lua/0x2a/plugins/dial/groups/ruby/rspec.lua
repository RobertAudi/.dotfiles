-- Module: 0x2a.plugins.dial.groups.ruby.rspec
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local augend = require("dial.augend")

return {
  augend.constant.new({ elements = { "describe", "context" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "it", "specify" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "to", "not_to" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "be_truthy", "be_falsey" }, word = true, cyclic = true }),

  -- Ruby
  augend.case.new({ types = { "camelCase", "snake_case", "PascalCase", "SCREAMING_SNAKE_CASE" }, cyclic = true }),

  augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "true", "false" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
  augend.constant.new({ elements = { "==", "!=" }, word = false, cyclic = true }),
  augend.constant.new({ elements = { "===", "!==" }, word = false, cyclic = true }),

  augend.constant.new({ elements = { "if", "unless" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "while", "until" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "raise", "fail" }, word = true, cyclic = true }),

  augend.constant.new({ elements = { "class", "module" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "min", "max" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "select", "reject" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "any?", "none?", "all?", "one?" }, word = true, cyclic = true }),

  -- Rails
  augend.constant.new({ elements = { "blank?", "present?" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "new_record?", "persisted?" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "where", "where.not" }, word = true, cyclic = true }),

  -- SQL
  augend.constant.new({ elements = { "asc", "desc" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "ASC", "DESC" }, word = true, cyclic = true }),

  -- Rails HTTP status codes
  augend.constant.new({ elements = { "100", ":continue", ":information" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "101", ":switching_protocols" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "102", ":processing" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "200", ":ok", ":success" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "201", ":created" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "202", ":accepted" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "203", ":non_authoritative_information" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "204", ":no_content" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "205", ":reset_content" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "206", ":partial_content" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "207", ":multi_status" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "208", ":already_reported" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "226", ":im_used" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "300", ":multiple_choices" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "301", ":moved_permanently" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "302", ":found" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "303", ":see_other" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "304", ":not_modified" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "305", ":use_proxy" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "306", ":reserved" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "307", ":temporary_redirect" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "308", ":permanent_redirect" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "400", ":bad_request" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "401", ":unauthorized" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "402", ":payment_required" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "403", ":forbidden" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "404", ":not_found" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "405", ":method_not_allowed" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "406", ":not_acceptable" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "407", ":proxy_authentication_required" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "408", ":request_timeout" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "409", ":conflict" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "410", ":gone" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "411", ":length_required" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "412", ":precondition_failed" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "413", ":request_entity_too_large" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "414", ":request_uri_too_long" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "415", ":unsupported_media_type" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "416", ":requested_range_not_satisfiable" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "417", ":expectation_failed" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "422", ":unprocessable_entity" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "423", ":precondition_required" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "424", ":too_many_requests" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "426", ":request_header_fields_too_large" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "500", ":internal_server_error" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "501", ":not_implemented" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "502", ":bad_gateway" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "503", ":service_unavailable" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "504", ":gateway_timeout" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "505", ":http_version_not_supported" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "506", ":variant_also_negotiates" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "507", ":insufficient_storage" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "508", ":loop_detected" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "510", ":not_extended" }, word = true, cyclic = true }),
  augend.constant.new({ elements = { "511", ":network_authentication_required" }, word = true, cyclic = true }),
}

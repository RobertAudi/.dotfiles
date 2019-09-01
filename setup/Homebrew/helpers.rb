require "rbconfig"

def macOS?
  RbConfig::CONFIG["host_os"] =~ /darwin/
end

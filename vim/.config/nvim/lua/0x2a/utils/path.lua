-- Module: 0x2a.utils.path

local M = {}

-- safe_encode returns a string which is safe to
-- use as a filesystem name.
--
-- this is helpful when encoding filesystem paths
-- to a string that can be used as a filename.
--
-- the encoding is just a sub-set of URL encoding.
--
-- @param str (string) The string to encode.
M.safe_encode = function(str)
  str, _ = string.gsub(str, "/", "%%2F")
  str, _ = string.gsub(str, " ", "%%20")
  str, _ = string.gsub(str, ":", "%%3A")
  return str
end

-- decodes a string encoded by safe_encode.
-- see safe_encode for details.
M.safe_decode = function(str)
  str, _ = string.gsub(str, "%%2F", "/")
  str, _ = string.gsub(str, "%%20", " ")
  str, _ = string.gsub(str, "%%3A", ":")
  return str
end

return M

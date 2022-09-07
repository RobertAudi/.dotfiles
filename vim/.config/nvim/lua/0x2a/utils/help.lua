-- Module: 0x2a.utils.help

local M = {}

-- Source: https://github.com/tjdevries/nlua.nvim/blob/3603ee35ed928acd961847aeac30c92a3a048997/lua/nlua/init.lua#L7-L42
M.keyword = function(word)
  local original_iskeyword = vim.bo.iskeyword

  vim.bo.iskeyword = vim.bo.iskeyword .. ",."
  word = word or vim.fn.expand("<cword>")

  vim.bo.iskeyword = original_iskeyword

  if string.find(word, "vim.api") then
    local _, finish = string.find(word, "vim.api.")
    local api_function = string.sub(word, finish + 1)

    vim.cmd.help(api_function)
  elseif string.find(word, "vim.fn") then
    local _, finish = string.find(word, "vim.fn.")
    local api_function = string.sub(word, finish + 1) .. "()"

    vim.cmd.help(api_function)
  else
    local ok = pcall(vim.cmd, string.format("help %s", word))

    if not ok then
      local split_word = vim.split(word, ".", true)

      ok = pcall(vim.cmd.help, split_word[#split_word])
    end

    if not ok then
      vim.lsp.buf.hover()
    end
  end
end

return M

-- Module: 0x2a.plugins.dial
-- Plugin: monaqa/dial.nvim
-- Description: Enhanced increment/decrement plugin for Neovim
-- URL: https://github.com/monaqa/dial.nvim

local M = {}

M.config = function()
  if not prequire("dial.config") then
    return
  end

  local dial_map = require("dial.map")

  require("dial.config").augends:register_group({
    default = require("0x2a.plugins.dial.groups.default"),
    visual = require("0x2a.plugins.dial.groups.visual"),
    switch = require("0x2a.plugins.dial.groups.switch"),
    css = require("0x2a.plugins.dial.groups.css"),
    lua = require("0x2a.plugins.dial.groups.lua"),
    gitrebase = require("0x2a.plugins.dial.groups.gitrebase"),
    vim = require("0x2a.plugins.dial.groups.vim"),
    javascript = require("0x2a.plugins.dial.groups.javascript"),
    ruby = require("0x2a.plugins.dial.groups.ruby"),
    rspec = require("0x2a.plugins.dial.groups.ruby.rspec"),
  })

  vim.keymap.set("n", "<C-a>", dial_map.inc_normal(), { noremap = true })
  vim.keymap.set("n", "<C-x>", dial_map.dec_normal(), { noremap = true })

  vim.keymap.set("n", "[s", dial_map.inc_normal("switch"), { noremap = true })
  vim.keymap.set("n", "]s", dial_map.dec_normal("switch"), { noremap = true })

  vim.keymap.set("v", "<C-a>", dial_map.inc_visual(), { noremap = true })
  vim.keymap.set("v", "<C-x>", dial_map.dec_visual(), { noremap = true })
  vim.keymap.set("v", "g<C-a>", dial_map.inc_gvisual(), { noremap = true })
  vim.keymap.set("v", "g<C-x>", dial_map.dec_gvisual(), { noremap = true })

  local augroup = vim.api.nvim_create_augroup("RAPluginsDial", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "css", "scss" },
    callback = function()
      vim.keymap.set("n", "[s", dial_map.inc_normal("css"), { buffer = true, noremap = true })
      vim.keymap.set("n", "]s", dial_map.dec_normal("css"), { buffer = true, noremap = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "gitrebase",
    callback = function()
      vim.keymap.set("n", "[s", dial_map.inc_normal("gitrebase"), { buffer = true, noremap = true })
      vim.keymap.set("n", "]s", dial_map.dec_normal("gitrebase"), { buffer = true, noremap = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "ruby",
    callback = function()
      vim.keymap.set("n", "[s", dial_map.inc_normal("ruby"), { buffer = true, noremap = true })
      vim.keymap.set("n", "]s", dial_map.dec_normal("ruby"), { buffer = true, noremap = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "rspec", "rspec.ruby", "ruby.rspec" },
    callback = function()
      vim.keymap.set("n", "[s", dial_map.inc_normal("rspec"), { buffer = true, noremap = true })
      vim.keymap.set("n", "]s", dial_map.dec_normal("rspec"), { buffer = true, noremap = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "javascript",
    callback = function()
      vim.keymap.set("n", "[s", dial_map.inc_normal("javascript"), { buffer = true, noremap = true })
      vim.keymap.set("n", "]s", dial_map.dec_normal("javascript"), { buffer = true, noremap = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "lua",
    callback = function()
      vim.keymap.set("n", "[s", dial_map.inc_normal("lua"), { buffer = true, noremap = true })
      vim.keymap.set("n", "]s", dial_map.dec_normal("lua"), { buffer = true, noremap = true })
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "vim",
    callback = function()
      vim.keymap.set("n", "[s", dial_map.inc_normal("vim"), { buffer = true, noremap = true })
      vim.keymap.set("n", "]s", dial_map.dec_normal("vim"), { buffer = true, noremap = true })
    end,
  })
end

return M

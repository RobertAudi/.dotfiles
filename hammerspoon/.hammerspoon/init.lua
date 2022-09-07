local validate = require("validate")

local layoutCache = {}
local layoutIterator = nil

local function tablelength(t)
  local i = 0

  for _ in pairs(t) do
    i = i + 1
  end

  return i
end

local function tablemerge(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end

  return t1
end

local function istable(t)
  return type(t) == "table"
end

local function buildLayout(params)
  return tablemerge({ factor = 0.05, index = 1, size = 1, pos = nil, rect = nil }, (istable(params) and params or {}))
end

-- -- --

local function maximizeWindow()
  local win = hs.window.focusedWindow()
  if not win:isFullScreen() then
    win:maximize()
  end
end

local function centerWindow()
  local win = hs.window.focusedWindow()

  if not win:isFullScreen() then
    local screen = win:screen():frame()

    win:setSize(hs.geometry.size(screen.w / 2, screen.h / 1.75))
    win:centerOnScreen()
  end
end

local function layoutSequenceIterator()
  if layoutIterator then
    return layoutIterator
  end

  local sequence = hs.geometry.unitrect
  local layoutSequences = {
    left = { sequence(0.00, 0, 0.35, 1), sequence(0.0, 0, 0.5, 1), sequence(0.00, 0, 0.75, 1) },
    right = { sequence(0.65, 0, 0.35, 1), sequence(0.5, 0, 0.5, 1), sequence(0.25, 0, 0.75, 1) },
  }

  layoutIterator = function(win, pos, reverse)
    local layout = layoutCache[win:id()]
    local position = string.lower(tostring(pos))

    if not layout or layout.pos ~= position then
      layout = buildLayout({ pos = position })
    end

    local count = tablelength(layoutSequences[layout.pos])
    if reverse then
      layout.size = layout.size > 1 and layout.size - 1 or count
    else
      layout.size = layout.size < count and layout.size + 1 or 1
    end

    layoutCache[win:id()] = layout

    return layoutSequences[layout.pos][layout.size]
  end

  return layoutIterator
end

local centerLayoutIterator = nil
local function centerLayoutIteration()
  if centerLayoutIterator then
    return centerLayoutIterator
  end

  local layouts = { min = 0.33, max = 1, initial = 0.45 }
  local factors = { min = 0.05, max = 0.75, multiplier = 1.5 }

  centerLayoutIterator = function(win, reverse)
    local layout = layoutCache[win:id()] or buildLayout({})

    if layout.rect == nil then
      layout.rect = hs.geometry.unitrect(0, 0, layouts.initial, layouts.initial)
    elseif reverse then
      if layout.rect.w > layouts.min then
        layout.factor = math.max(layout.factor / factors.multiplier, factors.min)
        layout.rect.w = math.max(layout.rect.w - layout.factor, layouts.min)
      end
    elseif layout.rect.w < layouts.max then
      layout.factor = math.min(layout.factor * factors.multiplier, factors.max)
      layout.rect.w = math.min(layout.rect.w + layout.factor, layouts.max)
    end

    layout.rect.h = layout.rect.w
    layout.rect.x = 0
    layout.rect.y = 0

    layoutCache[win:id()] = layout

    return layout.rect
  end

  return centerLayoutIterator
end

local function cycleLayout(position, reverse)
  local win = hs.window.focusedWindow()

  if not win:isFullScreen() then
    win:moveToUnit(layoutSequenceIterator()(win, position, reverse))
  end
end

local function cycleCenterLayout(reverse)
  local win = hs.window.focusedWindow()

  if not win:isFullScreen() then
    win:moveToUnit(centerLayoutIteration()(win, reverse))
    win:centerOnScreen()
  end
end

local function toggleApplication(applicationName)
  local app = hs.appfinder.appFromName(applicationName)

  if app and app:isFrontmost() then
    app:hide()
  else
    hs.application.launchOrFocus(applicationName)
  end
end

local remapKey = function(opts)
  validate({
    opts = { opts, "table" },
    from = { opts.from, "table" },
    to = { opts.to, "table" },
    app = { opts.app, { "string", "nil" } },
  })

  validate({
    from_key = { opts.from.key, "string" },
    to_key = { opts.to.key, "string" },
  })

  hs.hotkey.bind(opts.from.modifiers or {}, opts.from.key, function()
    local app = hs.application.frontmostApplication()

    if opts.app and app:bundleID() == opts.app then
      hs.eventtap.keyStroke(opts.to.modifiers or {}, opts.to.key, 0, app)
    else
      hs.eventtap.keyStroke(opts.from.modifiers or {}, opts.from.key, 0, app)
    end
  end)
end

local remapKeys = function(keys, opts)
  validate({
    keys = { keys, "table" },
    opts = { opts, "table" },
    app = { opts.app, { "string", "nil" } },
  })

  for _, key in pairs(keys) do
    if not key.app and opts.app then
      key.app = opts.app
    end

    remapKey(key)
  end
end

-- Disable animations
hs.window.animationDuration = 0

-- Load the hs.ipc module to be able to use the hs CLI tool
require("hs.ipc")

local hyper = { "Shift", "Cmd", "Alt", "Ctrl" }

-- stylua: ignore start
hs.hotkey.bind(hyper, "Left",  function() cycleLayout("Left")  end)
hs.hotkey.bind(hyper, "Right", function() cycleLayout("Right") end)

hs.hotkey.bind(hyper, "Up",   function() cycleCenterLayout(false) end)
hs.hotkey.bind(hyper, "Down", function() cycleCenterLayout(true)  end)

hs.hotkey.bind(hyper, "Z", function() maximizeWindow() end)
hs.hotkey.bind(hyper, "C", function() centerWindow()   end)

hs.hotkey.bind(hyper, "F", function() hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind(hyper, "N", function() toggleApplication("Numi") end)
hs.hotkey.bind(hyper, "M", function() hs.application.launchOrFocus("MailMate") end)
hs.hotkey.bind(hyper, "Q", function() hs.application.launchOrFocus("Quiver") end)
hs.hotkey.bind(hyper, "I", function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind(hyper, "T", function() hs.application.launchOrFocus("Things3") end)
hs.hotkey.bind(hyper, "S", function() hs.application.launchOrFocus("System Preferences") end)
hs.hotkey.bind(hyper, "1", function() hs.application.launchOrFocus("1Password") end)
hs.hotkey.bind(hyper, "2", function() hs.application.launchOrFocus("Authy Desktop") end)
hs.hotkey.bind(hyper, "`", function() hs.application.launchOrFocus("Launchpad") end)
hs.hotkey.bind(hyper, "Space", function() toggleApplication("Dash") end)
-- stylua: ignore end

remapKeys({
  {
    from = { modifiers = { "Cmd" }, key = "h" },
    to = { modifiers = { "Ctrl" }, key = "h" },
  },
  {
    from = { modifiers = { "Cmd" }, key = "j" },
    to = { modifiers = { "Ctrl" }, key = "j" },
  },
  {
    from = { modifiers = { "Cmd" }, key = "k" },
    to = { modifiers = { "Ctrl" }, key = "k" },
  },
  {
    from = { modifiers = { "Cmd" }, key = "l" },
    to = { modifiers = { "Ctrl" }, key = "l" },
  },

  -- Undo
  {
    from = { modifiers = { "Cmd" }, key = "z" },
    to = { modifiers = { "Ctrl" }, key = "-" },
  },

  -- Redo
  -- NOTE: For zsh the following binding must be defined:
  --         bindkey -M emacs "$key_info[Escape]-" redo
  {
    from = { modifiers = { "Cmd", "Shift" }, key = "z" },
    to = { modifiers = { "Option" }, key = "-" },
  },

  -- Go to previous word
  {
    from = { modifiers = { "Option" }, key = "Left" },
    to = { modifiers = { "Option" }, key = "b" },
  },

  -- Go to next word
  {
    from = { modifiers = { "Option" }, key = "Right" },
    to = { modifiers = { "Option" }, key = "f" },
  },

  -- Delete previous word
  {
    from = { modifiers = { "Option" }, key = "Delete" },
    to = { modifiers = { "Ctrl" }, key = "w" },
  },

  -- Go to beginning of line
  {
    from = { modifiers = { "Command" }, key = "Left" },
    to = { modifiers = { "Ctrl" }, key = "a" },
  },

  -- Go to end of line
  {
    from = { modifiers = { "Command" }, key = "Right" },
    to = { modifiers = { "Ctrl" }, key = "e" },
  },

  -- Delete to the beginning of line
  -- NOTE: For zsh the following binding must be defined:
  --         bindkey -M emacs "$key_info[Control]U" backward-kill-line
  {
    from = { modifiers = { "Command" }, key = "Delete" },
    to = { modifiers = { "Ctrl", "Shift" }, key = "u" },
  },
}, { app = "com.googlecode.iterm2" })

hs.loadSpoon("WifiNotifier")
spoon.WifiNotifier:start()

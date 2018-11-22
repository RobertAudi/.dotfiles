local layoutCache = {}
local layoutIterator = nil

local function tablelength(t)
  local i = 0
  for _ in pairs(t) do i = i + 1 end
  return i
end

local function tablemerge(t1, t2)
  for k,v in pairs(t2) do t1[k] = v end
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
  hs.window.focusedWindow():maximize()
end

local function centerWindow()
  local win = hs.window.focusedWindow()
  win:moveToUnit(hs.geometry.unitrect(0.125, 0.125, 0.35, 0.5))
  win:centerOnScreen()
end

local function layoutSequenceIterator()
  if layoutIterator then return layoutIterator end

  local sequence = hs.geometry.unitrect
  local layoutSequences = {
    left   = { sequence(0.00, 0, 0.35, 1), sequence(0.0, 0, 0.5, 1), sequence(0.00, 0, 0.75, 1) },
    right  = { sequence(0.65, 0, 0.35, 1), sequence(0.5, 0, 0.5, 1), sequence(0.25, 0, 0.75, 1) }
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
  if centerLayoutIterator then return centerLayoutIterator end

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
  win:moveToUnit(layoutSequenceIterator()(win, position, reverse))
end

local function cycleCenterLayout(reverse)
  local win = hs.window.focusedWindow()
  win:moveToUnit(centerLayoutIteration()(win, reverse))
  win:centerOnScreen()
end

-- Disable animations
hs.window.animationDuration = 0

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Left",  function() cycleLayout("Left")  end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Right", function() cycleLayout("Right") end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Up",   function() cycleCenterLayout(false) end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Down", function() cycleCenterLayout(true)  end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "M",  function() maximizeWindow() end)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "C",  function() centerWindow()   end)

require "monitor-management"

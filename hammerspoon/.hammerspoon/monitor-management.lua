-- -----------------------------------------------------------------------
--                         ** Something Global **                       --
-- -----------------------------------------------------------------------
  -- Uncomment this following line if you don't wish to see animations
hs.window.animationDuration = 0
grid = require "hs.grid"
grid.setMargins('0, 0')

-- Set screen watcher, in case you connect a new monitor, or unplug a monitor
screens = {}
local screenwatcher = hs.screen.watcher.new(function()
  screens = hs.screen.allScreens()
end)
screenwatcher:start()

-- Please leave a comment if you have any suggestions
-- I know this looks weird, but it works :C
current = {}
function init()
  current.win = hs.window.focusedWindow()
  current.scr = hs.window.focusedWindow():screen()
end

function current:new()
  init()
  o = {}
  setmetatable(o, self)
  o.window, o.screen = self.win, self.scr
  return o
end

-- -----------------------------------------------------------------------
--                   ** ALERT: GEEKS ONLY, GLHF  :C **                  --
--            ** Keybinding configurations locate at bottom **          --
-- -----------------------------------------------------------------------

local function throwLeft()
  local this = current:new()
  this.window:moveOneScreenWest()
end

local function throwRight()
  local this = current:new()
  this.window:moveOneScreenEast()
end

-- -----------------------------------------------------------------------
--                           ** Key Binding **                          --
-- -----------------------------------------------------------------------

hs.hotkey.bind({ "cmd", "alt" }, "Left",   function() throwLeft()  end)
hs.hotkey.bind({ "cmd", "alt" }, "Right",  function() throwRight() end)

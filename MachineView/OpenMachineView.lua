--[[
@noindex
@description Hackey-Machines: An interface plugin for REAPER 5.x and up designed to mimick the machine editor in Jeskola Buzz.
@author: Joep Vanlier
@provides
  MachineView.lua
  [main] .
@links
  https://github.com/JoepVanlier/Hackey-Machines
@license MIT
@version 0.33 
@screenshot 
  https://i.imgur.com/WP1kY6h.png
@about 
  ### Hackey-Machines
  #### What is it?
  A lightweight machine plugin for REAPER 5.x and up.
  
  Usage
  
  Hackey Machines provides an alternative way for visualizing and manipulating the routing in REAPER. 
  Press F1 for an in-plugin help file.
  
  If you use this plugin and enjoy it let me/others know. If you run into any bugs
  and figure out a way to reproduce them, please open an issue on the plugin's
  github page [here](https://github.com/JoepVanlier/Hackey-Trackey/issues). I would
  greatly appreciate it!
  
  Happy routin' :)
--]]

--[[
 * Changelog:
 * v0.33 (2018-08-13)
   + Ctrl + doubleclick machine opens MPL Wiredchain (relies on it already being installed!)
   + Alt + doubleclick opens FX window instead of just first effect
   + Change rename color dark theme
   + Added little cursor thingy for renaming machines
 * v0.32 (2018-08-13)
   + Added ESC to close all floating windows (relies on SWS).
 * v0.31 (2018-08-13)
   + Added a loader for the script (OpenMachineView.lua) which makes sure that the existing one regains focus or a new one is created when executed.
 * v0.30 (2018-08-13)
   + Store window position and dock status in project file
 * v0.29 (2018-08-13)
   + Center zoom on mouse
 * v0.28 (2018-08-13)
   + Add signal flow highlighting
 * v0.27 (2018-08-13)
   + Fixed CTRL + click behaviour
 * v0.26 (2018-08-13)
   + Had an issue with machine deletion not properly propagation folderdepth (special thanks to Meta for helping me out with this one).
 * v0.25 (2018-08-13)
   + Fixed multi-delete bug.
 * v0.24 (2018-08-13)
   + Added redo/save/load shortcuts.
 * v0.23 (2018-08-13)
   + Added automatic alphabetical sorting of instruments and templates.
 * v0.22 (2018-08-12)
   + Added mac support with brackets (hopefully/untested!)
 * v0.21 (2018-08-12)
   + Improved dark theme (switch with F5)
   + Made sure master keeps name "MASTER"
 * v0.20 (2018-08-12)
   + Made delete behaviour more buzz-like (deleting a machine removes all connections).
 * v0.19 (2018-08-12)
   + Added template support.
 * v0.18 (2018-08-11)
   + Pass through CTRL+Z.
 * v0.17 (2018-08-11)
   + Added controls to change source and dest channel.
   + Improved undo handling.
   + Display panning 0L(eft) as C(enter).
   + Added small help under F1.
 * v0.16 (2018-08-09)
   + Added multi-delete and multi-hide.
 * v0.15 (2018-08-07)
   + Add selection ability.
   + Fixed bug with arrows taking precedence over block on top of them.
 * v0.14 (2018-08-06)
   + Minor tweak simulation algorithm to ignore unmatched machines.
 * v0.13 (2018-08-06)
   + Add option to hide machines (Toggle show all with F4).
 * v0.12 (2018-08-06)
   + Fix in verlet integration routine for graph-force algorithm.
   + Fix when opening the same project file.
   + Continuous storage of positions.
 * v0.11 (2018-08-06)
   + Bugfix that avoids sinks from being unnecessarily refreshed
 * v0.10 (2018-08-06)
   + Continuously check if tracks require updating (to avoid errors when user suddenly deletes stuff manually)
 * v0.09 (2018-08-06)
   + Separated out user configuration of VSTs to include in menu. Open notepad to the file with F10.
 * v0.08 (2018-08-06)
   + Added ability to add machines from a menu (outer mouse button). Still requires user to 
     make machine list. Should split file out at some point to allow customization per user without
     it interfering with what is being updated in the repo.
 * v0.07 (2018-08-05)
   + Added ability to route from nested track to master (reorganizing the tracklist)
 * v0.06 (2018-08-05)
   + Added option to rename machines.
 * v0.05 (2018-08-05)
   + Added display option (track name (where non-default) versus effect name). Toggle with F3.
 * v0.04 (2018-08-05)
   + Added signal display (Toggle with F2)
 * v0.03 (2018-08-05)
   + Added solo handling
   + Added track menu
   + Added duplication
   + Added track removal
 * v0.02 (2018-08-05)
   + Fixed bug in initial position assignments.
 * v0.01 (2018-08-03)
   + First upload. Basic functionality works, but cannot add new machines from the GUI yet.
--]]

--[[  This script loads another script. It performs the following actions.
  
  1. Set requestFocus in external project state defined in extStateIdx.
  2. Looks up the command ID for script to be opened (scriptName) in "Reaper-kb.ini".
  3. Waits a few cycles and then attempts to open it if requestFocus is still set to 1.
  4. The other script should set requestFocus to zero in its update loop and close and 
     reinitialise its GUI (gfx.quit and gfx.init) if it is still active. This will regrab 
     the focus without reinitializing the script.
]]--

wait = 0
scriptName = 'MachineView.lua'
extStateIdx = "MVJV001"
focusTag = "requestFocus"

local function get_script_path()
  local info = debug.getinfo(1,'S');
  local script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
  local resourcepath = reaper.GetResourcePath()
  local offs = "Scripts/"
  return script_path:sub(resourcepath:len()+offs:len()+2,-1):gsub("\\", "/")
end

local function findCommandID(fn, name)
  local commandID
  local lines = {}
  for line in io.lines(fn) do
    lines[#lines + 1] = line
  end
    
  local name = get_script_path() .. scriptName
  for i,v in pairs(lines) do
    if ( v:find(name, 1, true) ) then
      local startidx = v:find("RS", 1, true)
      local endidx = v:find(" ", startidx, true)
      commandID = (v:sub(startidx,endidx-1))
    end
  end
  
  return "_" .. commandID
end

local function print(...)
  if ( not ... ) then
    reaper.ShowConsoleMsg("nil value\n")
    return
  end
  reaper.ShowConsoleMsg(...)
  reaper.ShowConsoleMsg("\n")
end

local function focusRequested()
  local ok, v = reaper.GetProjExtState(0, extStateIdx, focusTag)
  if ( ok ) then v = tonumber( v ) end
  return v or 0
end

local function Main()
  -- Is there already one of me open?
  if ( wait == 0 ) then
    wait = 1
    reaper.defer(Main)
  else
    if ( focusRequested() == 1 ) then
      -- The other script did not reply. Load it!
      local cmd = reaper.NamedCommandLookup( commandID )
      reaper.Main_OnCommand(cmd, 0)
    end
  end
end

local function preMain()
  reaper.SetProjExtState(0, extStateIdx, focusTag, tonumber(1))
  
  local fn = reaper.GetResourcePath() .. '//' .. "Reaper-kb.ini"
  local f = io.open(fn, "r")
  if f then
    commandID = findCommandID(fn, scriptName)
  
    f:close()
    reaper.defer(Main)    
  else
    reaper.ShowMessageBox("FAILED TO OPEN REAPER-KB.INI", "CRITICAL ERROR", 0)
  end
  
end

preMain()

--[[
@description Hackey-Machines Loader
@author: Joep Vanlier
@links
  https://github.com/JoepVanlier/Hackey-Machines
@license MIT
@version 0.36
@screenshot 
  https://i.imgur.com/WP1kY6h.png
@about 
  This script can be used as loader for HackeyMachines. It only loads one instance 
  and when called again, refocuses that instance rather that opening a new one.
  
  
--[[
  1. Set requestFocus in external project state defined in extStateIdx.
  2. Looks up the command ID for script to be opened (scriptName) in "Reaper-kb.ini".
  3. Waits a few cycles and then attempts to open it if requestFocus is still set to 1.
  4. The other script should set requestFocus to zero in its update loop and close and 
     reinitialise its GUI (gfx.quit and gfx.init) if it is still active. This will regrab 
     the focus without reinitializing the script.
]]--

wait = 0
scriptName = 'MachineView_exec.lua'
extStateIdx = "MVJV001"
focusTag = "requestFocus"

local function print(...)
  if ( not ... ) then
    reaper.ShowConsoleMsg("nil value\n")
    return
  end
  reaper.ShowConsoleMsg(...)
  reaper.ShowConsoleMsg("\n")
end

local function get_script_path()
  local info = debug.getinfo(1,'S');
  local script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
  local resourcepath = reaper.GetResourcePath()
  local offs = "Scripts/"
  return script_path:sub(resourcepath:len()+offs:len()+2,-1):gsub("\\", "/")
end

local function findCommandID(fn, name)
  local commandID = nil
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
      commandID = "_" .. commandID
    end
  end
  
  return commandID
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
  
  local fn = reaper.GetResourcePath() .. '//' .. "reaper-kb.ini"
  local f = io.open(fn, "r")
  if f then
    commandID = findCommandID(fn, scriptName)
    
    f:close()
    if ( commandID ) then
      reaper.defer(Main)    
    end
  else
    reaper.ShowMessageBox("FAILED TO OPEN REAPER-KB.INI", "CRITICAL ERROR", 0)
  end
  
end

preMain()

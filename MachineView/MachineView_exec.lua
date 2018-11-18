--[[
@description Hackey-Machines: An interface plugin for REAPER 5.x and up designed to mimick the machine editor in Jeskola Buzz.
@author: Joep Vanlier
@links
  https://github.com/JoepVanlier/Hackey-Machines
@license MIT
@version 0.52
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
 * v0.52 (2018-11-17)
   + Added extra F9 option for showing only routing of selected tracks.
   + Get closer to native colors.
   + Added word-wrapping for machine names.
 * v0.51 (2018-10-19)
   + Show signal cable as active when manipulating signal
   + Make doubleclick focus on first effect
 * v0.50 (2018-09-27)
   + Suppress dialog when VST machine list doesn't exist
 * v0.49 (2018-09-21)
   + Changed grid opacity
   + Changed grid to square
   + REM => DEL for disconnect
   + Added modifier option to send audio to sidechain
   + Added option to swap move button to RMB (F12)
   + Added console messages
 * v0.48 (2018-09-17)
   + Added return to default on double-click
 * v0.47 (2018-08-16)
   + Fixed issue with MASTER mute and solo behavior
 * v0.46 (2018-08-15)
   + Attempted fix for rename issue
 * v0.45 (2018-08-15)
   + Bugfix in delete behaviour.
 * v0.44 (2018-08-14)
   + Added (optional) use of track colors.
   + Finished system that will allow to use multiple key/mouse bindings.
   + Added double escape = close.
   + Added hover over signal cables to visualize signal cable.
 * v0.43 (2018-08-14)
   + Groundwork for adding multiple key/mouse bindings
 * v0.42 (2018-08-14)
   + Fix renderbug on linux.
 * v0.41 (2018-08-14)
   + Added optional grid snapping
 * v0.40 (2018-08-13)
   + Check if old position exists before randomizing (makes sure that undo maintains position).
 * v0.39 (2018-08-13)
   + Minor usability improvements
   + Renamed REM to DEL
   + Faster zooming
   + Slower dial motions when holding shift and control
   + Preventing deleting MASTER :D
 * v0.38 (2018-08-13)
   + Hackey Trackey Integration ==> Shift + Double LMB
 * v0.37 (2018-08-13)
   + Also parse user folders now. Moved location in the code where the builtin folder is cached, to isolate bugs in case they occur and not make the whole script unusable.
 * v0.36 (2018-08-13)
   + Parse user categories. Added under shift + click.
 * v0.35 (2018-08-13)
   + Added visualization and toggle of record option
 * v0.34 (2018-08-13)
   + Messing with how it is indexed in reapack 
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

scriptName = "Hackey Machines v0.52"
altDouble = "MPL Scripts/FX/mpl_WiredChain (background).lua"
hackeyTrackey = "Tracker tools/Tracker/tracker.lua"

machineView = {}
machineView.tracks = {}
machineView.config = {}
machineView.config.blockWidth = 100
machineView.config.blockHeight = 50
machineView.config.width = 500
machineView.config.height = 500
machineView.config.x = 100
machineView.config.y = 100
machineView.config.d = 0
machineView.config.square = 1

machineView.config.muteOrigX = 4
machineView.config.muteOrigY = 4
machineView.config.muteWidth = 14
machineView.config.muteHeight = 7
machineView.config.keymap = 0
machineView.config.maxkeymap = 1
machineView.config.msgTime = 2.5

messages = {}

templates = {}
templates.slash = '\\'
templates.extension = ".RTrackTemplate"

-- This variable is set to 1 when blocks are moved by the move routines.
-- It is then set to 2 at the start of the next the cycle.
-- If it 2 by the end of that cycle, we assume the user stopped moving the objects.
machineView.blocksMoving = 0

recCornerSize = .2

local keys = {}
local keymapNames = {}
keymapNames[0] = 'default'
keymapNames[1] = 'foxAsteria'

local function initializeKeys( keymap )
  -- 0 must be off, 1 must be on, 2 = don't care; keystroke nil means, don't check
  --                               LMB   RMB   MMB   DBL   CTRL    ALT   SHIFT   Keycode
  keys.openSinkControl    = {        1,    2,    2,    2,     2,     2,      2,      nil }    -- lmb
  keys.openSinkControl2   = {        2,    1,    2,    2,     2,     2,      2,      nil }    -- rmb
  keys.openMachineControl = {        2,    1,    2,    2,     2,     2,      2,      nil }    -- rmb
  keys.deleteSink         = {        0,    0,    1,    2,     2,     2,      2,      nil }    -- only mmb
  keys.deleteMachine      = {        0,    0,    1,    2,     2,     2,      2,      nil }    -- only mmb
  keys.multiSelect        = {        2,    2,    2,    2,     1,     2,      2,      nil }    -- select multiple machines (ctrl)
  keys.move               = {        1,    2,    2,    2,     2,     2,      2,      nil }    -- move machine around (lmb)
  keys.addSink            = {        2,    2,    2,    2,     2,     2,      1,      nil }    -- drag a cable out (shift, note that this is combined with move)
  keys.addSinkSecond      = {        2,    2,    2,    2,     1,     2,      1,      nil }    -- drag a cable out (shift, note that this is combined with move)
  keys.mplscript          = {        1,    0,    0,    1,     1,     0,      0,      nil }    -- ctrl + doubleclick
  keys.hackey             = {        1,    0,    0,    1,     0,     0,      1,      nil }    -- shift + doubleclick
  keys.showvst            = {        1,    0,    0,    1,     0,     1,      0,      nil }    -- alt + doubleclick
  keys.trackfx            = {        1,    0,    0,    1,     0,     0,      0,      nil }    -- doubleclick
  keys.additiveSelect     = keys.multiSelect                                                  -- ctrl + drag select additively adds machines
  keys.drag               = {        2,    2,    1,    2,     2,     2,      2,      nil }    -- drag field of view (mmb)
  keys.addMachine         = {        2,    1,    2,    2,     2,     2,      2,      nil }    -- add machine (rmb)
  
  keys.delete             = {        2,    2,    2,    2,     0,     0,      0,      6579564.0 }    -- delete machines (del)
  keys.minzoom            = {        2,    2,    2,    2,     0,     0,      0,      1885828464 }   -- minzoom (pgup)
  keys.maxzoom            = {        2,    2,    2,    2,     0,     0,      0,      1885824110 }   -- maxzoom (pgdown)
  keys.close              = {        2,    2,    2,    2,     0,     0,      0,      27 }           -- close windows (esc)
  keys.undo               = {        2,    2,    2,    2,     1,     0,      0,      26 }           -- undo (ctrl + z)
  keys.redo               = {        2,    2,    2,    2,     1,     0,      1,      26 }           -- undo (ctrl + shift + z)
  keys.save               = {        2,    2,    2,    2,     1,     0,      0,      19 }           -- save (ctrl + s)
  keys.hideMachines       = {        2,    2,    2,    2,     0,     0,      0,      104 }          -- hide machines (h)
  keys.simulate           = {        2,    2,    2,    2,     1,     0,      0,      13 }           -- simulate (return)
  keys.help               = {        2,    2,    2,    2,     0,     0,      0,      26161 }        -- help (F1)
  keys.recGroup           = {        2,    2,    2,    2,     1,     0,      0,      18 }           -- set record group (ctrl + r)
  keys.showSignals        = {        2,    2,    2,    2,     0,     0,      0,      26162 }        -- toggle show signals (F2)
  keys.trackNames         = {        2,    2,    2,    2,     0,     0,      0,      26163 }        -- toggle show track names (F3)
  keys.showHidden         = {        2,    2,    2,    2,     0,     0,      0,      26164 }        -- show hidden machines (F4)
  keys.night              = {        2,    2,    2,    2,     0,     0,      0,      26165 }        -- toggle night mode (F5)
  keys.grid               = {        2,    2,    2,    2,     0,     0,      0,      26166 }        -- toggle grid (F6)
  keys.snapall            = {        2,    2,    2,    2,     0,     0,      0,      26167 }        -- snap all to grid (F7)
  keys.sfx                = {        2,    2,    2,    2,     0,     0,      0,      26168 }        -- surprise! (F8)
  keys.hideWires          = {        2,    2,    2,    2,     0,     0,      0,      26169 }        -- hide wires (F9)
  keys.customizeMachines  = {        2,    2,    2,    2,     0,     0,      0,      6697264 }      -- customize machine list (F10)
  keys.toggleTrackColors  = {        2,    2,    2,    2,     0,     0,      0,      6697265 }      -- toggle track colors (F11)
  keys.toggleKeymap       = {        2,    2,    2,    2,     0,     0,      0,      6697266 }      -- toggle key map (F12)  
  
  if ( keymap == 1 ) then
    keys.addMachine         = {        2,    2,    1,    2,     2,     2,      2,      nil }    -- add machine (mmb)
    keys.drag               = {        2,    1,    2,    2,     2,     2,      2,      nil }    -- drag field of view (rmb)
  end
end

help = {
  {"Shift drag machine", "Connect machines"},    
  {"Left click arrow", "Volume, panning, channel and disconnect controls"},
  {"Drag on dial", "Change setting"},
  {"Ctrl + drag on dial", "Change setting (5x slower)"},
  {"Shift + drag on dial", "Change setting (10x slower)"},
  {"Shift + Ctrl + drag on dial", "Change setting (50x slower)"},
  {"Ctrl click machine", "Select multiple machines"},
  {"Right click machine", "Solo, mute, rename, duplicate or remove machine"},
  {"Right click background", "Insert machine from user menu (F10 to customize)"},
  {"Shift + right click background", "Insert machine from reaper wide categories"},  
  {"Middle click object", "Delete signal cable or machine"},
  {"Middle click drag", "Shift field of view"},
  {"Scrollwheel", "Adjust zoom level"},
  {"Page up", "Minimal Zoom"},
  {"Page down", "Default Zoom"},
  {"Ctrl + Scrollwheel", "Adjust zoom level (5x slower)"},
  {"Shift + Scrollwheel", "Adjust zoom level (10x slower)"},  
  {"Double click machine", "Open FX list"},
  {"Alt + Double click machine", "Open machine VST GUI"},  
  {"Ctrl + Double click machine", "Open FX list with MPL Wiredchain (needs to be installed)"},    
  {"Shift + Double click machine", "Open Hackey Trackey on that track (if MIDI data is available)"},
  {"Leftclick drag", "Select multiple machines"},
  {"Ctrl + Enter", "Simulate forces between machines"},
  {"Del", "Delete machine"},
  {"H", "Hide machine"},
  {"F1", "Help"},
  {"F2", "Toggle signal visualization"},
  {"F3", "Toggle showing track names versus machine names"},
  {"F4", "Toggle showing hidden machines"},
  {"F5", "Toggle night mode"},
  {"F6", "Toggle snap to grid (off, on/non-visible, on/visible)"},
  {"F7", "Snap everything to grid"},
  {"F8", "Weird stuff"},
  {"F9", "Hide wires / Show only wires of selected tracks / Show wires"},  
  {"F10", "Open FX editing list (windows only)"},
  {"F11", "Toggle use of track colors"},    
  {"F12", "Toggle key layout (0 = default, 1 = RMB drag, MMB insert machine)"},
  {"CTRL + H", "Hide wires"},
  {"CTRL + R", "Set selection to record"},
  {"CTRL + S", "Save"},
  {"CTRL + Z", "Undo"},
  {"CTRL + SHIFT + Z", "Redo"},
  {"ESCAPE", "Close floating windows"},
  {"DOUBLE ESCAPE", "Close window"},  
}

local lmb, rmb, mmb, ctrl, alt, shift
local function updateInputs()
  lmb = gfx.mouse_cap & 1
  if ( lmb > 0 ) then lmb = 1 end  
  rmb = gfx.mouse_cap & 2
  if ( rmb > 0 ) then rmb = 1 end
  mmb = gfx.mouse_cap & 64
  if ( mmb > 0 ) then mmb = 1 end
  ctrl = gfx.mouse_cap & 4
  if ( ctrl > 0 ) then ctrl = 1 end  
  shift = gfx.mouse_cap & 8
  if ( shift > 0 ) then shift = 1 end
  alt = gfx.mouse_cap & 16
  if ( alt > 0 ) then alt = 1 end
end

defaultFile = "FXlist = {\n  Instruments = {\n    \"Kontakt\",\n    \"Play\",\n    \"VacuumPro\",\n    \"FM8\",\n    \"Massive\",\n    \"Reaktor 6\",\n    \"Oatmeal\",\n    \"Z3TA+2\",\n    \"Firebird\",\n    \"SQ8L\",\n    \"Absynth 5\",\n    \"Tyrell N6\",\n    \"Zebralette\",\n    \"Podolski\",\n    \"Hybrid\",\n    \"mda SubSynth\",\n    \"Crystal\",\n    \"Rapture\",\n    \"Claw\",\n    \"DX10\",\n    \"JX10\",\n    \"polyIblit\",\n    \"dmiHammer\"\n  },\n  Drums = {\n    \"Battery4\",\n    \"VSTi: Kontakt 5 (Native Instruments GmbH) (16 out)\",\n    \"Kickbox\",\n  },\n  Effects = {\n    EQ = {\n      \"ReaEq\",\n     \"BootEQmkII\",\n      \"VST3: OneKnob Phatter Stereo\"\n    },\n    Filter = {\n      \"BiFilter\",\n      \"MComb\",\n      \"AtlantisFilter\",\n      \"ReaFir\",\n      \"Apple 12-Pole Filter\",\n      \"Apple 2-Pole Lowpass Filter\",\n      \"Chebyshev 4-Pole Filter\",\n      \"JS: Exciter\",\n    },\n   Modulation = {\n      \"Chorus (Improved Shaping)\",\n      \"Chorus (Stereo)\",\n      \"Chorus CH-1\",\n      \"Chorus CH-2\",\n      \"VST3: MFlanger\",\n      \"VST3: MVibrato\",\n      \"VST3: MPhaser\",\n      \"VST3: Tremolo\",\n    },\n    Dynamics = {\n      \"VST3: API-2500 Stereo\",\n      \"VST3: L1 limiter Stereo\",\n      \"VST3: TransX Wide Stereo\",\n      \"VST3: TransX Multi Stereo\",\n      \"ReaComp\",\n      \"ReaXComp\",\n      \"VST3:Percolate\",\n    },\n    Distortion = {\n      \"Amplitube 3\",\n      \"Renegade\",\n      \"VST3: MSaturator\", \n       \"VST3: MWaveShaper\",\n     \"VST3: MWaveFolder\",\n      \"Guitar Rig 5\",\n      \"Cyanide 2\",\n      \"Driver\",\n    },\n    Reverb = {\n      \"ReaVerb\",\n      \"VST3: IR-L fullStereo\",\n      \"VST3: H-Reverb Stereo/5.1\",\n      \"VST3: H-Reverb long Stereo/5.1\",\n      \"VST3: RVerb Stereo\",\n      \"epicVerb\",\n      \"Ambience\",\n      \"Hexaline\",\n      \"ModernFlashVerb\",\n    },\n    Delay = {\n      \"ReaDelay\",\n      \"VST3: H-Delay Stereo\",\n      \"VST3: STADelay\",\n      \"MjRotoDelay\",\n      \"ModernSpacer\",\n    },\n    Mastering = {\n      \"VST3: Drawmer S73\",\n      \"VST3: L1+ Ultramaximizer Stereo\",\n      \"VST3: Elephant\",\n    },\n    Strip = {\n      \"VST3: Scheps OmniChannel Stereo\",\n      \"VST3: SSLGChannel Stereo\",\n    },\n    Stereo = {\n      \"VST3: S1 Imager Stereo\",\n      \"VST3: MSpectralPan\",\n      \"VST3: MStereoExpander\",\n      \"VST3: Propane\",\n      \"Saike StereoManipulator\",\n    },\n    Gate = {\n      \"ReaGate\",\n    },\n    Pitch = {\n      \"ReaPitch\",\n      \"ReaTune\",\n    },\n    Vocoder = {\n      \"mda Talkbox\",\n    },\n    Analysis = {\n      \"SideSpectrum Meter\"\n    },\n  },\n}\n"
--print(defaultFile)
doubleClickIntervalTarget = 0.2
origin = { 0, 0 }
zoom = 0.8

useColors = 1
showSignals = 1
showTrackName = 1
showHidden = 0
hideWires = 0
night = 0
grid = 0

local function xtrafo(x)
  return x * zoom + origin[1]
end
local function ytrafo(y)
  return y * zoom + origin[2]
end

-- Enum
SINKTYPES = { 
  SEND=1, 
  PARENT=2, 
  MASTER=3 
}

local function print(...)
  if ( not ... ) then
    reaper.ShowConsoleMsg("nil value\n")
    return
  end
  reaper.ShowConsoleMsg(...)
  reaper.ShowConsoleMsg("\n")
end

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent, maxindent, verbose)
  if ( not tbl ) then
    print( "nil" )
    return
  end
  if ( type(tbl) == "table" ) then 
    if not maxindent then maxindent = 2 end
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      local formatting = string.rep(" ", indent) .. k .. ": "
      if type(v) == "table" then
        if ( indent < maxindent ) then
          print(formatting)
          tprint(v, indent+1, maxindent)
        end
      else
        -- Hide the functions in shared.lua for clarity
        if ( not verbose ) then
          if type(v) == 'boolean' then
            print(formatting .. tostring(v))
          elseif type(v) == 'number' then
            print(formatting .. tostring(v))
          else
            print(formatting .. tostring(v))
          end
        end
      end
    end
  else
    if ( type(tbl) == "function" ) then 
      print('Function supplied to tprint instead of table')
    end
  end
end 

local function inputs( name, dbl )
  -- Bitmask oddly enough doesn't behave as expected
  local checkMask = keys[name]
  if ( not checkMask ) then
    error( 'Failed to find mask for ' .. name )
  end
  
  if ( checkMask[1] == lmb or ( checkMask[1] == 2 ) ) then
    if ( checkMask[2] == rmb or ( checkMask[2] == 2 ) ) then
      if ( checkMask[3] == mmb or ( checkMask[3] == 2 ) ) then
        if ( checkMask[4] == dbl or ( checkMask[4] == 2 ) ) then
          if ( checkMask[5] == ctrl or ( checkMask[5] == 2 ) ) then
            if ( checkMask[6] == alt or ( checkMask[6] == 2 ) ) then
              if ( checkMask[7] == shift or ( checkMask[7] == 2 ) ) then
                if ( checkMask[8] ) then
                  if ( checkMask[8] == lastChar and prevChar == 0 ) then
                    return true
                  end
                else
                  return true;
                end
              end
            end
          end
        end
      end
    end
  end
  
  return false
end

local function sortTable(data)
  -- Find the keys of interest
  local tableKeys = {}
  local entryKeys = {}
  for i,v in pairs(data) do
    if type(v) == "table" then
      tableKeys[#tableKeys+1] = i
    else
      entryKeys[#entryKeys+1] = v
    end
  end
  table.sort( tableKeys )
  table.sort( entryKeys )
  
  -- Construct the integer keyed table recursively
  local newTable = {}
  for i,v in pairs( tableKeys ) do
    newTable[i] = sortTable( data[v] )
    newTable[i].name__ = v
  end
  for i,v in pairs( entryKeys ) do
    newTable[i+#tableKeys] = v
  end
  
  return newTable
end

function machineView:printMessage( msg )
  messages[#messages+1] = { self.config.msgTime, msg }
end


function machineView:drawMessages(t)
  local fontsize = 12
  local messages = messages
  local cTime = reaper.time_precise()
  local dt = cTime - (self.lastMsgTime or cTime)
  local i = 1
  local x = 10
  local y = 10
  while ( i < #messages+1 ) do
    messages[i][1] = messages[i][1] - dt
    if ( messages[i][1] < 0 ) then
      messages[i] = nil
      for j = i,#messages-1 do
        messages[j] = messages[j+1]
      end
      messages[#messages] = nil
    else
      gfx.setfont(1, "Verdana", fontsize)
      if ( night == 1 ) then
        gfx.set(.7, .7, .7, .9)      
      else
        gfx.set(.2, .2, .2, .9)
      end
      gfx.x = x
      gfx.y = y
      gfx.drawstr(messages[i][2])
    end
    
    y = y + fontsize + 2
    i = i + 1
  end
  
  self.lastMsgTime = cTime
end

-- Grab the focus
function machineView:focusMe()
  reaper.SetProjExtState(0, "MVJV001", "requestFocus", tonumber(0))
  gfx.quit()
  gfx.init(scriptName, self.config.width, self.config.height, self.config.d, self.config.x, self.config.y)
end

local function focusRequested()
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "requestFocus")
  if ( ok ) then v = tonumber( v ) end
  return v or 0
end

colors = {}
function machineView:loadColors(colorScheme)
  -- If you come up with a cool alternative color scheme, let me know
  if colorScheme == "default" then
    -- Buzz
    colors.textcolor        = {1/256*48, 1/256*48, 1/256*33, 1}
    colors.linecolor        = {1/256*48, 1/256*48, 1/256*33, 1}    
    colors.linecolor2       = {1/256*218, 1/256*214, 1/256*201, 1}
    colors.windowbackground = {1/256*218, 1/256*214, 1/256*201, 1}
    colors.buttonbg         = { 0.1, 0.1, 0.1, .7 }
    colors.buttonfg         = { 0.3, 0.9, 0.4, 1.0 }
    colors.connector        = { .2, .2, .2, 0.8 }   
    colors.muteColor        = { 0.9, 0.3, 0.4, 1.0 }
    colors.inactiveColor    = { .6, .6, .6, 1.0 }
    colors.signalColor      = {1/256*129, 1/256*127, 1/256*105, 1}
    colors.selectionColor   = {.3, 0.2, .5, 1}    
    colors.renameColor      = colors.muteColor
    colors.playColor        = {0.2, 0.8, 0.6, 1.0}
    colors.gridColor        = {0.05, 0.05, 0.05, 0.2}
  elseif colorScheme == "dark" then
    colors.textcolor        = {148/256, 148/256, 148/256, 1}
    colors.linecolor        = {46/256, 46/256, 46/256, 1}    
    colors.linecolor2       = {.1, .1, .1, 0.6}
    colors.windowbackground = {18/256, 18/256, 18/256, 1}
    colors.buttonbg         = { 0.1, 0.1, 0.1, .7 }
    colors.buttonfg         = { 0.3, 0.9, 0.4, 1.0 }
    colors.connector        = { .4, .4, .4, 0.8 }
    colors.muteColor        = { 0.9, 0.3, 0.4, 1.0 }
    colors.inactiveColor    = { .6, .6, .6, 1.0 } 
    colors.signalColor      = {37/256,111/256,222/256, 1.0}  
    colors.selectionColor   = {.2, .2, .5, 1}        
    colors.renameColor      = { 0.6, 0.3, 0.5, 1.0 }
    colors.playColor        = {0.3, 1.0, 0.4, 1.0}    
    colors.gridColor        = {0.35, 0.25, 0.53, 0.3}
  end
  -- clear colour is in a different format
  gfx.clear = colors.windowbackground[1]*256+(colors.windowbackground[2]*256*256)+(colors.windowbackground[3]*256*256*256)
end

local function launchTextEditor(filename)
  if ( isMac ) then
    os.execute("open -a TextEdit \""..filename.."\"")
  else
    os.execute("start notepad \""..filename.."\"")
  end
end

local function get_script_path()
  local info = debug.getinfo(1,'S');
  local script_path = info.source:match[[^@?(.*[\/])[^\/]-$]]
  return script_path
end

local function getFXListFn()
  local dir = get_script_path()
  local scriptname = dir.."FX_list"
  local filename = scriptname..".lua"
  return filename
end

local function getConfigFn()
  local dir = get_script_path()
  local scriptname = dir.."config"
  local filename = scriptname..".cfg"
  return filename
end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function wrapPrint(str, maxlen, maxline)
  local done
  local cpos = 1
  local lastLineStart = 1
  local lastWordStart = 1
  local maxline = maxline or 1
  local line = 1
  local outStr = ''
  str = str .. ' ';
  while( not done ) do
    local cchar = str:sub(cpos, cpos)
    if ( cchar == " " ) then
      local cstr = str:sub(lastLineStart, cpos)
      local mx = gfx.measurestr( cstr )
      if ( mx > maxlen ) then
        if ( lastLineStart == lastWordStart ) then
          done = true
        else
          outStr = str:sub(lastLineStart, lastWordStart) .. '\n'
          lastLineStart = lastWordStart
          line = line + 1
          if ( line > maxline ) then
            done = true;
          end
        end
      else
        lastWordStart = cpos
      end
    end
    cpos = cpos + 1
       
    if ( cpos > str:len() ) then
      done = true
    end
  end

  outStr = outStr .. str:sub(lastLineStart, -1)
  
  return outStr, line
end

local function box( x, y, w, h, name, fgline, fg, bg, xo, yo, w2, h2, showSignals, fgData, d, loc, N, rnc, hidden, selected, playColor, selectionColor, rec )
  local gfx = gfx
  
  local xmi = xtrafo( x - 0.5*w )
  local xma = xtrafo( x + 0.5*w )
  local ymi = ytrafo( y - 0.5*h )
  local yma = ytrafo( y + 0.5*h )
  local w = xma - xmi --zoom * w
  local h = zoom * h

  gfx.set( 0.0, 0.0, 0.0, 0.8 )
  gfx.rect(xmi, ymi, w, h+1 )
    
  gfx.set( table.unpack(bg) )
  gfx.rect(xmi, ymi, w, h+3 )

  if ( showSignals > 0 ) then
    gfx.set( table.unpack( fgData ) )
    local step = (xma-xmi)/N
    local dy = (yma-ymi)
    local yl = ymi+d[loc]*dy
    local xl = xmi
    local xc = xmi
    local yc
    for i=1,N do
      yc = ymi + d[loc] * dy
      if ( showSignals == 1 ) then
        gfx.line(xl, yl, xc, yc)
      else
        gfx.line(xc, yma, xc, yc)      
      end
      yl = yc
      xl = xc
      xc = xc + step
      loc = loc + 1
      if ( loc > N ) then
        loc = 1
      end
    end
  end

  if ( hidden == 1 ) then
    gfx.set( table.unpack(fgData) )  
  else
    gfx.set( table.unpack(fgline) )
  end
  gfx.line(xmi, ymi, xma, ymi)
  gfx.line(xmi, yma, xma, yma)
  gfx.line(xmi, ymi, xmi, yma)
  gfx.line(xma, ymi, xma, yma)
  gfx.set( 0, 0, 0, 0.3 )
  gfx.line(xmi+1, yma+1, xma+1, yma+1)
  gfx.line(xma+1, ymi+1, xma+1, yma+1)
  gfx.line(xmi+2, yma+2, xma+2, yma+2)
  gfx.line(xma+2, ymi+2, xma+2, yma+2)    
  
  local c = recCornerSize
  if ( rec ) then
    gfx.set( table.unpack( rec ) )
    gfx.triangle(xma-1, ymi+1, xma-1, ymi - c*(ymi-yma), xma + c*(ymi-yma), ymi+1)
  else
    gfx.set( table.unpack( fg ) )
    gfx.triangle(xma-1, ymi+1, xma-1, ymi - c*(ymi-yma), xma + c*(ymi-yma), ymi+1)
  end
  
  if ( hidden == 1 ) then
    gfx.set( table.unpack(fgData) )  
  else
    gfx.set( table.unpack(fg) )
  end
  
  gfx.setfont(1, "Lucida Grande", math.floor(19*zoom))
  
  if ( rnc ) then
    gfx.set( table.unpack(rnc) )
    local tc = 3*reaper.time_precise()
    local extraChar = ''
    if ( tc - 2*math.floor(tc/2) > 1 ) then
      extraChar = '_'
    end
    local wc, hy = gfx.measurestr( name )
    local wc2 = gfx.measurestr( '_' )
    gfx.x = xtrafo(x) - 0.5*wc + 2 - .5*wc2
    gfx.y = ytrafo(y) - 0.5*hy
    gfx.drawstr( name .. extraChar, 1 )
  else
    local wc, hc, lines
    name, lines = wrapPrint(name, w-4)
    gfx.x = xtrafo(x) - 0.5*w + 4
    gfx.y = ytrafo(y) - 0.18*h - math.max(0,(lines-1))*0.09*h
    gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
  end
  
  w2 = w2*zoom
  h2 = h2*zoom
  local xmi2 = xmi + xo
  local xma2 = xmi + xo + w2
  local ymi2 = ymi + yo
  local yma2 = ymi + yo + h2
  gfx.set( table.unpack(playColor) ) 
  gfx.rect(xmi2, ymi2, w2, h2 + 1 )
  
  gfx.set( table.unpack(fg) )    
  gfx.line(xmi2, ymi2, xma2, ymi2)
  gfx.line(xmi2, yma2, xma2, yma2)
  gfx.line(xmi2, ymi2, xmi2, yma2)
  gfx.line(xma2, ymi2, xma2, yma2)
  
  if ( hidden == 1 ) then
    gfx.set( bg[1]*.8, bg[2]*.8, bg[3]*.8, 0.6 )
    gfx.rect(xmi, ymi, w, h+1 )
  end  
  
  if ( selected > 0 ) then
    gfx.set( table.unpack( fgData ) )
    xmi = xmi - 2
    ymi = ymi - 2
    xma = xma + 4
    yma = yma + 4
    
    gfx.line(xmi, ymi, xma, ymi)
    gfx.line(xmi, yma, xma, yma)
    gfx.line(xmi, ymi, xmi, yma)
    gfx.line(xma, ymi, xma, yma)
    
    gfx.set( selectionColor[1], selectionColor[2], selectionColor[3], selected )
    gfx.rect(xmi, ymi, w+7, h+7 )
  end
end

-- World space drawing routines
wgfx = {
  line = function(x1, y1, x2, y2)
    gfx.line( xtrafo(x1), ytrafo(y1), xtrafo(x2), ytrafo(y2) )
  end,
  rect = function(x, y, w, h)
    gfx.rect( xtrafo(x), ytrafo(y), zoom*w, zoom*h )
  end,  
  thickline = function(x1, y1, x2, y2, w, stepsize, color)
    local cx = xtrafo( x1 )
    local cy = ytrafo( y1 )
    local dx = xtrafo( x2 ) - cx
    local dy = ytrafo( y2 ) - cy
    local len = math.sqrt( dx*dx + dy*dy )
    dx = dx / len
    dy = dy / len
    
    -- Space to edges perpendicular to line
    local cx2 = cx + w * dy
    local cy2 = cy - w * dx
    cx = cx - 2 * w * dy
    cy = cy + 2 * w * dx
    local xl = cx
    local yl = cy
    local xl2 = cx2
    local yl2 = cy2
    local rt = 3*reaper.time_precise()
    gfx.set(table.unpack(color))
    dx = dx * stepsize
    dy = dy * stepsize
    for j = 0,len,stepsize do
      gfx.a = math.abs( math.sin(10*j + rt) )
      cx = cx + dx
      cy = cy + dy
      cx2 = cx2 + dx
      cy2 = cy2 + dy       
      gfx.line( xl, yl, cx, cy )
      gfx.line( xl2, yl2, cx2, cy2 )          
      gfx.triangle(xl, yl, cx, cy, xl2, yl2)
      gfx.triangle(cx, cy, cx2, cy2, xl2, yl2)
      xl = cx
      yl = cy
      xl2 = cx2
      yl2 = cy2
    end
  end
}

local function sub(v1, v2)
  return { v2[1] - v1[1], v2[2] - v1[2] }
end

local function dot(v1, v2)
  return v1[1] * v2[1] + v1[2] * v2[2]
end

local function calcCenter( triangle )
  return { ( triangle[1][1] + triangle[2][1] + triangle[3][1] ) / 3, ( triangle[1][2] + triangle[2][2] + triangle[3][2] ) / 3 }
end

local function inTriangle( triangle, point )
  -- Compute vectors        
  local v0 = sub(triangle[3], triangle[1] );
  local v1 = sub(triangle[2], triangle[1] );
  local v2 = sub(point, triangle[1] );

  -- Compute dot products
  local dot00 = dot(v0, v0);
  local dot01 = dot(v0, v1);
  local dot02 = dot(v0, v2);
  local dot11 = dot(v1, v1);
  local dot12 = dot(v1, v2);

  -- Compute barycentric coordinates
  local invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
  local u = (dot11 * dot02 - dot01 * dot12) * invDenom;
  local v = (dot00 * dot12 - dot01 * dot02) * invDenom;

  -- Check if point is in triangle
  return (u >= 0) and (v >= 0) and (u + v < 1);
end

button = {}
function button.create(parent, x, y, c, c2, callback, update, fg, bg)
  local self    = {}
  self.parent   = parent
  self.x        = x
  self.y        = y
  self.c        = c
  self.c2       = c2
  self.bg       = bg or colors.buttonbg
  self.fg       = fg or colors.buttonfg
  self.callback = callback
  self.update   = update
  
  self.draw = function( self )
  
    if ( self.update ) then
      self:update()
    end
  
    local x  = self.x + self.parent.x
    local y  = self.y + self.parent.y
    local c  = self.c
    local c2 = self.c2
    local fg = {self.fg[1], self.fg[2], self.fg[3], self.fg[4]}
    local bg = {self.bg[1], self.bg[2], self.bg[3], self.bg[4]}  
    
    gfx.set( table.unpack(bg) )
    gfx.circle(x,y,c2+1,1,1)
    gfx.set( table.unpack(fg) )
    gfx.circle(x,y,c,0,1)
    
    if ( self.label ) then
      gfx.setfont(1, "Verdana", 10)
      local w, h = gfx.measurestr(self.label)      
      gfx.x = x - 0.5 * w
      gfx.y = y - 0.35*h
      gfx.drawstr(self.label)
    end
  end
  
  self.checkHit = function( self, x, y )
    local xmi = self.parent.x + self.x - self.c2
    local ymi = self.parent.y + self.y - self.c2
    local xma = xmi    + self.c2*2
    local yma = ymi    + self.c2*2
  
    if ( x > xmi and y > ymi and x < xma and y < yma ) then
      return true
    end
    
    return false
  end
   
  self.checkMouse = function(self, x, y, lx, ly, lastcapture)
    -- Override x and y to work in screen spcae
    local x = gfx.mouse_x
    local y = gfx.mouse_y
    
    local lmb = gfx.mouse_cap & 1
    if ( lmb > 0 ) then lmb = true else lmb = false end

    -- LMB
    if ( lmb ) then  
      if ( self:checkHit( x, y ) and not self.clicking ) then
        self.clicking = 1
        return true
      end
    else
      if ( self.clicking ) then
        if ( self.callback ) then
          self.callback()
        end
        self.clicking = nil
      end
    end
  
    return false
  end
    
  return self
end

dial = {}
function dial.create(parent, x, y, c, c2, getval, setval, disp, fg, bg, default)
  local self   = {}
  self.parent  = parent
  self.x       = x
  self.y       = y
  self.c       = c
  self.c2      = c2
  self.default = default or .5
  self.val     = self.default
  self.bg      = fg or colors.buttonbg
  self.fg      = bg or colors.buttonfg
  self.getval  = getval
  self.setval  = setval
  self.disp    = disp
  self.drawFromCenter = 0
  
  if ( self.getval ) then
    self.val = self.getval()
  end
  
  self.draw = function( self )
    local x  = self.x + self.parent.x
    local y  = self.y + self.parent.y
    local c  = self.c
    local c2 = self.c2
    local fg = {self.fg[1], self.fg[2], self.fg[3], self.fg[4]}
    local bg = {self.bg[1], self.bg[2], self.bg[3], self.bg[4]}  
    
    gfx.set( table.unpack(bg) )
    gfx.circle(x,y,c2+1,1,1)
    gfx.set( table.unpack(fg) )
    gfx.arc(x,y,c,-.75*math.pi,-.75*math.pi+1.5*math.pi, true)
    gfx.arc(x,y,c2,-.75*math.pi-.2,-.75*math.pi+1.5*math.pi+.2, true)
    
    if ( self.drawFromCenter == 1 ) then
      gfx.arc(x,y,c+.5*(c2-c),    0, 1.5*math.pi*(self.val-0.5), false)
      gfx.arc(x,y,c+.5*(c2-c)+.5, 0, 1.5*math.pi*(self.val-0.5), true)    
      gfx.arc(x,y,c+.5*(c2-c)-.5, 0, 1.5*math.pi*(self.val-0.5), true) 
    else
      gfx.arc(x,y,c+.5*(c2-c),-.75*math.pi,-.75*math.pi+1.5*math.pi*(self.val), false)
      gfx.arc(x,y,c+.5*(c2-c)+.5,-.75*math.pi,-.75*math.pi+1.5*math.pi*(self.val), true)    
      gfx.arc(x,y,c+.5*(c2-c)-.5,-.75*math.pi,-.75*math.pi+1.5*math.pi*(self.val), true)    
    end
    
    if ( self.disp ) then
      gfx.setfont(1, "Verdana", 10)
      local str = self.disp(self.val)
      local w, h = gfx.measurestr(str)    
      gfx.x = x - 0.5 * w
      gfx.y = y - 0.35 * h
      gfx.drawstr(str)
      
      if ( self.label ) then
        local w, h = gfx.measurestr(self.label)      
        gfx.x = x - 0.5 * w + 1
        gfx.y = y + c - 0.35*h + 1
        gfx.drawstr(self.label)
      end
    end
  end
  
  self.checkHit = function( self, x, y )
    local xmi = self.parent.x + self.x - self.c2
    local ymi = self.parent.y + self.y - self.c2
    local xma = xmi    + self.c2*2
    local yma = ymi    + self.c2*2
  
    if ( x > xmi and y > ymi and x < xma and y < yma ) then
      return true
    end
    
    return false
  end
   
  self.checkMouse = function(self, x, y, lx, ly, lastcapture, lmb, rmb, mmb)
    -- Override x and y to work in screen space
    local x = gfx.mouse_x
    local y = gfx.mouse_y
    local lmb = gfx.mouse_cap & 1
    if ( lmb > 0 ) then lmb = true else lmb = false end
    local shift = gfx.mouse_cap & 8
    if ( shift > 0 ) then shift = true else shift = false end

    local ctime = reaper.time_precise()

    -- LMB
    if ( lmb ) then
      if ( self == lastcapture ) then
        if ( self.getval ) then
          self.val = self.getval()
        end

        -- Change and clamp value of dial
        local spd = 0.015
        if ( gfx.mouse_cap & 8 > 0 ) then
          spd = spd / 10
        end
        if ( gfx.mouse_cap & 4 > 0 ) then
          spd = spd / 5
        end
        
        self.val = self.val - spd*(y-self.ly)
        if ( self.val > 1 ) then
          self.val = 1
        end
        if ( self.val < 0 ) then
          self.val = 0
        end
        
        if ( self.setval ) then
          self.setval( self.val )
        end
        
        self.lx = x
        self.ly = y
        return true
      end
        
      if ( self:checkHit( x, y ) ) then      
        if ( self.lastlmbdial == false and self.lastTime and (ctime - self.lastTime) < doubleClickInterval ) then
          self.val = self.default
          self.setval( self.val )
        end
        self.lx = x
        self.ly = y
        self.lastTime = ctime
        return true
      end
    end
  
    self.lastlmbdial = lmb
    return false
  end
  
  return self
end

---------------------------------------
-- BOX CTRLS
---------------------------------------
box_ctrls = {}
function box_ctrls.create(viewer, x, y, track, parent)
  local self  = {}
  self.x      = x
  self.y      = y
  self.track  = track
  self.viewer = viewer
  self.color  = { 0.103, 0.103, 0.103, 0.9 }
  self.edge   = { 0.203, 0.23, 0.13, 0.9 }  
  self.parent = parent
  
  self.offsetX  = -20
  self.offsetY  = -20
  self.vW       = 110
  self.vH       = 80
  
  local vW = self.vW
  local vH = self.vH
  self.ctrls = {}
    
  local isMute = function(self)
    local muted = reaper.GetMediaTrackInfo_Value( track, "B_MUTE" ) == 1
    if ( self.parent.parent.isMaster ) then
      local mutesolo = reaper.GetMasterMuteSoloFlags()
      if ( mutesolo & 1 > 0 ) then
        muted = true
      end
    end
    return muted
  end
  
  local isSolo = function(self)
    local solo = reaper.GetMediaTrackInfo_Value( track, "I_SOLO" ) > 0
    if ( self.parent.parent.isMaster ) then
      local mutesolo = reaper.GetMasterMuteSoloFlags()
      if ( mutesolo & 2 > 0 ) then
        solo = true
      end
    end
    return solo
  end
      
  -- Button color updaters for MUTE and SOLO
  local muteUpdate = function(self)
    if ( isMute(self) ) then
      self.fg = colors.muteColor
    else
      self.fg = colors.inactiveColor
    end
  end
  
  local soloUpdate = function(self)
    if ( isSolo(self) ) then
      self.fg = colors.buttonfg
    else
      self.fg = colors.inactiveColor
    end
  end
  
  local hideUpdate = function(self)
    if ( self.parent.parent.hidden == 1 ) then
      self.fg = colors.buttonfg    
    else
      self.fg = colors.inactiveColor
    end
  end  
  
  local killCallback = function()
    self.parent:kill()
  end
  
  local muteCallback = function()
    self.parent:toggleMute()    
  end
  
  local soloCallback = function()
    self.parent:toggleSolo()
  end
  
  local duplicateCallback = function()
    self.parent:duplicate()
  end
  
  local renameCallback = function()
    self.parent:rename()
  end
  
  local hideCallback = function()
    if ( self.parent.hidden == 0 ) then
      self.parent.hidden = 1
      self.parent:deselect()
    else
      self.parent.hidden = 0
    end
    
    self.viewer:storePositions()
  end

  self.ctrls[1] = button.create(self, .2*vW + self.offsetX, .25*vH + self.offsetY, .16*80, .2*80, soloCallback, soloUpdate)
  self.ctrls[1].label = "SOLO"

  self.ctrls[2] = button.create(self, .50*vW + self.offsetX, .25*vH + self.offsetY, .16*80, .2*80, muteCallback, muteUpdate, colors.muteColor)
  self.ctrls[2].label = "MUTE"

  self.ctrls[3] = button.create(self, .8*vW + self.offsetX, .75*vH + self.offsetY, .16*80, .2*80, killCallback)
  self.ctrls[3].label = "DEL"

  self.ctrls[4] = button.create(self, .50*vW + self.offsetX, .75*vH + self.offsetY, .16*80, .2*80, duplicateCallback)
  self.ctrls[4].label = "DUP"
  
  self.ctrls[5] = button.create(self, .2*vW + self.offsetX, .75*vH + self.offsetY, .16*80, .2*80, renameCallback)
  self.ctrls[5].label = "REN"
  
  self.ctrls[6] = button.create(self, .8*vW + self.offsetX, .25*vH + self.offsetY, .16*80, .2*80, hideCallback, hideUpdate)
  self.ctrls[6].label = "HIDE"  
  
  self.draw = function( self )
    local x = self.x
    local y = self.y
    gfx.set( table.unpack(self.color) )
    gfx.rect( x + self.offsetX, y + self.offsetY, self.vW, self.vH )
    gfx.set( table.unpack(self.edge) )
    gfx.line( x + self.offsetX,           y + self.offsetY,           x + self.offsetX + self.vW,  y + self.offsetY )
    gfx.line( x + self.offsetX + self.vW, y + self.offsetY,           x + self.offsetX + self.vW,  y + self.offsetY + self.vH )    
    gfx.line( x + self.offsetX,           y + self.offsetY + self.vH, x + self.offsetX + self.vW,  y + self.offsetY + self.vH )
    gfx.line( x + self.offsetX,           y + self.offsetY,           x + self.offsetX,            y + self.offsetY + self.vH )    
    
    for i,v in pairs(self.ctrls) do
      v:draw()
    end
  end  
  
  self.checkHit = function( self, x, y )
    x = gfx.mouse_x
    y = gfx.mouse_y
    local xmi = self.x + self.offsetX
    local ymi = self.y + self.offsetY
    local xma = xmi + self.vW
    local yma = ymi + self.vH     
  
    if ( x > xmi and y > ymi and x < xma and y < yma ) then
      return true
    end
    
    return false
  end
  
  self.inRange = function(self, x, y, lx, ly, lastcapture, lmb, rmb)
    if ( self.lastCapture ) then
      return true
    end
  
    -- Check to see if the cursor is still inside
    if ( self:checkHit( x, y ) ) then
      return true
    end
    
    return false
  end
  
  self.checkMouse = function(self, x, y, lx, ly, lastcapture, lmb, rmb, mmb)
    local captured = false
    for i,v in pairs(self.ctrls) do
      captured = v:checkMouse(x, y, lx, ly, self.lastCapture, lmb, rmb, mmb)
      if ( captured ) then
        self.lastCapture = v
        break;
      end
    end
    if ( not captured ) then
      self.lastCapture = nil
    end
  end
  
  return self
end


---------------------------------------
-- SINK CTRLS
---------------------------------------
sink_ctrls = {}
function sink_ctrls.create(viewer, x, y, loc)
  local self  = {}
  self.x      = x
  self.y      = y
  self.loc    = loc
  self.viewer = viewer
  self.color  = { 0.103, 0.103, 0.103, 0.9 }
  self.edge   = { 0.203, 0.23, 0.13, 0.9 }  
  
  local withChans = 1
  self.offsetX  = -20
  self.offsetY  = -20
  self.inner    = .16*80
  self.outer    = .2*80
  self.ctrls = {}
 
  -- Setter and getter lambdas
  local setVol, getVol, setPan, getPan, dispVol, dispPan, convertToSend
  if ( loc.sendidx < 0 ) then
    -- Main send
    withChans  = 0
    getVol = function()     return reaper.GetMediaTrackInfo_Value(loc.track, "D_VOL")/2 end
    getPan = function()     return (reaper.GetMediaTrackInfo_Value(loc.track, "D_PAN")+1)*.5 end
    setVol = function(val)  return reaper.SetMediaTrackInfo_Value(loc.track, "D_VOL", val*2) end
    setPan = function(val)  return reaper.SetMediaTrackInfo_Value(loc.track, "D_PAN", val*2-1) end
    if ( not loc.isMaster ) then
      convertToSend = function() self.convertToSend(self) end
    end
  else
    getVol = function()     return reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_VOL")/2 end
    getPan = function()     return (reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_PAN")+1)*.5 end
    setVol = function(val)  return reaper.SetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_VOL", val*2) end
    setPan = function(val)  return reaper.SetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_PAN", val*2-1) end
    
    local NCH = 32
    getTarget = function()  return reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "I_DSTCHAN")/NCH end
    getSource = function()  return reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "I_SRCCHAN")/NCH end    
    dispCh    = function(val) return string.format("%2d/%2d", math.floor(val*NCH)+1, math.floor(val*NCH)+2 ) end
    
    setTarget = function(val) 
      local nTarget = math.floor(val*NCH)
      local ctrack = reaper.GetMediaTrackInfo_Value(loc.dest, "I_NCHAN")
      if ( ctrack < nTarget ) then
        reaper.SetMediaTrackInfo_Value(loc.dest, "I_NCHAN", nTarget)
      end
      reaper.SetTrackSendInfo_Value(loc.source, 0, loc.sendidx, "I_DSTCHAN", nTarget )
    end
    
    setSource = function(val) 
      local nTarget = math.floor(val*NCH)
      local ctrack = reaper.GetMediaTrackInfo_Value(loc.source, "I_NCHAN")
      if ( ctrack < nTarget ) then
        reaper.SetMediaTrackInfo_Value(loc.source, "I_NCHAN", nTarget)
      end
      reaper.SetTrackSendInfo_Value(loc.source, 0, loc.sendidx, "I_SRCCHAN", math.floor(val*NCH) )
    end
  end
  
  dispVol = function(val) return string.format("%.1f",20*math.log(val*2)/math.log(10)) end
  dispPan = function(val) 
    if ( val > 0.501 ) then
      return string.format("%2dR",math.ceil(200*(val-0.5)))
    elseif ( val < 0.499 ) then
      return string.format("%2dL",math.floor(200*(0.5-val)))
    else
      return string.format("C",math.floor(200*(0.5-val)))    
    end
  end
  
  if ( withChans == 1 ) then
    self.vW       = 120
    self.vH       = 80
  else
    self.vW       = 80
    self.vH       = 80  
  end
  
  local vW = self.vW
  local vH = self.vH  
  
  local killCallback = function() self.kill(self) end
  
  if ( withChans == 0 ) then
    self.ctrls[1] = dial.create(self, .25*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, getVol, setVol, dispVol)
    self.ctrls[1].label = "V"
    self.ctrls[2] = dial.create(self, .75*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, getPan, setPan, dispPan)
    self.ctrls[2].label = "P"
    self.ctrls[2].drawFromCenter = 1  
    self.ctrls[3] = button.create(self, .75*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, killCallback)
    self.ctrls[3].label = "DEL"
    if ( not loc.isMaster ) then
      self.ctrls[4] = button.create(self, .25*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, convertToSend)
      self.ctrls[4].label = "SEND"
    end
  else
    self.ctrls[1] = dial.create(self, .2*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, getVol, setVol, dispVol)
    self.ctrls[1].label = "V"
    self.ctrls[2] = dial.create(self, .5*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, getPan, setPan, dispPan)
    self.ctrls[2].label = "P"
    self.ctrls[2].drawFromCenter = 1

    self.ctrls[3] = dial.create(self, .2*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, getSource, setSource, dispCh, nil, nil, 0)
    self.ctrls[3].label = "From"
    self.ctrls[4] = dial.create(self, .5*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, getTarget, setTarget, dispCh, nil, nil, 0)
    self.ctrls[4].label = "To"

    self.ctrls[5] = button.create(self, .8*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, killCallback)
    self.ctrls[5].label = "DEL"
  end
  
  self.convertToSend = function( self )
    reaper.Undo_BeginBlock()
    reaper.SetMediaTrackInfo_Value(loc.track, "B_MAINSEND", 0)
    reaper.CreateTrackSend(loc.track, loc.dest)
    reaper.Undo_EndBlock("Hackey Machines: Convert mainsend to custom send", -1)    
  end  
  
  self.kill = function( self )
    reaper.Undo_BeginBlock()
    if ( loc.sendidx < 0 ) then
      reaper.SetMediaTrackInfo_Value(loc.track, "B_MAINSEND", 0)
    else
      reaper.RemoveTrackSend(loc.track, 0, loc.sendidx)
    end
    reaper.Undo_EndBlock("Hackey Machines: Remove signal cable", -1)
  end
  
  self.draw = function( self )
    local x = self.x
    local y = self.y
    gfx.set( table.unpack(self.color) )
    gfx.rect( x + self.offsetX, y + self.offsetY, self.vW, self.vH )
    gfx.set( table.unpack(self.edge) )
    gfx.line( x + self.offsetX,           y + self.offsetY,           x + self.offsetX + self.vW,  y + self.offsetY )
    gfx.line( x + self.offsetX + self.vW, y + self.offsetY,           x + self.offsetX + self.vW,  y + self.offsetY + self.vH )    
    gfx.line( x + self.offsetX,           y + self.offsetY + self.vH, x + self.offsetX + self.vW,  y + self.offsetY + self.vH )
    gfx.line( x + self.offsetX,           y + self.offsetY,           x + self.offsetX,            y + self.offsetY + self.vH )    
    
    for i,v in pairs(self.ctrls) do
      v:draw()
    end
  end
  
  self.checkHit = function( self, x, y )
    x = gfx.mouse_x
    y = gfx.mouse_y
    local xmi = self.x + self.offsetX
    local ymi = self.y + self.offsetY
    local xma = xmi + self.vW
    local yma = ymi + self.vH     
  
    if ( x > xmi and y > ymi and x < xma and y < yma ) then
      return true
    end
    
    return false
  end
  
  self.inRange = function(self, x, y, lx, ly, lastcapture, lmb, rmb)
    if ( self.lastCapture ) then
      return true
    end
  
    -- Check to see if the cursor is still inside
    if ( self:checkHit( x, y ) ) then
      return true
    end
    
    return false
  end
  
  self.checkMouse = function(self, x, y, lx, ly, lastcapture, lmb, rmb, mmb)
    local captured = false
    if ( self.lastCapture ) then
      captured = self.lastCapture:checkMouse(x, y, lx, ly, self.lastCapture, lmb, rmb, mmb)
    end
    if ( not captured ) then
      for i,v in pairs(self.ctrls) do
        captured = v:checkMouse(x, y, lx, ly, self.lastCapture, lmb, rmb, mmb)
        if ( captured ) then
          self.lastCapture = v
          break;
        end
      end
    end
    if ( not captured ) then
      self.lastCapture = nil
    end
  end
  
  return self
end

-- getTrackTargetIdx
-- This function requires the SWS extensions
local function getSendTargetTrack(track, idx)
  -- local retval, buf = reaper.GetTrackSendName(track, idx, "                                                                                       ")
  -- reaper.GetTrack(0, target)

  -- Requires SWS extensions from: http://www.sws-extension.org
  if reaper.APIExists("BR_GetMediaTrackSendInfo_Track") then
    return reaper.BR_GetMediaTrackSendInfo_Track( track, 0, idx, 1 )
  else
    reaper.ShowMessageBox( "This plugin depends on the SWS extensions", "Error", 0 )
    error("This plugin depends on BR_GetMediaTrackSendInfo_Track in the SWS extensions")
  end
end

---------------------------------------
-- SINK
---------------------------------------
sink = {}

function sink.sinkData(track, idx)
  -- It's a specific send
  local parentGUID = reaper.GetTrackGUID(track)
  local targetTrack
  local isMaster
  if ( idx > - 1 ) then
    --local target      = reaper.GetTrackSendInfo_Value(track, 0, idx, "I_DSTCHAN")
    targetTrack       = getSendTargetTrack( track, idx )
    GUID              = reaper.GetTrackGUID(targetTrack)
    sinkType          = SINKTYPES.SEND
  else
    -- It's a main send of some sort
    targetTrack       = reaper.GetParentTrack(track)
    if ( targetTrack ) then
      GUID            = reaper.GetTrackGUID(targetTrack)
      sinkType        = SINKTYPES.PARENT
    else
      local depth = reaper.GetTrackDepth(track)
      if ( depth == 0 ) then
        GUID          = reaper.GetTrackGUID( reaper.GetMasterTrack(0) )
        isMaster      = 1
        sinkType      = SINKTYPES.MASTER
      end
    end
  end
  
  return {parentGUID=parentGUID, GUID=GUID, source=track, dest=targetTrack, sinkType=sinkType, isMaster=isMaster}, parentGUID..GUID..idx
end
  

function sink.create(viewer, track, idx, sinkData)
  local GUID
  local self          = {}
  self.viewer         = viewer  
  
  self.loc            = {track=track, sendidx=idx, source=sinkData.source, dest=sinkData.dest, isMaster=sinkData.isMaster}
  self.from           = sinkData.parentGUID
  self.GUID           = sinkData.GUID
  self.type           = sinkData.sinkType
  self.color          = colors.connector

  -- Calculate the edges of the triangle between this block and the block this block
  -- is sending to (v).
  self.calcIndicatorPoly = function(self)
    local other = self.viewer:getBlock( self.GUID )  
    local this  = self.viewer:getBlock( self.from )
    local diffx = other.x - this.x
    local diffy = other.y - this.y
    local len = math.sqrt( diffx * diffx + diffy * diffy )
    local alocx = this.x + .5 * diffx
    local alocy = this.y + .5 * diffy
    local nx = 10 * diffx / len
    local ny = 10 * diffy / len
        
    return { 
      { alocx + nx,           alocy + ny },
      { alocx - .5 * nx + ny, alocy - .5 * ny - nx },
      { alocx - .5 * nx - ny, alocy - .5 * ny + nx }
    }
  end  
  
  self.update = function(self)
    self.indicatorPoly  = self:calcIndicatorPoly()
    self.polyCenter     = calcCenter(self.indicatorPoly)
  end
  
  self.draw = function(self)
    if ( hideWires == 1 ) then
      return
    end
  
    gfx.set( table.unpack( self.color ) )
    local other = self.viewer:getBlock( self.GUID )
    local this  = self.viewer:getBlock( self.from )
    
    if ( this.hidden == 0 or (showHidden == 1) ) then
      local indicatorPoly = self.indicatorPoly
      if ( hideWires == 0 ) then
        wgfx.line( indicatorPoly[1][1], indicatorPoly[1][2], indicatorPoly[2][1], indicatorPoly[2][2] )
        wgfx.line( indicatorPoly[2][1], indicatorPoly[2][2], indicatorPoly[3][1], indicatorPoly[3][2] )
        wgfx.line( indicatorPoly[1][1], indicatorPoly[1][2], indicatorPoly[3][1], indicatorPoly[3][2] )
      end

      if ( self.accent or self.ctrls ) then
        wgfx.thickline( this.x, this.y, other.x, other.y, .75, 5, colors.selectionColor )
      else
        if ( hideWires == 0 ) then
          wgfx.line( this.x, this.y, other.x, other.y )
        end
      end
    end
  end
    
  self.drawCtrl = function(self)
    if ( self.ctrls ) then
      self.ctrls:draw()
    end
  end
    
  self.checkHit = function(self, x, y)
    return inTriangle( self.indicatorPoly, {x,y} )
  end
    
  self.checkMouse = function(self, x, y, lx, ly, lastcapture, lmb, rmb, mmb)
    if ( self:checkHit( x, y ) ) then
      self.accent = 1
      machineView.lastOver = self.GUID
      if ( inputs('openSinkControl') or inputs('openSinkControl2') ) then      
        if ( not self.ctrls ) then
          self.ctrls = sink_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.loc )
          return true
        end
      end

      if ( inputs('deleteSink') ) then
        if ( not self.ctrls ) then
          self.ctrls = sink_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.loc )
          self.ctrls:kill()
          return true
        end
      end
    end
    
    return false
  end  
  
  self:update()
  
  return self
end

---------------------------------------------------
-- BLOCK
---------------------------------------------------
block = {}
function block.create(track, x, y, config, viewer)
  local self = {}

  self.viewer = viewer
  self.found = 1
  self.track = track
  self.selectedOpacity = 0
  self.x = x
  self.y = y
  self.hidden = 0
  self.record = 0
  self.renaming = 0
  
  self.loadColors = function(self)
    local FG = { colors.textcolor[1], colors.textcolor[2], colors.textcolor[3], colors.textcolor[4] }
    local BG = { colors.linecolor2[1], colors.linecolor2[2], colors.linecolor2[3], colors.linecolor2[4] }
    
    if ( useColors == 1 ) then
      local col = reaper.GetTrackColor(self.track)
      if ( col > 0.1 ) then
        local o = 0.9        
        local r, g, b = reaper.ColorFromNative(col)
        BG[1] = (r/256)*o + BG[1]*(1-o)
        BG[2] = (g/256)*o + BG[2]*(1-o)
        BG[3] = (b/256)*o + BG[3]*(1-o)
        BG[4] = .8
      end
    end
    
    self.fg = FG
    self.bg = BG
    self.line = colors.linecolor
    self.selectionColor = colors.selectionColor
    self.mutedfg = {FG[1], FG[2], FG[3], .5*FG[4]}
    self.mutedbg = {BG[1], BG[2], BG[3], .7*BG[3]}
  end
  
  self:loadColors()
  self.w = config.blockWidth
  self.h = config.blockHeight
  self.xo = config.muteOrigX
  self.yo = config.muteOrigY
  self.w2 = config.muteWidth
  self.h2 = config.muteHeight
  self.checkMute = block.checkMute
  self.move = block.move
  self.playColor = colors.playColor
  self.GUID = reaper.GetTrackGUID(self.track)
  
  self.select = function(self)
    self.selected = 1
    reaper.SetMediaTrackInfo_Value(self.track, "I_SELECTED", 1)
  end
  self.deselect = function(self)
    self.selected = 0
    reaper.SetMediaTrackInfo_Value(self.track, "I_SELECTED", 0)  
  end  
  
  self.snapToGrid = function()
    dx = config.gridx
    dy = config.gridy
    self.x = math.floor( (self.x-.5*self.w) / dx + .5 ) * dx + .5 * self.w
    self.y = math.floor( (self.y-.5*self.h) / dy + .5 ) * dy + .5 * self.h
  end
  
  self.updateName = function() 
    local name, ret 
    if ( showTrackName == 1 ) then
      ret, str = reaper.GetSetMediaTrackInfo_String(self.track, "P_NAME", "", 0 )
      if ( ret == true ) then
        name = str
      end
      self.name = name
      
      if ( name == "" ) then
        name = nil
      end
    end
    
    if ( not name ) then
      if ( self.renaming == 0 ) then
        ret, name = reaper.TrackFX_GetFXName(track, 0, "")
        if ( ret == true ) then    
          local sc = string.find(name, ":", 1, true)
          if ( sc ) then
            name = name:sub(sc+2, -1)
          end
          local sc = string.find(name, "(", 1, true)
          if ( sc ) then
            name = name:sub(1,sc-2)
          end
          
          -- Check if the name fits the box
          local w, h = gfx.measurestr(name)
          i = #name
          while ( w > self.w ) do
            name = name:sub(1,-2)
            w, h = gfx.measurestr("[("..name..")]")
          end
        
          self.name = name
        else
          self.name = "NO FX"  
        end
      end
    end
    
    if ( self.isMaster ) then
      self.name = "MASTER"
    end
  end
  
  self:updateName()
  
  self.drawCtrls = function()
    if ( self.sinks ) then
      for i,v in pairs( self.sinks ) do
        v:drawCtrl()
      end
    end
    if ( self.ctrls ) then
      self.ctrls:draw()
    end
  end
  
  self.drawConnections = function()
    if ( self.arrow ) then
      wgfx.line( self.x, self.y, self.arrow.X, self.arrow.Y )
      if ( self.arrow.C ) then
        local f = 5
        wgfx.line( self.arrow.X-f, self.arrow.Y-f, self.arrow.X+f, self.arrow.Y+f )
        wgfx.line( self.arrow.X-f, self.arrow.Y+f, self.arrow.X+f, self.arrow.Y-f )        
      end
    end      
    if ( self.sinks ) then
      for i,v in pairs( self.sinks ) do
        v:draw()
      end
    end  
  end  
  
  -- Update signal arrows
  self.updateIndicators = function(self)
    for i,v in pairs( self.sinks ) do
      v:update()
    end
  end
  
  self.data = {}
  self.dataN = 35
  for i=1,self.dataN do
    self.data[i] = 0
    self.dataloc = 0
  end
  
  -- Draw me
  self.draw = function()
    local reaper = reaper
    if ( (self.hidden == 0) or (showHidden == 1) ) then
      local str = self.name
      local muted = reaper.GetMediaTrackInfo_Value( self.track, "B_MUTE" )
      if ( self.isMaster ) then
        local mutesolo = reaper.GetMasterMuteSoloFlags()
        if ( mutesolo & 1 > 0 ) then
          muted = 1
        end
      end
      if ( muted == 1 ) then
        str = "(" .. str .. ")"
      end
      
      local notSolo = reaper.GetMediaTrackInfo_Value( self.track, "I_SOLO" ) == 0
      if ( self.isMaster ) then
        local mutesolo = reaper.GetMasterMuteSoloFlags()
        if ( mutesolo & 2 > 0 ) then
          notSolo = false
        end
      end
      
      local blockedBySolo = ( reaper.AnyTrackSolo(0) ) and notSolo
      if ( blockedBySolo ) then
        str = "[" .. str .. "]"
      end
  
      -- Calculate amplitude
      local peak = 8.6562*math.log(reaper.Track_GetPeakInfo(self.track, 0, 0))
      local noiseFloor = 36
      if ( peak > 0 ) then
        peak = 0;
      elseif ( peak < -noiseFloor ) then
        peak = -noiseFloor
      end
      peak = 1-(peak + noiseFloor)/noiseFloor
      self.playColor[4] = 1-peak
      
      -- Keep circular buffer of signal
      if ( showSignals > 0 ) then      
        self.data[self.dataloc] = peak
        self.dataloc = self.dataloc + 1
        if ( self.dataloc > self.dataN ) then
          self.dataloc = 1
        end
      end
      
      -- Color handling for selection and renaming
      local rnc
      if ( self.renaming == 1 ) then
        rnc = colors.renameColor
      end
      if ( self.selected == 1 ) then
        self.selectedOpacity = self.selectedOpacity + .07
        if ( self.selectedOpacity > .2 ) then
          self.selectedOpacity = .2
        end
      else
        self.selectedOpacity = self.selectedOpacity - .07
        if ( self.selectedOpacity < 0 ) then
          self.selectedOpacity = 0
        end
      end
      
      -- Update recording status
      self.record = reaper.GetMediaTrackInfo_Value( self.track, "I_RECARM" )
      local rec
      if ( self.record == 1 ) then
        rec = colors.renameColor
      end
      if ( self.isMaster == 1 ) then
        rec = self.bg
      end
      
      -- Draw routine
      if ( muted == 1 or blockedBySolo ) then
        box( self.x, self.y, self.w, self.h, str, self.line, self.mutedfg, self.mutedbg, self.xo, self.yo, self.w2, self.h2, showSignals, colors.signalColor, self.data, self.dataloc, self.dataN, rnc, self.hidden, self.selectedOpacity, self.playColor, self.selectionColor, rec )
      else
        box( self.x, self.y, self.w, self.h, self.name, self.line, self.fg, self.bg, self.xo, self.yo, self.w2, self.h2, showSignals, colors.signalColor, self.data, self.dataloc, self.dataN, rnc, self.hidden, self.selectedOpacity, self.playColor, self.selectionColor, rec )
      end
    end
  end
  
  -- Update all the sinks from the REAPER data
  self.updateSinks = function()
    if ( not reaper.ValidatePtr(self.track, "MediaTrack*") ) then
      -- Failure condition
      return -1
    end
        
    local sends = reaper.GetTrackNumSends(self.track, 0)
    if ( not self.sinks ) then
      self.sinks = {}
    end    
    
    for i,v in pairs(self.sinks) do
      v.removeMe = 1
    end
    
    -- Update the sinks only if there have been changes
    local sink = sink
    for i=0,sends-1 do
      local sinkData, GUID = sink.sinkData(self.track, i)
      if ( not self.sinks[GUID] ) then
        self.sinks[GUID] = sink.create(self.viewer, self.track, i, sinkData)
      else
        self.sinks[GUID].removeMe = nil
      end
    end
    local mainSend = reaper.GetMediaTrackInfo_Value(self.track, "B_MAINSEND")
    if ( mainSend == 1 ) then
      local sinkData, GUID = sink.sinkData(self.track, -1)
      if ( not self.sinks[GUID] ) then
        self.sinks[GUID] = sink.create(self.viewer, self.track, -1, sinkData)
      else
        self.sinks[GUID].removeMe = nil
      end
    end
    
    for i,v in pairs(self.sinks) do
      if ( v.removeMe ) then
        self.sinks[i] = nil
      end
    end
  end
  
  self.evaluateSelection = function(self)
    if ( inputs('multiSelect') ) then
      self.selected = 1 - self.selected
      reaper.SetMediaTrackInfo_Value(track, "I_SELECTED", self.selected)
    elseif ( self.selected == 0 ) then
      reaper.SetMediaTrackInfo_Value(reaper.GetMasterTrack(0), "I_SELECTED", 0)            
      reaper.SetOnlyTrackSelected(track)
    end
    self.viewer:updateSelection()
  end
  
  -- Check if the block was clicked
  self.checkHit = function(self, x, y)
    if ( not x or not y ) then
      return false
    end
  
    if ( x > (self.x - .5*self.w) and x < ( self.x + .5*self.w ) ) then
      if ( y > (self.y - .5*self.w) and y < ( self.y + .5*self.h ) ) then
        return true
      end
    end
    return false
  end
  
  self.checkMouse = function(self, x, y, lx, ly, lastcapture, lmb, rmb, mmb)
    if ( (showHidden == 0) and self.hidden == 1 ) then
      return false
    end  
  
    local returnCondition = false
    local doubleClick = 0
    if ( inputs('move') ) then
      -- Were we the last capture?
      if ( self == lastcapture ) then
        if ( inputs('addSink') ) then
          if ( not self.isMaster ) then
            -- Arrow towards somewhere
            self.arrow = {}
            self.arrow.X = x
            self.arrow.Y = y
            if ( inputs('addSinkSecond') ) then
              self.arrow.C = 2
            end
            return true
          end
        end
        
        -- Move the object
        -- This probably needs refactoring
        self.viewer:moveObjects(x - lx, y - ly)
        self.arrow = nil
        return true
      end
      
      if ( self:checkHit( x, y ) ) then
        if ( self:checkMute( x, y ) ) then
          self:toggleMute()
        elseif ( self:checkRec( x, y ) ) then
          self:toggleRec()
        else
          if ( self.lastTime and (reaper.time_precise() - self.lastTime) < doubleClickInterval ) then
            doubleClick = 1
          end
          self.lastTime = reaper.time_precise()
  
          -- Is this the initial click?
          if ( not self.selectChange ) then
            self.selectChange = 1
            self:evaluateSelection()
          end
        end
        
        returnCondition = true
      end
    else    
      if ( self == lastcapture ) then
        -- Were we trying to connect something?
        if ( self.arrow ) then
          -- Check if we are terminating on a block... If so, connect!
          local other = self.viewer:getBlockAt(x, y)
          if ( other ) then
            -- Found block to connect to          
            local otherTrack = other.track
            
            -- This is a sidechain attachment
            if ( inputs('addSinkSecond') ) then
              local newSend = reaper.CreateTrackSend(self.track, otherTrack)
              if ( newSend >= 0 ) then
                reaper.SetTrackSendInfo_Value(self.track, 0, newSend, "I_DSTCHAN", 2)
              end
            else
              -- Check if we are connecting to the master track (mainsend)
              local depth = reaper.GetTrackDepth(self.track)
              if ( otherTrack == reaper.GetMasterTrack(0) ) then
                --print( "Attempt to connect to master" )
                if ( depth == 0 ) then
                  reaper.SetMediaTrackInfo_Value(self.track, "B_MAINSEND", 1)
                else
                  -- This is a difficult case as the only way to send to master is to make the depth 0
                  -- However, this also means that we have to be careful about any other routing that might take place.
                  
                  -- 1. The send to its parent needs to be made explicit if it is present
                  local sendsToParent = reaper.GetMediaTrackInfo_Value(self.track, "B_MAINSEND")
                  if ( sendsToParent == 1 ) then
                    reaper.CreateTrackSend(self.track, reaper.GetParentTrack(self.track))
                  end               
                  
                  -- 2. Find its current index, find closest location with depth = 0 and only select current track
                  local idx = -1;
                  local d0idx = -1;
                  for i=0,reaper.GetNumTracks()-1 do
                    local curTrack = reaper.GetTrack(0, i)
                    local depth = reaper.GetTrackDepth(curTrack)
                    if ( depth == 0 ) then
                      d0idx = i;
                    end
                    if ( self.track == curTrack ) then
                      idx = i;
                      break;
                    end
                  end
                  reaper.SetOnlyTrackSelected(self.track)
                  
                  -- 3. Move the track to a place where the depth = 0               
                  reaper.ReorderSelectedTracks( d0idx, 0 )
                  
                  -- 4. Send to master :)
                  reaper.SetMediaTrackInfo_Value(self.track, "B_MAINSEND", 1)             
                end
              elseif ( otherTrack == reaper.GetParentTrack(self.track) ) then
                -- Check if we are connecting to the parent (mainsend)
                --print( "Attempt to connect to parent" )
                reaper.SetMediaTrackInfo_Value(self.track, "B_MAINSEND", 1)
              else
                -- Other
                -- print( "Attempt to connect other" )
                reaper.CreateTrackSend(self.track, otherTrack)
              end
            end
          else
            -- Did not find block to connect to
          end
          return false
        end
      end
    end   
   
    if ( inputs('openMachineControl', doubleClick) ) then  
      if ( self:checkHit( x, y ) ) then
        if ( not self.ctrls ) then
          self.ctrls = box_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.track, self )
          return true
        end
      end
    end
    
    if ( inputs('deleteMachine', doubleClick) and self:checkHit( x, y ) ) then
      self:kill()
      return;
    end
    
    if ( inputs('mplscript', doubleClick) and self:checkHit( x, y ) ) then -- CTRL
      self.viewer:callScript(altDouble)
    elseif ( inputs('showvst', doubleClick) and self:checkHit( x, y ) ) then -- ALT
      reaper.TrackFX_Show(self.track, 0, 3)
      reaper.TrackFX_SetOpen(self.track, 0, true)                
    elseif ( inputs('hackey', doubleClick) and self:checkHit( x, y ) ) then -- Shift
      -- Start Hackey Trackey
      for i=0,reaper.GetNumTracks()-1 do
        if ( reaper.GetTrack(0, i) == self.track ) then
          reaper.SetProjExtState(0, "MVJV001", "initialiseAtTrack", i)                
        end
      end
      self.viewer:callScript(hackeyTrackey)
    elseif inputs('trackfx', doubleClick) and self:checkHit( x, y ) then
      reaper.TrackFX_SetOpen(self.track, 0, true)    
      reaper.TrackFX_SetOpen(self.track, 0, true)
    end 
   
    -- No capture, release the handle
    self.arrow = nil
    self.selectChange = nil
    return returnCondition
  end
  
  self.kill = function(self)
    if ( self.isMaster ) then
      return
    end
  
    reaper.Undo_BeginBlock()
    -- Remove all connections first
    reaper.SetMediaTrackInfo_Value(self.track, "B_MAINSEND", 0)
    self.viewer:disconnectMe(self.GUID)
    self.viewer:killTrackByGUID(self.GUID)
    reaper.Undo_EndBlock("Hackey Machines: Delete track", -1)
  end
  
  self.killNow = function(self)
    self.viewer:killTrackByGUID(self.GUID)
  end
  
  self.disconnect = function(self)
    self.viewer:disconnectMe(self.GUID)
  end
  
  self.duplicate = function(self)
    reaper.Undo_BeginBlock()
    for i=0,reaper.GetNumTracks()-1 do
      reaper.SetMediaTrackInfo_Value(reaper.GetTrack(0,i), "I_SELECTED", 0)
    end
    reaper.SetMediaTrackInfo_Value(self.track, "I_SELECTED", 1)    
  
    -- Duplicate track
    reaper.Main_OnCommand(40062, 0)
    reaper.Undo_EndBlock("Hackey Machines: Duplicate track", -1)
  end
  
  self.rename = function(self)
    self.viewer:renameMe( self.track )
    self.ctrls = nil
  end
  
  local isMute = function(self)
    local mute = reaper.GetMediaTrackInfo_Value(self.track, "B_MUTE")
    if ( self.isMaster ) then
      local mutesolo = reaper.GetMasterMuteSoloFlags()
      if ( mutesolo & 1 > 0 ) then
        mute = 1
      end
    end
    return mute
  end
  
  local isSolo = function(self)
    local solo = reaper.GetMediaTrackInfo_Value( self.track, "I_SOLO" ) > 0
    if ( self.isMaster ) then
      local mutesolo = reaper.GetMasterMuteSoloFlags()
      if ( mutesolo & 2 > 0 ) then
        solo = 1
      end
    end
    return solo
  end
  
  self.toggleMute = function(self)
    local mute = isMute(self)
    
    if ( mute == 1 ) then
      reaper.SetMediaTrackInfo_Value( self.track, "B_MUTE", 0 )
    else
      reaper.SetMediaTrackInfo_Value( self.track, "B_MUTE", 1 )
      
      -- If it was solo, un-solo!
      if ( isSolo(self) ) then
        reaper.SetMediaTrackInfo_Value( self.track, "I_SOLO", 0 )
      end
    end
  end
  
  self.toggleSolo = function(self)
    local wasSolo = isSolo(self)
    if ( wasSolo ) then
      reaper.SetMediaTrackInfo_Value( self.track, "I_SOLO", 0 )
    else
      -- If solo'd, make sure it is not muted
      reaper.SetMediaTrackInfo_Value( self.track, "B_MUTE", 0 )
      reaper.SetMediaTrackInfo_Value( self.track, "I_SOLO", 1 )
    end
  end
  
  function self.checkMute(self, x, y)
    if ( not x or not y ) then
      return false
    end
  
    local xmi = self.x - .5 * self.w + self.xo
    local xma = self.x - .5 * self.w + self.xo + self.w2
    local ymi = self.y - .5 * self.h + self.yo
    local yma = self.y - .5 * self.h + self.yo + self.h2
    
    if ( x > xmi and x < xma ) then
      if ( y > ymi and y < yma ) then
        return true
      end
    end
    return false
  end
  
  function self.toggleRec(self, x, y)
    local recStatus = reaper.GetMediaTrackInfo_Value(self.track, "I_RECARM")
    reaper.SetMediaTrackInfo_Value(self.track, "I_RECARM", 1-recStatus)
  end
  
  function self.checkRec(self, x, y)
    if ( not x or not y ) then
      return false
    end
    
    local c = recCornerSize
    local xmi = self.x + (0.5-c)*self.w
    local xma = self.x + 0.5*self.w
    local ymi = self.y - 0.5*self.h
    local yma = self.y + (0.5-c-0.5)*self.h
    
    if ( x > xmi and x < xma ) then
      if ( y > ymi and y < yma ) then
        if ( (xma-x) < (yma-y) ) then
          return true
        end
      end
    end
    return false
  end
  
  return self
end

fxlist = {}
function fxlist.create(tab, x, y, name)
  local self = {}  
  self.x = x
  self.y = y
  self.tab = tab
  self.name = name
  
  self.prepTable = function( self, tab )
    gfx.setfont(1, "Verdana", 14)
    local c = 1
    local txts = {}
    local types = {}
    local maxw, w, h
    h = 1
    maxw = 0
    for i,v in pairs( tab ) do
      if type(v) == "table" then
        w, h = gfx.measurestr(v.name__)
        txts[c] = v.name__
        types[c] = i
      elseif i ~= "name__" then
        w, h = gfx.measurestr(v)
        txts[c] = v
        types[c] = 0
      else
        w = 0
        c = c - 1
      end
      if ( w > maxw ) then
        maxw = w
      end
      c = c + 1
    end
    c = c - 1
    
    return txts, types, c, h, maxw
  end
  
  self.txts, self.types, self.c, self.h, self.w = self:prepTable( tab )
    
  self.draw = function()  
    local returnval = 0
    local x = self.x
    local y = self.y
    gfx.x = x
    gfx.y = y
    local w = self.w
    local h = self.h
    local c = self.c
    local txts = self.txts
    local types = self.types
    
    gfx.setfont(1, "Verdana", 14)
    local pad = 3
    local arrowpad = 5
    gfx.set(.7, .7, .7, .9)
    gfx.rect(x-pad, y-pad, w+pad+arrowpad+pad, h*c+pad+pad)
    gfx.set(0, 0, 0, 1.00)
    gfx.line(x-pad, y-pad, x+w+pad+arrowpad, y-pad)
    gfx.line(x-pad, y+h*c+pad, x+w+pad+arrowpad, y+h*c+pad)
    gfx.line(x-pad, y-pad, x-pad, y+h*c+pad)
    gfx.line(x+w+pad+arrowpad, y-pad, x+w+pad+arrowpad, y+h*c+pad)
    
    for i=1,c do
      gfx.x = x
      gfx.drawstr(txts[i])
      if ( types[i] > 0 ) then
        gfx.line( x+w + pad, gfx.y - 3 + 0.5*h + 1, x+w+pad + pad, gfx.y + 0.5*h+1 )
        gfx.line( x+w + pad, gfx.y + 3 + 0.5*h + 1, x+w+pad + pad, gfx.y + 0.5*h+1 )        
      end      
      gfx.y = gfx.y + h
    end
    
    if ( gfx.mouse_x > x ) and ( gfx.mouse_x < ( x+w ) and ( gfx.mouse_y > y ) and ( gfx.mouse_y < (y+c*h) ) ) then
      local i = math.floor((gfx.mouse_y - y) / h) + 1
      
      gfx.set(.2, .2, .2, .4)
      gfx.rect(x-pad, y+(i-1)*h, w+pad+arrowpad+pad, h)
      
      -- It's a table, expand!
      if ( types[i] > 0 ) then
        if ( self.nestedTable and self.nestedTableIdx ~= i) then
          self.nestedTable = nil
        end
        if ( not self.nestedTable ) then
          self.nestedTable = fxlist.create(self.tab[self.types[i]], x+w+pad+arrowpad+pad+2, y+(i-1)*h+pad, self.txts[i])
        end
      else
        if ( self.nestedTable ) then
          self.nestedTable = nil
        end
        if ( ( gfx.mouse_cap & 1 ) > 0 ) then
          return 1, {self.name, txts[i]}, self.x, self.y
        end
      end      
    else
      if ( ( ( gfx.mouse_cap & 1 ) > 0 ) or ( gfx.mouse_cap & 2 ) > 0 and self.hasbeenzero ) then
        returnval = -1
      end
      if ( ( gfx.mouse_cap & 2 ) == 0 ) then
        self.hasbeenzero = 1
      end
    end
    
    if ( self.nestedTable ) then
      local ret, val = self.nestedTable:draw()
      if ( ret > returnval ) then
        returnval = ret
        if ( ret > 0 ) then
          return 1, {self.name, table.unpack(val)}, self.x, self.y
        end
      end
    end
    
    return returnval
  end

  return self
end

function machineView:getBlockAt(x, y)
  for i,v in pairs(self.tracks) do
    if ( v:checkHit(x, y) == true ) then
      return v
    end
  end  
end

function machineView:getBlock( GUID )
  return self.tracks[GUID]
end

function machineView:addTrack(track, x, y)
  local GUID = reaper.GetTrackGUID(track)
  self.tracks[GUID] = block.create(track, x, y, self.config, self)
  return self.tracks[GUID]
end

function machineView:hideMachines()
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      if ( v.hidden == 1 ) then
        v.hidden = 0
      else
        v.hidden = 1
        v:deselect()
      end
    end
  end
  self:updateGUI()
end

function machineView:deleteMachines()
  reaper.Undo_BeginBlock()
  local killList = {}
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      killList[#killList + 1] = v
      v:disconnect()
    end
  end
  for i,v in pairs( killList ) do
    v:killNow()
  end
  
  reaper.Undo_EndBlock("Hackey Machines: Delete multiple tracks", -1)
end

function machineView:setRecordGroup()
  reaper.Undo_BeginBlock()
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      reaper.SetMediaTrackInfo_Value(v.track, "I_RECARM", 1)
    else
      reaper.SetMediaTrackInfo_Value(v.track, "I_RECARM", 0)    
    end
  end
  reaper.Undo_EndBlock("Hackey Machines: Set record group", -1)
end

function machineView:updateMouseState(mx, my)
    self.lx = mx
    self.ly = my
    local lmb = ( gfx.mouse_cap & 1 )
    local rmb = ( gfx.mouse_cap & 2 )
    local mmb = ( gfx.mouse_cap & 64 )
    if ( lmb > 0 ) then self.lmb = true else self.lmb = false end
    if ( rmb > 0 ) then self.rmb = true else self.rmb = false end
    if ( mmb > 0 ) then self.mmb = true else self.mmb = false end    
end

function machineView:invalidate()
  self.valid = false
end

function machineView:renameMe(track)
  showTrackName = 1
  self.renameTrack = track
  self.renameGUID = reaper.GetTrackGUID(track)
  self.oldTrackName = self.tracks[self.renameGUID].name
  local jnk, name = reaper.GetSetMediaTrackInfo_String(track, "P_NAME", self.oldTrackName, 1 )
  self.tracks[self.renameGUID].renaming = 1
end

function machineView:killTrackByGUID( GUID )
  for i = 0,reaper.GetNumTracks()-1 do  
    local ctrk =  reaper.GetTrack(0, i)
    if ( ctrk ) then
      if ( reaper.GetTrackGUID( ctrk ) == GUID ) then
        local depth = reaper.GetMediaTrackInfo_Value(ctrk, "I_FOLDERDEPTH" )
        if ( i > 0 ) then
          local trackup = reaper.GetTrack(0, i-1)
          local oldDepth = reaper.GetMediaTrackInfo_Value(trackup, "I_FOLDERDEPTH")
          reaper.SetMediaTrackInfo_Value(trackup, "I_FOLDERDEPTH", oldDepth + depth)
        end
        reaper.DeleteTrack(ctrk)
        break;
      end
    end
  end
  
  self.tracks[GUID] = nil
end

function machineView:disconnectMe( GUID )
  local ctrk
  for i = 0,reaper.GetNumTracks()-1 do  
    ctrk = reaper.GetTrack(0, i)
    if ( ctrk ) then
      -- We found us
      if ( reaper.GetTrackGUID( ctrk ) == GUID ) then
        while reaper.GetTrackNumSends(ctrk, 0) > 0 do
          reaper.RemoveTrackSend(ctrk, 0, 0)
        end
        while reaper.GetTrackNumSends(ctrk, -1) > 0 do
          reaper.RemoveTrackSend(ctrk, -1, 0)
        end

        -- Check if anyone has this guy as parent. Disconnect them too!
        for j=0,reaper.GetNumTracks()-1 do
          local trk = reaper.GetTrack(0,j)
          local ptrk = reaper.GetParentTrack(trk)
          if ( ptrk ) then
            if ( reaper.GetTrackGUID( ptrk ) == GUID ) then
              reaper.SetMediaTrackInfo_Value(trk, "B_MAINSEND", 0)
            end
          end
        end
        break;
      end
    end
  end
end

function machineView:insertTemplate(val, x, y)
  local v
  local slash = templates.slash
  local ext = templates.extension
  
  if ( val and val[2] ) then
    self:storePositions()  
    local str = reaper.GetResourcePath() .. slash .. 'TrackTemplates'
    for i=3,#val do
      str = str .. slash .. val[i]
    end
    reaper.Main_openProject(str .. templates.extension)
    insX = x;
    insY = y;
    self:loadTracks()
    self:loadPositions()
  end
end

function machineView:insertMachine(machine, x, y)
  local nTracks = reaper.GetNumTracks()
  reaper.InsertTrackAtIndex(nTracks, true)
  local newTrack = reaper.GetTrack(0, nTracks)
  reaper.TrackFX_AddByName(newTrack, machine, false, 1)
  reaper.SetMediaTrackInfo_Value(newTrack, "B_MAINSEND", 0)
  local trackHandle = self:addTrack(newTrack, x, y)
  trackHandle:updateSinks()
end

function machineView:moveObjects( diffx, diffy )
  self.blocksMoving = 1
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      v.x = v.x + diffx
      v.y = v.y + diffy
      v.moved = 1
    end
  end  
  self:invalidate()
  self:storePositions()
end

function machineView:selectMachines()
  if ( ( gfx.mouse_cap & 1 ) > 0 ) then
    self.dragSelect[3] = self.dragSelect[3] + .05
    if ( self.dragSelect[3] > 0.3 ) then
      self.dragSelect[3] = 0.3
    end
    local xmi = self.dragSelect[1]
    local xma = gfx.mouse_x
    local ymi = self.dragSelect[2]
    local yma = gfx.mouse_y
    
    if ( xmi > xma ) then
      local t = xmi
      xmi = xma
      xma = t
    end
    if ( ymi > yma ) then
      local t = ymi
      ymi = yma
      yma = t
    end
        
    gfx.line(xmi, ymi, xma, ymi)
    gfx.line(xmi, yma, xma, yma)
    gfx.line(xmi, ymi, xmi, yma)
    gfx.line(xma, ymi, xma, yma)
        
    local selectionColor = colors.selectionColor
    gfx.set( selectionColor[1], selectionColor[2], selectionColor[3], self.dragSelect[3] )
    gfx.rect(xmi, ymi, xma-xmi, yma-ymi)

    -- Go to world space
    local xmi = (xmi - origin[1]) / zoom
    local xma = (xma - origin[1]) / zoom
    local ymi = (ymi - origin[2]) / zoom
    local yma = (yma - origin[2]) / zoom

    local w = .5*self.config.blockWidth
    local h = .5*self.config.blockHeight
    for i,v in pairs(self.tracks) do
      if ( (v.hidden == 0) or ( showHidden == 1 ) ) then
        pts = { { v.x - w, v.y - h }, 
                { v.x + w, v.y - h }, 
                { v.x + w, v.y + h }, 
                { v.x - w, v.y + h } }
        
        local hit = 0
        for j,p in pairs( pts ) do
          if ( p[1] > xmi and p[2] > ymi and p[1] < xma and p[2] < yma ) then
            hit = 1
          end
        end
        
        if ( hit == 1 ) then
          v:select()
        else
          if ( not inputs('additiveSelect') ) then
            v:deselect()
          end
        end
      end
    end
  else
    self.dragSelect = nil
  end
end

function machineView:updateSelection()
  for i,v in pairs(self.tracks) do
    v.selected = reaper.GetMediaTrackInfo_Value(v.track, "I_SELECTED")
  end
end

function machineView:undo()
  reaper.Undo_DoUndo2(0)
end

function machineView:redo()
  reaper.Undo_DoRedo2(0)
end

function machineView:save()
  reaper.Main_SaveProject(0)
end

function machineView:saveAs()
  reaper.Main_SaveProject(0)
end

function machineView:checkWindowChange()
  local d, x, y, w, h = gfx.dock(-1,1,1,1,1)
  if ( self.config.x ~= x ) or ( self.config.y ~= y )  or ( self.config.width ~= w ) or ( self.config.height ~= h ) or ( self.config.d ~= d ) then
    self.windowChange  = 1
    self.config.x      = x
    self.config.y      = y
    self.config.d      = d
    self.config.width  = w
    self.config.height = h
  elseif ( self.windowChange == 1 ) then
    self.windowChange = 0
    self:storePositions()
  end
end

function machineView:handleZoom(mx, my)
  local dzoom = zoom
  
  local zspd = 1
  if ( gfx.mouse_cap & 4 > 0 ) then
    zspd = zspd / 5
  end
  if ( gfx.mouse_cap & 8 > 0 ) then
    zspd = zspd / 10
  end  
  zoom = zoom + zspd * ( gfx.mouse_wheel / 500 )
  if ( zoom > 2 ) then
    zoom = 2
  elseif ( zoom < 0.4 ) then
    zoom = 0.4
  end
  dzoom = dzoom - zoom
  origin[1] = origin[1] + mx * dzoom
  origin[2] = origin[2] + my * dzoom
  if ( math.abs(dzoom) > 0 ) then
    self:storePositions()
  end
end


function machineView:handleDrag()
--  if ( ( gfx.mouse_cap & 64 ) > 0 ) then
  if ( inputs('drag') ) then
    if ( self.ldragx ) then
      local dx = gfx.mouse_x - self.ldragx
      local dy = gfx.mouse_y - self.ldragy
      origin[1] = origin[1] + dx
      origin[2] = origin[2] + dy
      self:storePositions()
    end
    self.ldragx = gfx.mouse_x
    self.ldragy = gfx.mouse_y
  else
    self.ldragx = nil
  end 
end

function machineView:highlightRecursively(track)
  for i,v in pairs( track.sinks ) do
    if ( not v.accent ) then
      v.accent = 1
      self:highlightRecursively( self.tracks[v.GUID] )
    end
  end
end

function machineView:drawHighlightedSignal(mx, my)
  local over
  if ( hideWires == 0 ) then
    for i,v in pairs( self.tracks ) do
      if v:checkHit( mx, my ) then
        over = v
        break;
      end
    end
    if ( self.lastOver ~= over ) then
      for i,v in pairs(self.tracks) do
        for j,w in pairs(v.sinks) do
          w.accent = nil
        end
      end
      -- Trace the signal
      if ( over ) then
        self:highlightRecursively(over)
      end
    end
  else
    for i,v in pairs(self.tracks) do
      for j,w in pairs(v.sinks) do
        w.accent = nil
      end
    end
    -- Trace the selected ones
    for i,v in pairs(self.tracks) do
      if v.selected == 1 then
        self:highlightRecursively(v)
      end
    end
  end
  self.lastOver = over
end

local function findCommandID(name)
  local commandID
  local lines = {}
  local fn = reaper.GetResourcePath() .. '//' .. "Reaper-kb.ini"
  for line in io.lines(fn) do
    lines[#lines + 1] = line
  end
  
  for i,v in pairs(lines) do
    if ( v:find(name, 1, true) ) then
      local startidx = v:find("RS", 1, true)
      local endidx = v:find(" ", startidx, true)
      commandID = (v:sub(startidx,endidx-1))
    end
  end
  
  if ( commandID ) then
    return "_" .. commandID
  end
end

function machineView:callScript(scriptName)
  if ( not scriptName ) then
    reaper.ShowMessageBox("Error callScript called without specifying a script", "Error", 0)
    return
  end

  local cmdID = findCommandID( scriptName )
  
  if ( cmdID ) then
    local cmd = reaper.NamedCommandLookup( cmdID )
    if ( cmd ) then
      reaper.Main_OnCommand(cmd, 0)
    else
      reaper.ShowMessageBox("Failed to load script "..cmd, "Error", 0)
    end
  end
end

function machineView:quickCmdCalls(commands)
  for i,v in pairs(commands) do
    local cmd = reaper.NamedCommandLookup( v )
      if ( cmd > 0 ) then
        reaper.Main_OnCommand(cmd, 0)
      end
  end
end

function machineView:closeFloatingWindows()
  self:quickCmdCalls( { "_S&M_WNCLS3", "_S&M_WNCLS4" } )
end



-- This variable is set to 1 when blocks are moved by the move routines.
-- It is then set to 2 at the start of the next the cycle.
-- If it 2 by the end of that cycle, we assume the user stopped moving the objects.

------------------------------
-- Main update loop
-----------------------------
SFX = 0
local function updateLoop()  
  local self = machineView
  updateInputs()
  
  -- This variable is set to 1 when blocks are moved by the move routines.
  -- It is then set to 2 at the start of the next the cycle.
  -- If it 2 by the end of that cycle, we assume the user stopped moving the objects.
  if ( self.blocksMoving == 1 ) then
    self.blocksMoving = 2
  end
  
  local ctime = reaper.time_precise()
  local diff = ctime - (self.lastTime or 0)
  doubleClickInterval = doubleClickIntervalTarget + diff
  self.lastTime = ctime
  
  if ( focusRequested() == 1 ) then
    self:focusMe()
  end
  
  self:checkWindowChange()
  
  reaper.PreventUIRefresh(1)
  -- Something serious happened. Maybe the user loaded a new file?
  if ( not pcall( function() self:loadTracks() end ) ) then
    -- Drop all tracks and try again
    self.tracks = {}
    self:initializeTracks()
    self:loadTracks()
  end
  
  -- Nonsensical SFX
  if ( SFX == 1 ) then
    gfx.setimgdim(2, gfx.w, gfx.h)
    gfx.dest = 2
    gfx.mode = 0
    local sc = 0.001
    gfx.x = gfx.w * sc * ( math.random()-0.5 ) + ( math.random() - 0.5 ) * 4
    gfx.y = gfx.h * sc * ( math.random()-0.5 ) + ( math.random() - 0.5 ) * 4
    gfx.blit(2,1+sc,.001) 
    gfx.x = 0 gfx.y = 0
    gfx.blurto(gfx.w, gfx.h)
  end
  
  self:updateGUI()
  
  -- More SFX
  if ( SFX == 1 ) then
    gfx.dest = -1
    gfx.mode = 0
    gfx.blit(2, 1, rotation, 0, 0, gfx.w, gfx.h, 0, 0, gfx.w, gfx.h, rotxoffs, rotyoffs)
  end
  
  reaper.PreventUIRefresh(-1)
  prevChar = lastChar
  lastChar = gfx.getchar()
 
  -- Some machine is being renamed (lock everything control related while this is occurring)
  if ( self.help ) then
    local wcmax = 0
    local wcmax2 = 0
    for i,v in pairs(help) do
      local wc, hc = gfx.measurestr(v[1])
      local wc2, hc = gfx.measurestr(v[2])
      if ( wc > wcmax ) then
        wcmax = wc
      end
      if ( wc2 > wcmax2 ) then
        wcmax2 = wc2
      end
    end

    local X = 50
    local Y = 50
    local wc, hc = gfx.measurestr("c")
    gfx.set(0.75, 0.73, 0.75, 0.6)
    gfx.rect(X-10, Y-10,wcmax+wcmax2+40,hc*#help+20)
    gfx.rect(X-9, Y-9,wcmax+wcmax2+39,hc*#help+19)
    gfx.rect(X-8, Y-8,wcmax+wcmax2+38,hc*#help+18)
    for i,v in pairs(help) do
      gfx.set(0,0,0,1)
      local wc, hc = gfx.measurestr(v[1])
      gfx.x = X + wcmax - wc
      gfx.y = 10+i*hc+20
      gfx.drawstr( v[1], 1, 1 )
      gfx.x = X + wcmax + 20
      gfx.drawstr( v[2], 1, 1 )    
    end
    
    gfx.update()
    reaper.defer(updateLoop)
    if ( lastChar ~= -1 ) then
      if ( gfx.mouse_cap > 0 ) then
        self.help = nil
      end
      if ( lastChar ~= 0 ) then
        self.help = nil
      end
    else
      self:terminate()
    end
  elseif ( self.renameTrack ) then
    if ( lastChar ~= -1 ) then
      -- Renaming pattern
      local jnk, name = reaper.GetSetMediaTrackInfo_String(self.renameTrack, "P_NAME", "", 0 )
      if lastChar == 13 then -- Enter
        self.tracks[self.renameGUID].renaming = 0
        self.renameTrack = nil
        self.tracks[self.renameGUID]:updateName()
      elseif lastChar == 27 then -- Escape
        self.tracks[self.renameGUID].renaming = 0
        reaper.GetSetMediaTrackInfo_String(self.renameTrack, "P_NAME", self.oldTrackName, 1 )
        self.renameTrack = nil
        self.tracks[self.renameGUID]:updateName() 
      elseif lastChar == 8 then -- Backspace
        name = name:sub(1, name:len()-1)
        reaper.GetSetMediaTrackInfo_String(self.renameTrack, "P_NAME", name, 1 )
        self.tracks[self.renameGUID]:updateName()
      else
        if ( pcall( function () string.char(lastChar) end ) ) then
          local str = string.char( lastChar )
          name = string.format( '%s%s', name, str )
          reaper.GetSetMediaTrackInfo_String(self.renameTrack, "P_NAME", name, 1 )
          self.tracks[self.renameGUID]:updateName()          
        end
      end
      gfx.update()
      reaper.defer(updateLoop)
    else
      self:terminate()
    end
  elseif ( self.insertingMachine ) then
    -- We are inserting a machine
    if ( lastChar ~= -1 ) then
      reaper.defer(updateLoop)
      if lastChar == 27 then -- Escape
        self.insertingMachine = nil
        self.FX_list = nil
      end
      
      if ( not self.FX_list ) then
        if ( self.insertingMachine == 1 ) then
          self.FX_list = fxlist.create(builtinFXlist, gfx.mouse_x, gfx.mouse_y)
        else
          self.FX_list = fxlist.create(FXlist, gfx.mouse_x, gfx.mouse_y)
        end
      else
        local ret, val, ix, iy = self.FX_list:draw()
        if ( ret < 0 ) then
          self.insertingMachine = nil
          self.FX_list = nil
        end
        if ( ret > 0 ) then
          self.insertingMachine = nil
          self.FX_list = nil
          if ( val[2] == "Templates" ) then
            self:insertTemplate(val, ix, iy)
          else
            self:insertMachine(val[#val], ix, iy)
          end
        end
      end
      gfx.update()
    end
  elseif ( self.dragSelect ) then
    -- We are dragging an area
    self:selectMachines()
    gfx.update()
    reaper.defer(updateLoop)
  else
    -- Regular window behavior
    if ( not self.valid ) then
      self.valid = true
    end
    
    local mx = ( gfx.mouse_x - origin[1]) / zoom
    local my = ( gfx.mouse_y - origin[2]) / zoom
    
    self:drawHighlightedSignal(mx, my)
        
    -- Prefer last object that was captured
    if ( self.lastCapture ) then
      captured = self.lastCapture:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb )
      self:updateMouseState(mx, my)
      if ( captured == false ) then
        self.lastCapture = nil
      end
    else
      local captured = false    
      for i,v in pairs(self.tracks) do
        -- First check if there is a box control panel open.
        if ( v.ctrls ) then
          inrange = v.ctrls:inRange( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb)
          if ( not inrange ) then
            v.ctrls = nil
          else
            v.ctrls:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb )
            captured = true
            break;
          end
        end
       
        -- Check if there is a sink control panel open
        for j,w in pairs(v.sinks) do
          -- First check if there is a sink control panel open. This has highest capture priority.
          if ( w.ctrls ) then
            inrange = w.ctrls:inRange( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb)
            if ( not inrange ) then
              w.ctrls = nil
            else
              --self.lastCapture = 
              w.ctrls:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb )
              captured = true
              break;
            end
          end
        end
      end
        
      -- Check if a block is clicked
      if ( not captured ) then
        for i,v in pairs(self.tracks) do
          captured = v:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb)
          if ( captured ) then
            self:updateMouseState(mx, my)
            self.lastCapture = v
            break;
          end
        end
      end
      
      if ( not captured ) then
        for i,v in pairs(self.tracks) do
          -- Nothing clicked yet, then consider the arrows/sinks?
          for j,w in pairs(v.sinks) do       
            -- Check if any of the sinks are clicked.
            if ( not captured ) then
              captured = w:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb)
            end
            if ( captured ) then
              --self.lastCapture = w--captured
              captured = true
              break;
            end
          end
          if ( captured ) then
            break;
          end
        end      
      end        
      
      -- Still nothing, then opt for opening the menu or the drag option
      if ( not captured ) then
        if ( ( gfx.mouse_cap & 1 ) > 0 ) then
          self.dragSelect = { gfx.mouse_x, gfx.mouse_y, 0, 0 }
        elseif ( inputs('addMachine') ) then
          if ( gfx.mouse_cap & 8 > 0 ) then
            if ( not builtinFXlist ) then
              builtinFXlist = self:loadBuiltins()
              builtinFXlist = sortTable(builtinFXlist)
              builtinFXlist[#builtinFXlist+1] = FXlist[#FXlist]
              builtinFXlist[#builtinFXlist].name__ = "Templates"
            end          
            self.insertingMachine = 1
          else          
            self.insertingMachine = 2                 
          end
        end
      end
    end
  
    self:handleZoom(mx, my)
    self:handleDrag()
  
    if ( self.iter and self.iter > 0 ) then
      machineView:distribute()
      self.iter = self.iter - 1
      if ( self.iter == 0 ) then
        self:storePositions()
      end
    end
    
    if ( self.iterFree and self.iterFree > 0 ) then
      machineView:distribute(1)
      self.iterFree = self.iterFree - 1
      if ( self.iterFree == 0 ) then
        self:storePositions()
      end      
    end
    
    gfx.update()
    gfx.mouse_wheel = 0
    
    if ( inputs('close') ) then
      local ctime = reaper.time_precise()
      self:closeFloatingWindows()
      if ( ( ctime - (self.lastCloseAttempt or -1000000) ) < doubleClickInterval ) then
        gfx.quit()
        return;
      end
      self.lastCloseAttempt = ctime
    end
    
    -- Maintain the loop until the window is closed or escape is pressed
    if ( lastChar ~= -1 ) then
      reaper.defer(updateLoop)
      
      if ( inputs('delete') ) then
        self:deleteMachines()
      elseif ( inputs('toggleKeymap') ) then
        self.config.keymap = self.config.keymap + 1
        if ( self.config.keymap > self.config.maxkeymap ) then
          self.config.keymap = 0
        end
        local filename = getConfigFn()
        saveCFG(filename, self.config)
        self:printMessage( "Switching to keymap " .. self.config.keymap .. ": " .. keymapNames[self.config.keymap] )
        initializeKeys(self.config.keymap)        
      elseif ( inputs('minzoom') ) then
        zoom = 0.4
      elseif ( inputs('maxzoom') ) then
        zoom = 0.8
      elseif ( inputs('undo') ) then
        self:undo()
      elseif ( inputs('redo') ) then
        self:redo()
      elseif ( inputs('save') )  then
        self:save()
      elseif ( inputs('hideMachines') ) then
        self:printMessage( "Toggle hide machines" )
        self:hideMachines()
      elseif ( inputs('simulate') ) then
        self.iter = 10
      elseif ( inputs('help') ) then
        self.help = 1
      elseif ( inputs('recGroup') ) then
        self:setRecordGroup()
      elseif ( inputs('showSignals') ) then
        showSignals = 1 - showSignals
        if ( showSignals == 1 ) then
          self:printMessage( "Showing signals" )
        else
          self:printMessage( "Not showing signals" )        
        end
        self:storePositions()
      elseif ( inputs('trackNames') ) then
        showTrackName = 1 - showTrackName
        if ( showTrackName == 1 ) then
          self:printMessage( "Showing track names" )
        else
          self:printMessage( "Not showing track names" )        
        end
        machineView:updateNames()
        self:storePositions()
      elseif ( inputs('showHidden') ) then
        showHidden = 1 - showHidden
        if ( showHidden == 1 ) then
          self:printMessage( "Showing hidden machines" )
        else
          self:printMessage( "Hiding hidden machines" )        
        end
        self:storePositions()        
      elseif ( inputs('night') ) then
        night = 1 - night
        if ( night == 1 ) then
          self:loadColors("dark")
        else    
          self:loadColors("default")
        end
        for i,v in pairs(self.tracks) do
          v:loadColors()
        end
        self:storePositions()        
      elseif ( inputs('grid') ) then
        grid = grid + 1
        if ( grid > 2 ) then
          grid = 0
        end
        if ( grid == 1 ) then
          self:printMessage( "Snap to grid active (invisible)" )
        elseif ( grid == 2 ) then
          self:printMessage( "Snap to grid active (visible)" )
        else
          self:printMessage( "Snap to grid inactive" )
        end
      elseif ( inputs('toggleTrackColors') ) then
        useColors = 1 - useColors
        for i,v in pairs(self.tracks) do
          v:loadColors()
        end
        self:storePositions() 
      elseif ( inputs('snapall') ) then
        reaper.Undo_BeginBlock()
        for i,v in pairs(self.tracks) do
          v:snapToGrid()
        end
        self:printMessage( "Snapping all machines to grid" )        
        reaper.Undo_EndBlock("Hackey Machines: Snap to Grid", -1)            
      elseif ( inputs('sfx') ) then
        SFX = 1 - SFX
      elseif ( inputs('hideWires') ) then
        hideWires = hideWires + 1
        if ( hideWires > 2 ) then
          hideWires = 0
        end
        if ( hideWires == 0 ) then
          self:printMessage( "Showing wires" )
        end
        if ( hideWires == 1 ) then
          self:printMessage( "Hiding wires" )
        end
        if ( hideWires == 2 ) then
          self:printMessage( "Showing wires of selected tracks only" )
        end
      elseif ( inputs('customizeMachines') ) then
        launchTextEditor( getFXListFn() )
      end
    else
      self:terminate()
    end
  end
  
  -- User released the block, snappy snappy!
  if ( self.blocksMoving == 2 ) then
    if ( grid > 0 ) then
      for i,v in pairs( self.tracks ) do
        if ( v.moved ) then
          v:snapToGrid()
          v.moved = nil
        end
      end
    end
  end
end

function machineView:terminate()
  self:storePositions()
end

function machineView:updateGridSize()
  if ( self.config.square == 1 ) then
    self.config.gridx = 0.5 * self.config.blockHeight
    self.config.gridy = 0.5 * self.config.blockHeight
  else
    self.config.gridx = 0.5 * self.config.blockWidth
    self.config.gridy = 0.5 * self.config.blockHeight
  end
end

function machineView:updateGUI()
  self:updateGridSize()
  self:drawMessages()

  if ( grid > 1 ) then
    local dX = (zoom*machineView.config.gridx)
    local dY = (zoom*machineView.config.gridy)  
    local nX = gfx.w / dX
    local nY = gfx.h / dY
    
    local c1 = colors.gridColor[1]
    local c2 = colors.gridColor[2]
    local c3 = colors.gridColor[3]
    local c4 = colors.gridColor[4]    
    
    local ox = origin[1] - math.floor((origin[1]/dX))*dX
    local oy = origin[2] - math.floor((origin[2]/dY))*dY

    local t = reaper.time_precise()
    for i=0,nX-1 do
      gfx.set( c1, c2, c3, c4*(.5+math.abs(math.sin(.5*i*dX+t))) )
      gfx.line( i*dX+ox, 0, i*dX+ox, gfx.h )
    end
    for i=0,nY-1 do
      gfx.set( c1, c2, c3, c4*(.5+math.abs(math.sin(.5*i*dX+t))) )    
      gfx.line( 0, i*dY+oy, gfx.w, i*dY+oy )
    end
  end

  for i,v in pairs( self.tracks ) do
    if ( v.sinks ) then
      v:updateIndicators()
    end
    v:drawConnections(self.origin, self.zoom)
  end
  for i,v in pairs( self.tracks ) do
    v:draw(self.origin, self.zoom)
  end
  for i,v in pairs( self.tracks ) do
    v:drawCtrls()  
    if ( v.sinks ) then
      v:drawCtrls()
    end
  end
end

function machineView:updateNames()
  local self = machineView
  
  -- Remove the ones that do not exist anymore
  for i,v in pairs( self.tracks ) do
    v:updateName()
  end
end

function machineView:loadTracks()
  --local self = machineView
  
  -- Flag tracks as not being found yet
  for i,v in pairs( self.tracks ) do
    if ( v.isMaster ) then
    else
      v.found = 0
      v.selected = 0
    end
  end
  
  -- Fetch the tracks
  for i=0,reaper.GetNumTracks()-1 do
    local track = reaper.GetTrack(0, i)
    local GUID = reaper.GetTrackGUID(track)
    if ( GUID ) then
      -- Is this track indexed already?
      if ( self.tracks[GUID] ) then
        self.tracks[GUID].found = 1
      else
        local GUID = reaper.GetTrackGUID(track)
        local x, y = self:loadMachinePosition(GUID)
        
        self:addTrack(track, math.floor(x or (insX or 0) + .1*self.config.width*math.random()), y or (insY or 0) + math.floor(.1*self.config.height*math.random()))
      end
      
      -- Is it selected? Then add it to the selection list
      if ( reaper.GetMediaTrackInfo_Value(track, "I_SELECTED") == 1 ) then
        self.tracks[GUID].selected = 1
      end
    end
  end
  
  -- Remove the ones that do not exist anymore
  for i,v in pairs( self.tracks ) do
    if ( v.found == 0 ) then
      self.tracks[i] = nil
    end
  end
  
  for i,v in pairs( self.tracks ) do
    local ret = v:updateSinks()
    if ( ret and ret == -1 ) then
      error( 'Failed loading tracks during sink update loop' );
    end
  end
end

function machineView:distribute(onlyFree)
  local xl = {}
  local yl = {}
  local first = 1
  for i,v in pairs( self.tracks ) do
    xl[i] = v.x
    yl[i] = v.y    
  end

  local dt = .05
  for c = 1,15 do
    local fx, fy = self:calcForces()
    for i,v in pairs( self.tracks ) do
      if ( not onlyFree or (not v.fromSave) ) then
        local tx = v.x
        local ty = v.y
        v.x = 2 * v.x - xl[i] + fx[i] * dt
        v.y = 2 * v.y - yl[i] + fy[i] * dt
        xl[i] = tx
        yl[i] = ty
      end
    end
  end
end

function machineView:calcForces()
  local w = .5*self.config.blockWidth
  local h = .5*self.config.blockHeight

  local fx = {}
  local fy = {}
  for i,v in pairs( self.tracks ) do
    fx[i] = 0
    fy[i] = 0
  end
  
  local masterGUID = reaper.GetTrackGUID( reaper.GetMasterTrack(0) )
  
  local xx, xy, sx, sy, rx, ry
  local k = 3e-2
  local Q = 5.3e2
  for i,v in pairs( self.tracks ) do
    xx = v.x
    xy = v.y
    
    for j,w in pairs( v.sinks ) do
      sx = self.tracks[w.GUID].x
      sy = self.tracks[w.GUID].y
      
      rx = sx - xx
      ry = sy - xy
      
      -- Spring
      fx[i] = fx[i] + k*rx
      fy[i] = fy[i] + k*ry
      fx[w.GUID] = fx[w.GUID] - k*rx
      fy[w.GUID] = fy[w.GUID] - k*ry
    end
    
    -- Connect to the master, because otherwise unconnected stuff would just float away
    sx = self.tracks[masterGUID].x
    sy = self.tracks[masterGUID].y
    rx = sx - xx
    ry = sy - xy

    if ( #v.sinks == 0 ) then      
      fx[i] = fx[i] + k*rx
      fy[i] = fy[i] + k*ry
      fx[masterGUID] = fx[masterGUID] - k*rx
      fy[masterGUID] = fy[masterGUID] - k*ry
    else
      fx[i] = fx[i] + k*rx
      fy[i] = fy[i] + k*ry
      fx[masterGUID] = fx[masterGUID] + k*rx
      fy[masterGUID] = fy[masterGUID] + k*ry
    end
  end
  
  local QQ = .01 * Q
  for i,v in pairs( self.tracks ) do
    for j,w in pairs( self.tracks ) do
      if ( v ~= w ) then
        xx = v.x
        xy = v.y
        sx = w.x
        sy = w.y
        
        rx = sx - xx
        ry = sy - xy

        local F = Q / ( rx*rx + ry*ry )
        
        fx[i] = fx[i] - F * rx
        fy[i] = fy[i] - F * ry
      end
    end
    if v.x > (gfx.w-w) then
      fx[i] = fx[i] - QQ
    end
    if v.x < w then
      fx[i] = fx[i] + QQ
    end
    if v.y > (gfx.h-h) then
      fy[i] = fy[i] - QQ
    end
    if v.y < h then
      fy[i] = fy[i] + QQ
    end    
  end
  
  -- Don't move things without attachments
  for i,v in pairs( self.tracks ) do
    local c = 0
    for j,w in pairs(v.sinks) do
      c = c + 1
    end
    if ( c == 0 ) then
      fx[i] = 0
      fy[i] = 0
    end
  end

  return fx, fy
end

local function GetFileExtension(str)
  return str:match("^.+(%..+)$")
end

function machineView:dirToTable(dir, slash)
  local structure = {}
  local i = 0
  local subdir = reaper.EnumerateSubdirectories(dir, 0)
  while subdir do
    structure[subdir] = self:dirToTable(dir .. slash .. subdir, slash)
    i = i + 1
    subdir = reaper.EnumerateSubdirectories(dir, i)
  end

  local file = reaper.EnumerateFiles(dir, 0)
  local ext = templates.extension
  local nExt = string.len(ext)
  while file do
    if ( GetFileExtension(file) == ext ) then
      structure[#structure+1] = file:sub(1,-1-nExt)
    end
    file = reaper.EnumerateFiles(dir, i)
    i = i + 1
  end

  return structure
end



local function thirdArg(v)
  local idx = v:find("=", 1, true)
  
  if ( idx ) then
    local pluginFile = v:sub(1,idx-1)
    --local idx2 = v:reverse():find(",", 1, true)
    local idx2 = v:find(",", idx+1, true)
    if ( idx2 ) then
      local idx3 = v:find(",", idx2+1, true)
      if ( idx3 ) then
        local pluginName = v:sub(idx3+1,-1)

        local idx4 = pluginName:find("!!!", 1, true)
        if ( idx4 ) then
          pluginName = pluginName:sub(1,idx4-1)
        end

        return pluginFile, pluginName
      end
    end
  end
end

function machineView:loadTemplates()
  local tpath = reaper.GetResourcePath() .. templates.slash .. 'TrackTemplates'
  
  local templateTable = self:dirToTable(tpath, templates.slash)
  return templateTable
end

function machineView:appendPluginList(fn, list)
  
  local f = io.open(fn, "r")
  if f then
    f:close()
    
    local lines = {}
    for line in io.lines(fn) do
      lines[#lines + 1] = line
    end
    
    if ( lines ) then
      for i,v in pairs(lines) do
        if ( v:sub(1,1) ~= "[" ) then
          local pluginFile, pluginName = thirdArg(v)
          if ( pluginFile ) then
            list[pluginFile] = pluginName
          end
        end
      end
    end
  else
    --reaper.ShowMessageBox( "Could not find plugin ini file:" .. fn, "Error", 0 )
  end
  
  return list, names
end

function machineView:parseFX_ini(fxTable, list, name)
  local fn = reaper.GetResourcePath() .. templates.slash .. name;
  local f = io.open(fn, "r")
  if f then
    f:close()
    
    local lines = {}
    for line in io.lines(fn) do
      lines[#lines + 1] = line
    end
    
    local currentFolder
    for i,v in pairs(lines) do
      if ( v:sub(1,1) == "[" ) then
        currentFolder = v:sub(2,-2)
        if ( not fxTable[currentFolder] ) then
          fxTable[currentFolder] = {}
        end
      else
        local idx = v:find("=", 1, true)
        if ( idx ) then
          local key = v:sub(1,idx-1)
          local value = v:sub(idx+1,-1)
          fxTable[currentFolder][key] = value
        end
      end
    end

    return fxTable
  end
end

function machineView:parseMachineIni(fxTable, list)
  local trafo = {}
  for top,v in pairs(fxTable) do
    local subTable = {}
    local c = 0
    for fname,cat in pairs(v) do
      if ( list[fname] ) then
        if ( not subTable[cat] ) then
          subTable[cat] = {}
        end
        subTable[cat][#subTable[cat]+1] = list[fname]
        c = c + 1
      end
    end
    if ( c > 0 ) then
      trafo[top] = subTable
    end
  end
  
  return trafo
end

function machineView:parseName(name)
  idx = name:reverse():find('/', 1, true) or name:reverse():find('\\', 1, true)
  if ( idx ) then
    name = name:sub(1-idx,-1);
    name = name:gsub('+', '_')
    name = name:gsub(' ', '_')
    name = name:gsub('-', '_')    
  end
  return name
end

function machineView:loadBuiltins()
  local list = {}
  local pluginFiles = { 'reaper-vstplugins64.ini', 'reaper-vstplugins.ini' }
  for i,v in pairs( pluginFiles ) do
    local tpath = reaper.GetResourcePath() .. templates.slash .. v
    list = self:appendPluginList(tpath, list)
  end
  
  local fxTable = {}
  self:parseFX_ini(fxTable, list, 'reaper-fxtags.ini')
  self:parseFX_ini(fxTable, list, 'reaper-fxfolders.ini')  

  local folders = {}
  local folderTable = fxTable["Folders"]
  if ( folderTable ) then
    nFolders = folderTable["NbFolders"]+1
    for i=0,nFolders-1 do
      local name = "Name"..tostring(i)
      local fname = "Folder"..tostring(i)      
      if ( fxTable[fname] and folderTable[name] ) then
        local catName = folderTable[name]
        
        -- Number of items in this folder?
        local nItems = fxTable[fname]["Nb"]
        for i=0,nItems-1 do
          local itemName = "Item"..tostring(i)
          local parsedName = self:parseName( fxTable[fname][itemName] )
          if ( parsedName ) then
            folders[parsedName] = catName
          end
        end
      end
    end
  end
  fxTable["Folders"] = folders
  
  fxTable = self:parseMachineIni(fxTable, list)

  
  return fxTable
end

local function checkOS()
  local rpath = reaper.GetResourcePath()
  if not rpath:find(":\\") then
    isMac = 1
  end
end

function loadCFG(fn, cfg)
    local file = io.open(fn, "r")
    
    if ( file ) then
      io.input(file)
      local str = io.read()
      while ( str ) do
        for k, v in string.gmatch(str, "(%w+)=(%w+)") do
          local no = tonumber(v)
        
          if ( no ) then
            cfg[k] = no
          else
            cfg[k] = v
          end
        end
        str = io.read()
      end
      io.close(file)
    end
    
    return cfg
end

function saveCFG(fn, cfg)
  local file = io.open(fn, "w+")
  
  if ( file ) then
    io.output(file)
    for i,v in pairs(cfg) do
      io.write( string.format('%s=%s\n', i, v) )
    end
    io.close(file)
  end
end

local function Main()
  local self = machineView
  local reaper = reaper
  local ok, v = reaper.SetProjExtState(0, "MVJV001", "requestFocus", tonumber(0))
  checkOS()
  
  if ( isMac ) then
    templates.slash = '/'
  else
    templates.slash = '\\'
  end
  
  local filename = getFXListFn()
  if ( file_exists(filename) == false ) then
    local file = io.open(filename, "w+")
    
    if ( file ) then
      file:write(defaultFile)
      file:close()
    else
      reaper.ShowMessageBox("Failed to write file in script directory. Terminating...", "FATAL ERROR", 0)
    end
  end
  
  if ( not pcall(function() dofile(filename) end) ) then
    reaper.ShowMessageBox(filename .. " contains invalid lua code. Terminating.", "FATAL ERROR", 0)  
    launchTextEditor(filename)
    return;
  end
  
  local filename = getConfigFn()
  self.config = loadCFG(filename, self.config)
  initializeKeys(self.config.keymap)
  
  FXlist = sortTable(FXlist)
  FXlist[#FXlist+1] = sortTable(self:loadTemplates())
  FXlist[#FXlist].name__ = "Templates" 

  self:loadWindowPosition()
  if ( night == 1 ) then
    self:loadColors("dark")
  else    
    self:loadColors("default")
  end
  
  self:initializeTracks()
  
  gfx.init(scriptName, self.config.width, self.config.height, self.config.d, self.config.x, self.config.y)

  reaper.defer(updateLoop)
end

function machineView:initializeTracks()
  local v = self:addTrack(reaper.GetMasterTrack(0), math.floor(.5*self.config.width), math.floor(.5*self.config.height))
  v.isMaster = 1
  v.name = "MASTER"
  self:loadTracks()
  self:loadPositions()
end

function machineView:loadWindowPosition()
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "night")
  if ( ok ) then showN = tonumber( v ) end
  night = showN or night
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "grid")
  if ( ok ) then gridN = tonumber( v ) end
  grid = gridN or grid
  
  local ox, oy, z, showS, showT, showH, gfxw, gfxh, x, y, d
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "ox")
  if ( ok ) then ox = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "oy")
  if ( ok ) then oy = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "zoom")  
  if ( ok ) then z = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "showSignals")  
  if ( ok ) then showS = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "showTrackName")  
  if ( ok ) then showT = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "showHidden")  
  if ( ok ) then showH = tonumber( v ) end      
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "useColors")  
  if ( ok ) then showC = tonumber( v ) end    
  useColors = showC or useColors
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "hideWires")  
  if ( ok ) then hideWires = tonumber( v ) or hideWires end
  
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "gfxw")  
  if ( ok ) then gfxw = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "gfxh")  
  if ( ok ) then gfxh = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "x")  
  if ( ok ) then x = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "y")  
  if ( ok ) then y = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "d")  
  if ( ok ) then d = tonumber( v ) end
  
  origin[1]     = ox or origin[1]
  origin[2]     = oy or origin[2]
  zoom          = z or zoom
  showSignals   = showS or showSignals
  showTrackName = showT or showTrackName
  showHidden    = showH or showHidden  
  
  self.config.x      = x    or self.config.x
  self.config.y      = y    or self.config.y
  self.config.d      = d    or self.config.d
  self.config.width  = gfxw or self.config.width
  self.config.height = gfxh or self.config.height
end

function machineView:storePositions()
  for i,v in pairs(self.tracks) do
    reaper.SetProjExtState(0, "MVJV001", i.."x", tostring(v.x))
    reaper.SetProjExtState(0, "MVJV001", i.."y", tostring(v.y))
    reaper.SetProjExtState(0, "MVJV001", i.."h", tostring(v.hidden))
  end
  
  reaper.SetProjExtState(0, "MVJV001", "ox", tostring(origin[1]))
  reaper.SetProjExtState(0, "MVJV001", "oy", tostring(origin[2]))
  reaper.SetProjExtState(0, "MVJV001", "zoom", tostring(zoom))
  
  -- Store window state
  local d, x, y, w, h = gfx.dock(-1,1,1,1,1)
  reaper.SetProjExtState(0, "MVJV001", "gfxw", tostring(w))
  reaper.SetProjExtState(0, "MVJV001", "gfxh", tostring(h))
  reaper.SetProjExtState(0, "MVJV001", "x", tostring(x))
  reaper.SetProjExtState(0, "MVJV001", "y", tostring(y))
  reaper.SetProjExtState(0, "MVJV001", "d", tostring(d))  
  
  reaper.SetProjExtState(0, "MVJV001", "showSignals", tostring(showSignals))
  reaper.SetProjExtState(0, "MVJV001", "showTrackName", tostring(showTrackName))
  reaper.SetProjExtState(0, "MVJV001", "showHidden", tostring(showHidden))  
  reaper.SetProjExtState(0, "MVJV001", "night", tostring(night))
  reaper.SetProjExtState(0, "MVJV001", "grid", tostring(grid))  
  reaper.SetProjExtState(0, "MVJV001", "useColors", tostring(useColors))
  reaper.SetProjExtState(0, "MVJV001", "hideWires", tostring(hideWires))
end

function machineView:loadMachinePosition(GUID)
  local ok, x = reaper.GetProjExtState(0, "MVJV001", GUID.."x")
  local ok, y = reaper.GetProjExtState(0, "MVJV001", GUID.."y")

  if ( ok ) then
    x = tonumber(x)
    y = tonumber(y)
    local ok, h = reaper.GetProjExtState(0, "MVJV001", GUID.."h")
    if ( ok ) then
      h = tonumber(h)
    end

    return x, y, h or 0
  end
end

function machineView:loadPositions()
  for i,v in pairs(self.tracks) do
    local x, y, h = self:loadMachinePosition(i)
    if ( x ) then
      v.x = x
      v.y = y
      v.hidden = h
      v.fromSave = 1
    end
    
    self.iterFree = 50
  end  
end

Main()

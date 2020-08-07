--[[
@description Hackey-Machines: An interface plugin for REAPER 5.x and up designed to mimick the machine editor in Jeskola Buzz.
@author: Joep Vanlier
@links
  https://github.com/JoepVanlier/Hackey-Machines
@license MIT
@version 0.78
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
 * v0.78 (2020-08-07)
   + Moved night mode to persistent settings.
   + Fix bug that makes mouse disappear after painting.
 * v0.77 (2020-03-26)
   + Fix bug that could be caused by accidentally using a global color similarity index rather than a local copy.
   + Add optional config flag to always defocus the window (named dropfocus, 0 = default).
 * v0.76 (2019-3-11)
   + Allow customization fader range
 * v0.75 (2019-1-21)
   + Gray unselected text
   + Make default gradient much more subtle.
 * v0.74 (2019-1-13)
   + Make sure that signal analysis track doesn't have FX prior to adding the meter.
 * v0.73 (2018-12-19)
   + Added following for the signal analyzer. When performing signal analysis on a send, it will now respond to channel/volume/panning etc.
 * v0.72 (2018-12-19)
   + Added signal analysis buttons (requires analyzer jsfx plugin).
   + TO DO: Refactor sink deletion code which would allow for continuous updating of send vol/pan properties when analyzing signal.
 * v0.71 (2018-12-18)
   + Config file sort and descriptions.
 * v0.70 (2018-12-17)
   + Fix group solo not working in some cases (was caused by broadcast blocking being non-property specific).
   + Added tweaking config setting for gradient alpha.
   + Added wire thickness config setting.
   + CTRL + A
   + Linked multi-hide also from dialog now.
   + Exposed pansize (Positive values scale with UI, negative values keep fixed size. A minimum size can also be specified).
   + Exposed font in config file.
   + Fix bug mutebox rendering (weird colors).
 * v0.69 (2018-12-16)
   + Show small metering in channel control window.
   + Exposed noise floor that is used in metering in config file
 * v0.68 (2018-12-16)
   + Bugfixes VCA handling (nil on master without slaves).
   + Added option to manipulate master volume and panning of tracks with no sends.
 * v0.67 (2018-12-16)
   + First attempt at VCA handling.
 * v0.66 (2018-12-15)
   + Option for shadow alpha and offset (shadowAlpha & shadowOffset).
   + Option for setting text rendering (outline or not). 0 = inverse of bg color, 1 = outlined, 2 = white or black depending on bg color.
   + Added option to control dials by mousewheel.
   + Added option to fix mute button size (muteButtonSize, 0 is autosize, >0 is fixed size).
   + Highlight with light in night mode.
   + Improved look of arrow (solid).
   + Added options to modify alpha transparency of sends/parents (sendAlpha and parentAlpha).
   + Fixed annoying issues with highlighting wires that were under blocks.
   + Added extra penalty spring force between tracks that is driven by color similarity (to improve clustering by color).
   + Added small noise term to avoid local optima when running the force simulation.
   + Improved row sorting for linear layout (attempt to avoid sending signal backwards and attempt to skip more than 1 machine vertically).
   + Option to open configuration file from script (CTRL+F10). Warning: Close the machine view before you save it, or it gets overwritten.
   + Improved visibility signal flow on night theme (green-based highlighting to maintain visibility when using programs such as f.lux).
 * v0.65 (2018-12-8)
   + Rename reaper-kb.
 * v0.64 (2018-12-2)
   + Added toggle to disable colorbar completely.
 * v0.63 (2018-12-1)
   + Modify cursor command seems a bit buggy. Attempt 2
 * v0.62 (2018-12-1)
   + Minor fix clipping.
   + Show wires when hovering over track even in selected track wire mode.
 * v0.61 (2018-12-1)
   + Added palette (lower left corner, outer RMB on top one to select new color).
 * v0.60 (2018-12-1)
   + Fancier selection animation / highlighting.
   + Allow multiport visualization.
 * v0.59 (2018-12-1)
   + Hotfix: Make sure sinks to self are omitted (bugfix for master always coming up).
   + Remove console output mute.
   + Change mute color
 * v0.58 (2018-11-30)
   + Multisolo / mute.
   + Fix click yrange block.
   + Added extra hinting when block is solo'd to make it more clear.
 * v0.57 (2018-11-29)
   + Added undo to undo block movement (CTRL + U), was not possible to make a regular undo point for this sadly. Note that this resets when you reset machine view.
   + Allow clicking along whole line.
   + Constantly update tracks.
 * v0.56 (2018-11-28)
   + Added fit to screen (CTRL + F5).
   + Switched render order messages.
   + Fixed some minor renderbugs.
   + Don't display signal when silent.
   + Changed display behaviour for wire hover in show only wires for selected mode.
 * v0.55 (2018-11-27)
   + Fixed mute clicking region.
   + Fixed mute rapid toggle problem.
   + Show volume of sum of left and right channels rather than just left.
   + Show estimate of the audio panning at bottom of track.   
   + Option to follow last clicked track in TCP.
   + Option to follow last clicked track in Mixer.
 * v0.54 (2018-11-26)
   + Added vertical layout mode (CTRL+F7).
   + Updated FoxAsteria keymap.
 * v0.53 (2018-11-25)
   + Added text outline to help make text more readable.
   + Fix colorbleed.
   + Added outer solo button.
   + Changed wire showing behaviour for mode 3.
   + Don't allow clicking invisible connectors.
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

scriptName = "Hackey Machines v0.77"
altDouble = "MPL Scripts/FX/mpl_WiredChain (background).lua"
hackeyTrackey = "Tracker tools/Tracker/tracker.lua"

machineView = {}
machineView.tracks = {}
machineView.config = {}
machineView.cfgInfo = {}

machineView.specname = "___SIGNAL_ANALYZER___"

machineView.config.analyzerOn       = 1
machineView.cfgInfo.analyzerOn      = "Show analyzer as a context option."
machineView.config.analyzer         = "SaikeMultiSpectralAnalyzer.jsfx"
machineView.cfgInfo.analyzer        = 'JSFX to use for signal analysis.'
machineView.config.blockWidth       = 100
machineView.cfgInfo.blockWidth      = 'Width of machine.'
machineView.config.blockHeight      = 50
machineView.cfgInfo.blockHeight     = 'Height of machine.'
machineView.config.width            = 500
machineView.cfgInfo.width           = 'Default width of UI.'
machineView.config.height           = 500
machineView.cfgInfo.height          = 'Default height of UI.'
machineView.config.x                = 100
machineView.cfgInfo.x               = 'Default x pos of UI.'
machineView.config.y                = 100
machineView.cfgInfo.y               = 'Default y pos of UI.'
machineView.config.d                = 0
machineView.cfgInfo.d               = 'Default dock status of UI.'
machineView.config.square           = 1
machineView.cfgInfo.square          = ''
machineView.config.shadowAlpha      = 0.3
machineView.cfgInfo.shadowAlpha     = 'Alpha level of the drop shadow.'
machineView.config.dropfocus        = 0
machineView.cfgInfo.dropfocus       = 'Automatically drop focus.'
machineView.config.nightMode        = 0
machineView.cfgInfo.nightMode       = 'Default mode (1 = default=night mode, 0 = default is bright mode)'

machineView.config.shadowOffset     = 5
machineView.cfgInfo.shadowOffset    = 'Offset of the drop shadow.'
machineView.config.textOutline      = 2
machineView.cfgInfo.textOutline     = 'Text rendering on machines: 0 = inverse of bg color, 1 = outlined, 2 = white or black depending on bg color.'
machineView.config.textOutlineAlpha = 0.5
machineView.cfgInfo.textOutlineAlpha = 'Alpha level of outline (when used).'
machineView.config.muteButtonSize   = 0
machineView.cfgInfo.muteButtonSize  = 'When set to zero mute sets size automatically. When > 0 it is set to a predefined value.'
machineView.config.sendAlpha        = .4
machineView.cfgInfo.sendAlpha       = 'Alpha level of the send wires.'
machineView.config.parentAlpha      = 1
machineView.cfgInfo.parentAlpha     = 'Alpha level of tracks that send to their parent.'
machineView.config.noiseFloor       = 36
machineView.cfgInfo.noiseFloor      = 'Noise floor in the metering.'
machineView.config.metering         = 1
machineView.cfgInfo.metering        = 'Show VU bars.'
machineView.config.gradientAlpha    = .03
machineView.cfgInfo.gradientAlpha   = 'Alpha level of the gradient upon selection.'
machineView.config.thickWireWidth   = .4
machineView.cfgInfo.thickWireWidth  = 'Highlighted wire thickness.'
machineView.config.panSize          = 11
machineView.cfgInfo.panSize         = 'Negative numbers set fixed pansize, positive numbers set adaptive pansize.'
machineView.config.minPanSize       = 4
machineView.cfgInfo.minPanSize      = 'Minimum size of pan widget.'
machineView.config.machineFont      = "Lucida Grande"
machineView.cfgInfo.machineFont     = 'Machine font.'
machineView.config.muteOrigX        = 0
machineView.cfgInfo.muteOrigX       = 'Origin of the mute button (X).'
machineView.config.muteOrigY        = 0
machineView.cfgInfo.muteOrigY       = 'Origin of the mute button (Y).'
machineView.config.muteWidth        = 25
machineView.cfgInfo.muteWidth       = 'Width of the mute box.'
machineView.config.muteHeight       = 12.5
machineView.cfgInfo.muteHeight      = 'Height of the mute box.'

machineView.config.keymap           = 0
machineView.cfgInfo.keymap          = 'Default keymap'
machineView.config.maxkeymap        = 1
machineView.cfgInfo.maxkeymap       = 'Number of keymaps.'
machineView.config.msgTime          = 2.5
machineView.cfgInfo.msgTime         = 'Time a message stays in console.'
machineView.config.rowSortMethod    = 1
machineView.cfgInfo.rowSortMethod   = 'Row sorting method (do not edit).'

machineView.config.maxVolume        = 2
machineView.cfgInfo.maxVolume       = 'Maximum volume boost factor (2=6dB)'

-- Settings for the linear spacing algorithm
machineView.linearyspacing = 75
machineView.linearyspacingtop = 100
machineView.linearxspacing = 200

messages = {}
templates = {}
templates.slash = '\\'
templates.extension = ".RTrackTemplate"

palette = {}

-- This variable is set to 1 when blocks are moved by the move routines.
-- It is then set to 2 at the start of the next the cycle.
-- If it 2 by the end of that cycle, we assume the user stopped moving the objects.
machineView.blocksMoving = 0
moveTCP = 0
moveMixer = 1
recCornerSize = .2
useColorBar = 1

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
  keys.movetcp            = {        2,    2,    2,    2,     2,     2,      2,      116 }          -- toggle move tcp
  keys.movemixer          = {        2,    2,    2,    2,     2,     2,      2,      109 }          -- toggle move mixer
  keys.delete             = {        2,    2,    2,    2,     0,     0,      0,      6579564.0 }    -- delete machines (del)
  keys.minzoom            = {        2,    2,    2,    2,     0,     0,      0,      1885828464 }   -- minzoom (pgup)
  keys.maxzoom            = {        2,    2,    2,    2,     0,     0,      0,      1885824110 }   -- maxzoom (pgdown)
  keys.close              = {        2,    2,    2,    2,     0,     0,      0,      27 }           -- close windows (esc)
  keys.undo               = {        2,    2,    2,    2,     1,     0,      0,      26 }           -- undo (ctrl + z)
  keys.redo               = {        2,    2,    2,    2,     1,     0,      1,      26 }           -- undo (ctrl + shift + z)
  keys.undomoves          = {        2,    2,    2,    2,     1,     0,      0,      21 }           -- undo moves (ctrl + u)
  keys.save               = {        2,    2,    2,    2,     1,     0,      0,      19 }           -- save (ctrl + s)
  keys.hideMachines       = {        2,    2,    2,    2,     0,     0,      0,      104 }          -- hide machines (h)
  keys.simulate           = {        2,    2,    2,    2,     1,     0,      0,      13 }           -- simulate (return)
  keys.help               = {        2,    2,    2,    2,     0,     0,      0,      26161 }        -- help (F1)
  keys.selectAll          = {        2,    2,    2,    2,     1,     0,      0,      1 }           -- Select all (CTRL + A)
  keys.recGroup           = {        2,    2,    2,    2,     1,     0,      0,      18 }           -- set record group (ctrl + r)
  keys.showSignals        = {        2,    2,    2,    2,     0,     0,      0,      26162 }        -- toggle show signals (F2)
  keys.trackNames         = {        2,    2,    2,    2,     0,     0,      0,      26163 }        -- toggle show track names (F3)
  keys.showHidden         = {        2,    2,    2,    2,     0,     0,      0,      26164 }        -- show hidden machines (F4)
  keys.colorbarToggle     = {        2,    2,    2,    2,     1,     0,      0,      26161 }        -- toggle colorbar off permanently (Ctrl + F1)
  keys.fitMachines        = {        2,    2,    2,    2,     1,     0,      0,      26165 }        -- fit (Ctrl + F5)
  keys.night              = {        2,    2,    2,    2,     0,     0,      0,      26165 }        -- toggle night mode (F5)
  keys.grid               = {        2,    2,    2,    2,     0,     0,      0,      26166 }        -- toggle grid (F6)
  keys.snapall            = {        2,    2,    2,    2,     0,     0,      0,      26167 }        -- snap all to grid (F7)
  keys.linear             = {        2,    2,    2,    2,     1,     0,      0,      26167 }        -- force linear layout (ctrl + F7)
  keys.sfx                = {        2,    2,    2,    2,     0,     0,      0,      26168 }        -- surprise! (F8)
  keys.hideWires          = {        2,    2,    2,    2,     0,     0,      0,      26169 }        -- hide wires (F9)
  keys.customizeMachines  = {        2,    2,    2,    2,     0,     0,      0,      6697264 }      -- customize machine list (F10)
  keys.editConfig         = {        2,    2,    2,    2,     1,     0,      0,      6697264 }      -- customize machine list (Ctrl + F10)
  keys.toggleTrackColors  = {        2,    2,    2,    2,     0,     0,      0,      6697265 }      -- toggle track colors (F11)
  keys.toggleKeymap       = {        2,    2,    2,    2,     0,     0,      0,      6697266 }      -- toggle key map (F12)  
  keys.reverseMod         = {        0,    0,    0,    2,     0,     1,      0,      nil }          -- alt
  keys.forcebig           = {        2,    2,    2,    2,     1,     0,      0,      nil }          -- ctrl
  
  help = {
    {"Shift drag machine", "Connect machines"},    
    {"Left click arrow", "Volume, panning, channel and disconnect controls"},
    {"Alt + hover", "Reverse signal lookup"},
    {"Drag on dial", "Change setting"},
    {"Ctrl + drag on dial", "Change setting (5x slower)"},
    {"Shift + drag on dial", "Change setting (10x slower)"},
    {"Shift + Ctrl + drag on dial", "Change setting (50x slower)"},
    {"Ctrl click machine", "Select multiple machines"},
    {"Right click machine", "Solo, mute, rename, duplicate or remove machine"},
    {"Ctrl + right click on machine", "Open properties with volume and pan control for master send"},
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
    {"T", "Toggle move TCP upon selection"},
    {"M", "Toggle move mixer upon selection"},
    {"F1", "Help"},
    {"Ctrl + F1", "Disable colorbar"},
    {"F2", "Toggle signal visualization"},
    {"F3", "Toggle showing track names versus machine names"},
    {"F4", "Toggle showing hidden machines"},
    {"CTRL + F5", "Fit machines to view"},
    {"F5", "Toggle night mode"},
    {"F6", "Toggle snap to grid (off, on/non-visible, on/visible)"},
    {"F7", "Snap everything to grid"},
    {"Ctrl + F7", "Reset layout to linear layout based on track color"},    
    {"F8", "Weird stuff"},
    {"F9", "Hide wires / Show only wires of selected tracks / Show wires"},  
    {"Ctrl + F10", "Open config file (windows only)"},
    {"F10", "Open FX editing list (windows only)"},
    {"F11", "Toggle use of track colors"},    
    {"F12", "Toggle key layout (0 = default, 1 = RMB drag, MMB insert machine)"},
    {"CTRL + H", "Hide wires"},
    {"CTRL + R", "Set selection to record"},
    {"CTRL + S", "Save"},
    {"CTRL + Z", "Undo"},
    {"CTRL + U", "Undo moves"},
    {"CTRL + SHIFT + Z", "Redo"},
    {"ESCAPE", "Close floating windows"},
    {"DOUBLE ESCAPE", "Close window"},  
  }  
  
  if ( keymap == 1 ) then
    keys.openSinkControl = { 1, 2, 2, 2, 2, 0, 2, nil } -- lmb
    keys.openSinkControl2 = { 2, 1, 2, 2, 2, 0, 2, nil } -- rmb
    keys.deleteSink = { 1, 0, 0, 2, 2, 1, 2, nil } -- alt + lmb
    keys.deleteMachine = { 1, 0, 0, 1, 1, 1, 2, nil } -- ctrl + alt + doubleclick
    keys.sfx = { 2, 2, 2, 2, 0, 0, 0, 26169 } -- surprise! (F9)
    keys.hideWires = { 2, 2, 2, 2, 0, 0, 0, 26168 } -- hide wires (F8)
    keys.toggleTrackColors = { 2, 2, 2, 2, 0, 0, 0, 6697264 } -- toggle track colors (F10)
    keys.customizeMachines = { 2, 2, 2, 2, 0, 0, 0, 6697265 } -- customize machine list (F11)
    keys.toggleKeymap = { 2, 2, 2, 2, 0, 0, 0, 6697266 } -- toggle key map (F12)
    
    keys.addMachine         = {        2,    2,    1,    2,     2,     2,      2,      nil }    -- add machine (mmb)
    keys.drag               = {        2,    1,    2,    2,     2,     2,      2,      nil }    -- drag field of view (rmb)
    
    help = {
      {"Shift drag machine", "Connect machines"},    
      {"Left click arrow", "Volume, panning, channel and disconnect controls"},
      {"Alt + hover", "Reverse signal lookup"},
      {"Drag on dial", "Change setting"},
      {"Ctrl + drag on dial", "Change setting (5x slower)"},
      {"Shift + drag on dial", "Change setting (10x slower)"},
      {"Shift + Ctrl + drag on dial", "Change setting (50x slower)"},
      {"Ctrl click machine", "Select multiple machines"},
      {"Right click machine", "Solo, mute, rename, duplicate or remove machine"},
      {"Right click background", "Insert machine from user menu (F10 to customize)"},
      {"Shift + right click background", "Insert machine from reaper wide categories"},  
      {"Alt + left click", "Delete signal cable or machine"},
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
      {"Ctrl + Alt + Doubleclick", "Delete machine"},
      {"H", "Hide machine"},
      {"T", "Toggle move TCP upon selection"},
      {"M", "Toggle move mixer upon selection"},    
      {"F1", "Help"},
      {"F2", "Toggle signal visualization"},
      {"F3", "Toggle showing track names versus machine names"},
      {"F4", "Toggle showing hidden machines"},
      {"F5", "Toggle night mode"},
      {"F6", "Toggle snap to grid (off, on/non-visible, on/visible)"},
      {"F7", "Snap everything to grid"},
      {"F8", "Hide wires / Show only wires of selected tracks / Show wires"},  
      {"F9", "Weird stuff"},
      {"Ctrl + F10", "Open config file (windows only)"},
      {"F10", "Toggle use of track colors"},
      {"F11", "Open FX editing list (windows only)"},
      {"F12", "Toggle key layout (0 = default, 1 = RMB drag, MMB insert machine)"},
      {"CTRL + H", "Hide wires"},
      {"CTRL + R", "Set selection to record"},
      {"CTRL + S", "Save"},
      {"CTRL + Z", "Undo"},
      {"CTRL + U", "Undo moves"},
      {"CTRL + SHIFT + Z", "Redo"},
      {"Ctrl + F1", "Disable colorbar"},
      {"ESCAPE", "Close floating windows"},
      {"DOUBLE ESCAPE", "Close window"},  
    }
    
  end
end

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
                  return true
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

function palette:init()
  self.colors = {}
  self.sorted = {}
  self.W = 25
  self.H = 12
  self.offsetX = 10
  self.offsetY = 10
  self.proceed = 18
  self.selectedColor = 0
  self.visibility = 1
end

function palette:addToPalette(color)
  self.colors[color] = 1
end

function palette:sort()
  -- Sort the colors table
  local sorted = {}
  for i,v in pairs(self.colors) do
    table.insert(sorted, i)
  end
  table.sort(sorted, function(a,b) return a < b end )
  self.sorted = sorted
end

function palette:draw()
  self:sort()
  local sorted = self.sorted or {}
  
  local dy = self.proceed
  local W = self.W
  local H = self.H
  local xmi = self.offsetX
  local xma = xmi + W
  local yma = gfx.h - self.offsetY
  local ymi = yma - H
    
  for i=1,#sorted do
    local r, g, b = reaper.ColorFromNative(sorted[i])
    r = (r/256)
    g = (g/256)
    b = (b/256)
    gfx.set( r*.4, g*.4, b*.4, self.visibility )
    gfx.rect( xmi-1, ymi-1, W+4, H+4 )
    
    gfx.set( r, g, b, self.visibility )
    gfx.rect( xmi, ymi, W, H )
  
    gfx.set( r*.8+.2, g*.8+.2, b*.8+.2, self.visibility )
    gfx.line(xmi, ymi, xma, ymi)
    gfx.line(xmi, yma, xma, yma)
    gfx.line(xmi, ymi, xmi, yma)
    gfx.line(xma, ymi, xma, yma)
    
    ymi = ymi - dy
    yma = yma - dy
  end
  yma = yma - H
  ymi = ymi - H

  
  gfx.x = xmi-3
  gfx.y = ymi-13
  gfx.set(.5, .5, .5, self.visibility);
  gfx.setfont(6, "Arial", 13)
  gfx.printf("current")
  local r, g, b = reaper.ColorFromNative(self.selectedColor)
  r = (r/256)
  g = (g/256)
  b = (b/256)
  gfx.set( r*.4, g*.4, b*.4, self.visibility )
  gfx.rect( xmi-1, ymi-1, W+4, H+4 )
  
  gfx.set( r, g, b, self.visibility )
  gfx.rect( xmi, ymi, W, H )
  gfx.set( r*.8+.2, g*.8+.2, b*.8+.2, self.visibility )
  gfx.line(xmi, ymi, xma, ymi)
  gfx.line(xmi, yma, xma, yma)
  gfx.line(xmi, ymi, xmi, yma)
  gfx.line(xma, ymi, xma, yma)
  
end

function palette:processMouse(mx, my)
  local sorted = self.sorted
  local dy = self.proceed
  local W = self.W
  local H = self.H
  local xmi = self.offsetX
  local xma = xmi + W
  local yma = gfx.h - self.offsetY
  local ymi = yma - H
  local selectedColor
  local selected = 0
  
  if ( mx < xma ) then
    self.visibility = math.min(1, self.visibility + .5)
  else
    self.visibility = math.max(0, self.visibility * .7)
  end
  for i=1,#sorted do
    if ( mx > xmi and mx < xma and my > ymi and my < yma ) then
      selected = 1
      if ( gfx.mouse_cap & 1 > 0 ) then
        self.selectedColor = sorted[i]
        selected = 2
      end
    end
    ymi = ymi - dy
    yma = yma - dy
  end
  yma = yma - H
  ymi = ymi - H
  if ( mx > xmi and mx < xma and my > ymi and my < yma ) then
    if ( gfx.mouse_cap & 1 > 0 ) then
    selected = 2
    elseif ( gfx.mouse_cap & 2 > 0 ) then
      local retval, color = reaper.GR_SelectColor('')
      if ( retval > 0 ) then
        if ( color ) then
          self.selectedColor = color
        end
        selected = 2
      end
    end
  end

  return selected
end

function machineView:grabAnalyzer()
  local project = 0
  local tracks = reaper.CountTracks(project)
  local spectroTrack
  local exists
  for i=0,tracks-1 do
    local track   = reaper.GetTrack(project, i)    
    local ret, name = reaper.GetTrackName(track, "                                                              ")
    
    if ( name == self.specname ) then
      spectroTrack = track
      exists = 1
    end
  end
  
  -- Create track at the end
  if ( not spectroTrack ) then
    reaper.InsertTrackAtIndex(tracks, false)
    spectroTrack = reaper.GetTrack(project, tracks)
    reaper.GetSetMediaTrackInfo_String(spectroTrack, "P_NAME", self.specname, true)
    reaper.SetMediaTrackInfo_Value(spectroTrack, 'B_MAINSEND', 0) 
    reaper.SetMediaTrackInfo_Value(spectroTrack, "B_SHOWINTCP", 0)
    reaper.SetMediaTrackInfo_Value(spectroTrack, "B_SHOWINMIXER", 0)
  else
    -- Remove existing track sends
    for i=reaper.GetTrackNumSends(spectroTrack, -1)-1, 0, -1 do
      reaper.RemoveTrackSend(spectroTrack, -1, i)
    end
  end  
  
  -- Add spectrum track
  if ( not exists ) then
    local tfx = reaper.TrackFX_AddByName(spectroTrack, self.config.analyzer, 0, -1)
  end
  
  return spectroTrack
end

function machineView:showAnalyzer(track, send)
  local spectroTrack = self:grabAnalyzer()
  local newsend = reaper.CreateTrackSend(track, spectroTrack)
  self.analyzer = {}
  self.analyzer.spectrotrack = spectroTrack
  self.analyzer.spectrosend = newsend
  self.analyzer.terminate = function(self)
    -- Remove existing track sends
    for i=reaper.GetTrackNumSends(self.spectrotrack, -1)-1, 0, -1 do
      reaper.RemoveTrackSend(self.spectrotrack, -1, i)
    end
  end
  
  -- If we are polling a send, then copy those settings
  if ( send ) then
    -- Copy over the send data
    sendFlags = {'B_MONO', 'D_VOL', 'D_PAN', 'D_PANLAW', 'I_SENDMODE', 'I_SRCCHAN'}
    for i,v in pairs(sendFlags) do
      local val = reaper.GetTrackSendInfo_Value(track, 0, send, v)
      reaper.SetTrackSendInfo_Value(track, 0, newsend, v, val)
    end
    self.analyzer.send    = send
    self.analyzer.track   = track
    self.analyzer.nSends  = reaper.GetTrackNumSends(track, 0)
    self.analyzer.update  = function(self)
      -- Analyzer gets killed when this stops returning
      -- When the number of sends changes, we cannot guarantee this sends identity. Therefore, cut the cord, rather than 
      -- give false information.
      if ( reaper.ValidatePtr2(0, self.track, "MediaTrack*") and reaper.GetTrackNumSends(self.track, 0) == self.nSends ) then
        sendFlags = {'B_MONO', 'D_VOL', 'D_PAN', 'D_PANLAW', 'I_SENDMODE', 'I_SRCCHAN'}
        for i,v in pairs(sendFlags) do
          local val = reaper.GetTrackSendInfo_Value(track, 0, self.send, v)
          reaper.SetTrackSendInfo_Value(track, 0, self.spectrosend, v, val)
        end
        return 1
      else
        -- Remove existing track sends
        for i=reaper.GetTrackNumSends(self.spectrotrack, -1)-1, 0, -1 do
          reaper.RemoveTrackSend(self.spectrotrack, -1, i)
        end
      end
    end
  end
  
  reaper.TrackFX_SetOpen(spectroTrack, 0, true)
  reaper.TrackFX_Show(spectroTrack, 0, 0)  
  reaper.TrackFX_Show(spectroTrack, 0, 3)
end

function machineView:printMessage( msg )
  messages[#messages+1] = { self.config.msgTime, msg }
end

function machineView:dbToDisplay( peak )
  local noiseFloor = self.config.noiseFloor
  peak = math.max(-noiseFloor, math.min(0, peak))
  peak = (peak + noiseFloor)/noiseFloor
  
  return peak
end

local function plotVU(peak, x, y, h)
    peak = 8.6562*math.log(peak)
    peak = machineView:dbToDisplay( peak )
    peak = math.floor(peak * h)
    local xc = x
    local yc = y + h
    local dc = 2 / h
    local cc = 0
    for i = 1,peak,2 do
      gfx.set(1, 1-cc, .1*cc, 1)
      gfx.line( xc, yc, xc + 2, yc )
      yc = yc - 2
      cc = cc + dc
    end
end

function machineView:drawMessages(t)
  local fontsize = 20
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
        gfx.set(.2, .2, .2, .9)      
      else
        gfx.set(.8, .8, .8, .9)
      end
      gfx.x = x-1
      gfx.y = y-1
      gfx.drawstr(messages[i][2])
      gfx.x = x-1
      gfx.y = y+1
      gfx.drawstr(messages[i][2])      
      gfx.x = x-1
      gfx.y = y-1
      gfx.drawstr(messages[i][2])
      gfx.x = x+1
      gfx.y = y-1
      gfx.drawstr(messages[i][2])   
      
      if ( night == 1 ) then
        gfx.set(.8, .8, .8, .9)      
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
  colors.hideColor        = { 0.9, 0.7, 0.4, 1.0 }
  if colorScheme == "default" then
    -- Buzz
    colors.textcolor        = {1/256*48, 1/256*48, 1/256*33, 1}
    colors.linecolor        = {1/256*48, 1/256*48, 1/256*33, .5}    
    colors.linecolor2       = {1/256*218, 1/256*214, 1/256*201, 1}
    colors.windowbackground = {1/256*218, 1/256*214, 1/256*201, 1}
    colors.buttonbg         = { 0.1, 0.1, 0.1, .7 }
    colors.buttonfg         = { 0.3, 0.9, 0.4, 1.0 }
    colors.connector        = { .2, .2, .2, 0.8 }   
    colors.wireColor        = { .2, .2, .2, 0.95 }
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
    colors.wireColor        = { .65, .65, .65, 0.95 }
    colors.muteColor        = { 0.9, 0.3, 0.4, 1.0 }
    colors.inactiveColor    = { .6, .6, .6, 1.0 } 
    colors.signalColor      = {37/256,111/256,222/256, 1.0}  
    colors.selectionColor   = {.2, 0.2, .5, 1}  
    colors.selectionColor   = {.4, 0.2, .8, 1}
    colors.renameColor      = { 0.6, 0.3, 0.5, 1.0 }
    colors.playColor        = {0.3, 1.0, 0.4, 1.0}    
    colors.gridColor        = {0.35, 0.25, 0.53, 0.3}
    colors.selectionColor   = {.2, .9, .5, 1} 
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

local function clamp01(x)
  return math.min(1, math.max(0, x))
end

local function box( x, y, w, h, name, fgline, fg, bg, xo, yo, w2, h2, showSignals, fgData, d, loc, N, rnc, hidden, selected, playColor, selectionColor, rec, center, solo )
  local gfx = gfx
  local cfg = machineView.config
  
  local xmi = xtrafo( x - 0.5*w )
  local xma = xtrafo( x + 0.5*w )
  local ymi = ytrafo( y - 0.5*h )
  local yma = ytrafo( y + 0.5*h )
  local w = xma - xmi --zoom * w
  local h = zoom * h

  gfx.set( 0, 0, 0, cfg.shadowAlpha )
  gfx.rect(xmi+cfg.shadowOffset, ymi+cfg.shadowOffset, w, h)

  if ( solo ) then
    gfx.set( table.unpack(playColor) )
    gfx.a = .2
    gfx.rect(xmi-3, ymi-3, w+7, h+7 )
    gfx.rect(xmi-2, ymi-2, w+5, h+5 )
    gfx.rect(xmi-1, ymi-1, w+3, h+3 )
    gfx.rect(xmi-1, ymi-1, w+3, h+3 )      
  end

  gfx.set( 0.0, 0.0, 0.0, 0.95 )
  gfx.rect(xmi, ymi, w+1, h+1 )
    
  gfx.set( table.unpack(bg) )
  gfx.rect(xmi, ymi, w+1, h )

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
    
    if ( center ~= 0.5 ) then
      local xc = xmi + center * w

      local pansize
      local ps = cfg.panSize
      if ( ps > 0 ) then
        pansize = ps * zoom
        if ( pansize < cfg.minPanSize ) then
          pansize = cfg.minPanSize
        end
      else
        pansize = -ps
      end
      gfx.a = 0.7*gfx.a
      gfx.triangle(math.max(xmi-1,xc-pansize), yma, xc, yma-pansize, math.min(xma+1,xc+pansize), yma)
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
  
  gfx.setfont(1, cfg.machineFont, math.floor(19*zoom))
  
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

    local xl = xtrafo(x) - 0.5*w + 3
    local yl = ytrafo(y) - 0.18*h - math.max(0,(lines-1))*0.09*h
    if ( cfg.textOutline == 1 ) then
      if ( fg[1] > 0.5 ) then
        gfx.set( 0, 0, 0, cfg.textOutlineAlpha )
      else
        gfx.set( 1, 1, 1, cfg.textOutlineAlpha )    
      end
      gfx.x = xl
      gfx.y = yl - 1
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
      gfx.x = xl
      gfx.y = yl + 1
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
      gfx.x = xl - 1
      gfx.y = yl
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
      gfx.x = xl + 1
      gfx.y = yl
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
      
      gfx.x = xl - 1
      gfx.y = yl - 1
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
      gfx.x = xl + 1
      gfx.y = yl + 1
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
      gfx.x = xl - 1
      gfx.y = yl + 1
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
      gfx.x = xl + 1
      gfx.y = yl - 1
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
    end
    
    if ( cfg.textOutline == 1 ) then
      gfx.set( table.unpack(fg) )
      gfx.x = xl
      gfx.y = yl
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
    elseif ( cfg.textOutline == 0 ) then
      gfx.set( 1-bg[1], 1-bg[2], 1-bg[3], 1 )
      gfx.x = xl
      gfx.y = yl
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 )
    elseif ( cfg.textOutline == 2 ) then
      local lum = 0.2126*bg[1] + 0.7152*bg[2] + 0.0722*bg[3];
      if ( selected > 0 ) then      
        if ( lum > .5) then
          gfx.set( 0, 0, 0, 1 )
        else
          gfx.set( 1, 1, 1, 1 )
        end
      else
        if (lum>0.5) then
          bias = -.2;
        else
          bias = 0;
        end
        gfx.set( .5 + bias, .5 + bias, .5 + bias, 1 );
      end
        
      gfx.x = xl
      gfx.y = yl
      gfx.drawstr( name, 1, gfx.x+w-4, gfx.y+h-4 ) 
    end
  end

  if ( cfg.muteButtonSize == 0 ) then
    w2 = w2*zoom
    h2 = h2*zoom
  else
    w2 = 2*cfg.muteButtonSize
    h2 = cfg.muteButtonSize
  end
  local xmi2 = xmi + xo
  local xma2 = xmi + xo + w2
  local ymi2 = ymi + yo
  local yma2 = ymi + yo + h2
  gfx.set( table.unpack(playColor) ) 
  gfx.rect(xmi2, ymi2, w2 + 1, h2 + 1 )
  
  --if ( (bg[1]+bg[2]+bg[3])>1.5) then
  --  
  --else
  --  gfx.set( 1, 1, 1, 1 )
  --end
  gfx.set( table.unpack(fgline) )  
  gfx.line(xmi2, yma2, xma2, yma2)
  gfx.line(xma2, ymi2, xma2, yma2)
  
  if ( xmi2 > xmi ) then
    gfx.line(xmi2, ymi2, xmi2, yma2)
  end
  if ( ymi2 > ymi ) then
    gfx.line(xmi2, ymi2, xma2, ymi2)
  end
  
  if ( hidden == 1 ) then
    gfx.set( bg[1]*.8, bg[2]*.8, bg[3]*.8, 0.6 )
    gfx.rect(xmi, ymi, w, h+1 )
  end  
  
  if ( selected > 0 ) then
    local grAlpha = cfg.gradientAlpha
    if ( night == 1 ) then
      gfx.set(clamp01(bg[1]+.25), clamp01(bg[2]+.25), clamp01(bg[3]+.35), grAlpha)
    else
      gfx.set(0, 0, 0, grAlpha)
    end
    local nmax = 8
    local mi1 = xmi + .1 * w
    local mi2 = xmi
    local xxm = 2*xma-1*w
    for i=1,nmax do
      gfx.triangle(xmi, ymi, mi1, ymi, xmi, yma, mi2, yma)
      gfx.triangle(xma, ymi, xxm-mi1, yma, xma, yma, xxm-mi2, ymi)
      mi1 = math.max(xmi,mi1 + 2)
      mi2 = math.max(xmi,mi2 + 2)
    end  
  
    gfx.set( table.unpack( fgData ) )
    xmi = xmi - 2
    ymi = ymi - 2
    xma = xma + 2
    yma = yma + 3
    
    gfx.line(xmi, ymi, xma, ymi)
    gfx.line(xmi, yma, xma, yma)
    gfx.line(xmi, ymi, xmi, yma)
    gfx.line(xma, ymi, xma, yma)
    
    gfx.set( selectionColor[1], selectionColor[2], selectionColor[3], selected )
    gfx.rect(xmi, ymi, w+6, h+6 )
    
    local rt = reaper.time_precise()
    rt = rt - math.floor(rt)
    rt = math.sqrt(rt)
    gfx.set(selectionColor[1], selectionColor[2], selectionColor[3],.7*(1-rt))
    local animPos = 15*rt*zoom + 2
    xmi = xmi - animPos
    xma = xma + animPos
    ymi = ymi - animPos
    yma = yma + animPos
    gfx.line(xmi, ymi, xma, ymi)
    gfx.line(xmi, yma, xma, yma)
    gfx.line(xmi, ymi, xmi, yma)
    gfx.line(xma, ymi, xma, yma)
    
    gfx.set(selectionColor[1], selectionColor[2], selectionColor[3],2*(1-rt))
    gfx.line(xmi, ymi, xmi+5, ymi)
    gfx.line(xmi, ymi, xmi, ymi+5)
    
    gfx.line(xma, ymi, xma-5, ymi)
    gfx.line(xma, ymi, xma, ymi+5)
    
    gfx.line(xmi, yma, xmi+5, yma)
    gfx.line(xmi, yma, xmi, yma-5)
    
    gfx.line(xma, yma, xma-5, yma)
    gfx.line(xma, yma, xma, yma-5)
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

local function dirS(p1, p2, p3)
  return (p1[1] - p3[1]) * (p2[2] - p3[2]) - (p2[1] - p3[1]) * (p1[2] - p3[2])
end

local function inTriangle( triangle, pt )
  local d1, d2, d3
  local has_neg, has_pos

  d1 = dirS(pt, triangle[1], triangle[2])
  d2 = dirS(pt, triangle[2], triangle[3])
  d3 = dirS(pt, triangle[3], triangle[1])

  has_neg = (d1 < 0) or (d2 < 0) or (d3 < 0)
  has_pos = (d1 > 0) or (d2 > 0) or (d3 > 0)

  return not (has_neg and has_pos)
end

local function oldInTriangle( triangle, point )
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
  local invDenom = 1.0 / (dot00 * dot11 - dot01 * dot01);
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

    if ( math.abs(gfx.mouse_wheel) > 0 ) then      
      if ( self:checkHit( x, y ) ) then 
        local spd = 0.00045
        if ( gfx.mouse_cap & 4 > 0 ) then
          spd = spd / 5
        end
        if ( gfx.mouse_cap & 8 > 0 ) then
          spd = spd / 10
        end  
        self.val = self.val + spd*gfx.mouse_wheel
        gfx.mouse_wheel = 0
        return true
      end
    end

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
function box_ctrls.create(viewer, x, y, track, parent, forceBig)
  local self  = {}
  self.x      = x
  self.y      = y
  self.track  = track
  self.viewer = viewer
  self.color  = { 0.103, 0.103, 0.103, 0.9 }
  self.edge   = { 0.203, 0.23, 0.13, 0.9 }  
  self.parent = parent
    
  self.forceBig = forceBig
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
      self.fg = colors.hideColor
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
  
  local signalCallback = function()
    machineView:showAnalyzer(self.parent.track)
  end
  
  local hideCallback = function()  
    if ( self.parent.hidden == 0 ) then
      self.parent.hidden = 1
      if ( self.parent.selected == 1 ) then
        machineView:hideMachines(1)
      end
    else
      self.parent.hidden = 0
      if ( self.parent.selected == 1 ) then
        machineView:hideMachines(0)
      end      
    end
    
    self.viewer:storePositions()
  end

  if ( (self.parent:sinkCount() > 0) and not self.forceBig ) then
    self.vW       = 110
    self.vH       = 80
    local vW      = 110
    local vH      = self.vH
    
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

    if ( machineView.config.analyzerOn == 1 ) then     
      self.ctrls[7] = button.create(self, 1.1*vW + self.offsetX, .25*vH + self.offsetY, .16*80, .2*80, signalCallback)
      self.ctrls[7].label = "SIG"
      self.vW = self.vW + .3 * vW
    end
  else
    self.inner    = .16*80
    self.outer    = .2*80
    self.vW       = 110
    self.vH       = 120
    local vH      = self.vH
    local vW      = self.vW

    local maxVolFactor = machineView.config.maxVolume;

    -- Setter and getter lambdas
    local track   = self.parent.track
    local getVol  = function()     return reaper.GetMediaTrackInfo_Value(track, "D_VOL")/maxVolFactor end
    local getPan  = function()     return (reaper.GetMediaTrackInfo_Value(track, "D_PAN")+1)*.5 end
    local setVol  = function(val)  return reaper.SetMediaTrackInfo_Value(track, "D_VOL", val*maxVolFactor) end
    local setPan  = function(val)  return reaper.SetMediaTrackInfo_Value(track, "D_PAN", val*2-1) end
    local dispVol = function(val)  return string.format("%.1f",20*math.log(val*maxVolFactor)/math.log(10)) end
    local dispPan = function(val) 
      if ( val > 0.501 ) then
        return string.format("%2dR",math.ceil(200*(val-0.5)))
      elseif ( val < 0.499 ) then
        return string.format("%2dL",math.floor(200*(0.5-val)))
      else
        return string.format("C",math.floor(200*(0.5-val)))    
      end
    end
  
    self.ctrls[1] = dial.create(self, .2*vW + self.offsetX, .185*vH + self.offsetY, self.inner, self.outer, getVol, setVol, dispVol, nil, nil, .5/maxVolFactor)
    self.ctrls[1].label = "V"
    self.ctrls[2] = dial.create(self, .55*vW + self.offsetX, .185*vH + self.offsetY, self.inner, self.outer, getPan, setPan, dispPan)
    self.ctrls[2].label = "P"
    self.ctrls[2].drawFromCenter = 1  
  
    self.ctrls[3] = button.create(self, .2*vW + self.offsetX, .52*vH + self.offsetY, .16*80, .2*80, soloCallback, soloUpdate)
    self.ctrls[3].label = "SOLO"
  
    self.ctrls[4] = button.create(self, .50*vW + self.offsetX, .52*vH + self.offsetY, .16*80, .2*80, muteCallback, muteUpdate, colors.muteColor)
    self.ctrls[4].label = "MUTE"
  
    self.ctrls[5] = button.create(self, .8*vW + self.offsetX, .82*vH + self.offsetY, .16*80, .2*80, killCallback)
    self.ctrls[5].label = "DEL"
  
    self.ctrls[6] = button.create(self, .50*vW + self.offsetX, .82*vH + self.offsetY, .16*80, .2*80, duplicateCallback)
    self.ctrls[6].label = "DUP"
    
    self.ctrls[7] = button.create(self, .2*vW + self.offsetX, .82*vH + self.offsetY, .16*80, .2*80, renameCallback)
    self.ctrls[7].label = "REN"
    
    self.ctrls[8] = button.create(self, .8*vW + self.offsetX, .52*vH + self.offsetY, .16*80, .2*80, hideCallback, hideUpdate)
    self.ctrls[8].label = "HIDE"  
  end
  
  self.draw = function( self )
    local x = self.x
    local y = self.y
    local offsetX = self.offsetX
    local offsetY = self.offsetY
    local xc = self.x + offsetX
    local yc = self.y + offsetY
    local vW = self.vW
    local vH = self.vH
    local xe = xc + vW
    local ye = yc + vH
    gfx.set( table.unpack(self.color) )
    gfx.rect( x + self.offsetX, y + self.offsetY, self.vW, self.vH )
    gfx.set( table.unpack(self.edge) )
    gfx.line( xc, yc, xe, yc )
    gfx.line( xe, yc, xe, ye )    
    gfx.line( xc, ye, xe, ye )
    gfx.line( xc, yc, xc, ye )    
    
    for i,v in pairs(self.ctrls) do
      v:draw()
    end    
    
    -- METERING
    if ( machineView.config.metering == 1 ) then
      local peakleft = reaper.Track_GetPeakInfo(self.track, 0)
      local peakright = reaper.Track_GetPeakInfo(self.track, 1)
      
      local pW = 10
      gfx.set( table.unpack(self.color) )
      xc = xc + vW
      gfx.rect( xc + 1, y + self.offsetY, 12, self.vH )
      gfx.set( table.unpack(self.edge) )
      gfx.line( xc,           yc,           xc + pW,  yc )
      gfx.line( xc + pW,      yc,           xc + pW,  ye )    
      gfx.line( xc,           ye,           xc + pW,  ye )
      gfx.line( xc,           yc,           xc,       ye )  
      
      plotVU(peakleft,  x + offsetX + vW + 2, y + offsetY + 2, vH-4)
      plotVU(peakright, x + offsetX + vW + 6, y + offsetY + 2, vH-4)
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
function sink_ctrls.create(parent, viewer, x, y, loc)
  local self  = {}
  self.x      = x
  self.y      = y
  self.loc    = loc
  self.viewer = viewer
  self.parent = parent
  self.color  = { 0.103, 0.103, 0.103, 0.9 }
  self.edge   = { 0.203, 0.23, 0.13, 0.9 }  
  
  local withChans = 1
  self.offsetX  = -20
  self.offsetY  = -20
  self.inner    = .16*80
  self.outer    = .2*80
  self.ctrls = {}
  
  local maxVolFactor = machineView.config.maxVolume;
 
  -- Setter and getter lambdas
  local setVol, getVol, setPan, getPan, dispVol, dispPan, convertToSend
  local signalCallback = function () self.parent:analyzeSignal() end
  if ( loc.sendidx < 0 ) then
    -- Main send
    withChans  = 0
    getVol = function()     return reaper.GetMediaTrackInfo_Value(loc.track, "D_VOL")/maxVolFactor end
    getPan = function()     return (reaper.GetMediaTrackInfo_Value(loc.track, "D_PAN")+1)*.5 end
    setVol = function(val)  return reaper.SetMediaTrackInfo_Value(loc.track, "D_VOL", val*maxVolFactor) end
    setPan = function(val)  return reaper.SetMediaTrackInfo_Value(loc.track, "D_PAN", val*2-1) end
 if ( not loc.isMaster ) then
      convertToSend = function() self.convertToSend(self) end
    end
  else
    getVol = function()     return reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_VOL")/maxVolFactor end
    getPan = function()     return (reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_PAN")+1)*.5 end
    setVol = function(val)  return reaper.SetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_VOL", val*maxVolFactor) end
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
  
  dispVol = function(val) return string.format("%.1f",20*math.log(val*maxVolFactor)/math.log(10)) end
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
  
  local killCallback = function() self.parent:kill() end
  if ( withChans == 0 ) then
    self.ctrls[1] = dial.create(self, .25*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, getVol, setVol, dispVol, nil, nil, 1/maxVolFactor)
    self.ctrls[1].label = "V"
    self.ctrls[2] = dial.create(self, .75*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, getPan, setPan, dispPan)
    self.ctrls[2].label = "P"
    self.ctrls[2].drawFromCenter = 1  
    self.ctrls[3] = button.create(self, .75*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, killCallback)
    self.ctrls[3].label = "DEL"
    if ( not loc.isMaster ) then
      self.ctrls[4] = button.create(self, .25*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, convertToSend)
      self.ctrls[4].label = "SEND"
      if ( machineView.config.analyzerOn == 1 ) then
        self.ctrls[5] = button.create(self, .75*vW + 40 + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, signalCallback)
        self.ctrls[5].label = "SIG"
        self.vW = self.vW + 40
      end
    elseif (machineView.config.analyzerOn == 1) then
      self.ctrls[4] = button.create(self, .25*vW + self.offsetX, .75*vH + self.offsetY, self.inner, self.outer, signalCallback)
      self.ctrls[4].label = "SIG"
    end
  else
    self.ctrls[1] = dial.create(self, .2*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, getVol, setVol, dispVol, nil, nil, 1/maxVolFactor)
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
    
    if ( machineView.config.analyzerOn == 1 ) then
      self.ctrls[6] = button.create(self, .8*vW + self.offsetX, .25*vH + self.offsetY, self.inner, self.outer, signalCallback)
      self.ctrls[6].label = "SIG"
    end
  end
  
  self.convertToSend = function( self )
    reaper.Undo_BeginBlock()
    reaper.SetMediaTrackInfo_Value(loc.track, "B_MAINSEND", 0)
    reaper.CreateTrackSend(loc.track, loc.dest)
    reaper.Undo_EndBlock("Hackey Machines: Convert mainsend to custom send", -1)    
  end   
  
  self.draw = function( self )
    local x = self.x
    local y = self.y
    local vW = self.vW
    local vH = self.vH
    local offsetX = self.offsetX
    local offsetY = self.offsetY
    local xc = x + offsetX
    local yc = y + offsetY
    local xe = xc + vW
    local ye = yc + vH
    gfx.set( table.unpack(self.color) )
    gfx.rect( x + self.offsetX, y + self.offsetY, self.vW, self.vH )
    gfx.set( table.unpack(self.edge) )
    gfx.line( xc, yc, xe, yc )
    gfx.line( xe, yc, xe, ye )    
    gfx.line( xc, ye, xe, ye )
    gfx.line( xc, yc, xc, ye )    
    
    for i,v in pairs(self.ctrls) do
      v:draw()
    end
    
    -- METERING
    if ( machineView.config.metering == 1 ) then
      local peakleft = reaper.Track_GetPeakInfo(loc.track, 0)
      local peakright = reaper.Track_GetPeakInfo(loc.track, 1)
      
      local vol, pan
      if ( loc.sendidx < 0 ) then
        -- Already taken into account in the peak info in this case!
        vol = 1 --reaper.GetMediaTrackInfo_Value(loc.track, "D_VOL")
        pan = 0  --reaper.GetMediaTrackInfo_Value(loc.track, "D_PAN")
      else
        vol = reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_VOL")
        pan = reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_PAN")
      end
      
      local pW = 10
      gfx.set( table.unpack(self.color) )
      gfx.rect( x + self.offsetX + vW + 1, y + self.offsetY, 12, self.vH )
      local xc = x + offsetX + vW
      local yc = y + offsetY
      gfx.set( table.unpack(self.edge) )
      gfx.line( xc,      yc, xc + pW, yc )
      gfx.line( xc + pW, yc, xc + pW, ye )    
      gfx.line( xc,      ye, xc + pW, ye )
      gfx.line( xc,      yc, xc,      ye )  
      
      local hp = .5*(pan+1);
      plotVU(peakleft  * vol * (1-hp),  x + offsetX + vW + 2, y + offsetY + 2, vH-4)
      plotVU(peakright * vol * hp, x + offsetX + vW + 6, y + offsetY + 2, vH-4)
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
  

function sink.create(viewer, track, idx, sinkData, offset)
  local GUID
  local self          = {}
  self.viewer         = viewer  
  
  self.loc            = {track=track, sendidx=idx, source=sinkData.source, dest=sinkData.dest, isMaster=sinkData.isMaster}
  self.from           = sinkData.parentGUID
  self.GUID           = sinkData.GUID
  self.type           = sinkData.sinkType
  self.color          = colors.connector
  self.offset         = offset

  -- Calculate the edges of the triangle between this block and the block this block
  -- is sending to (v).
  self.calcIndicatorPoly = function(self)
    local other = self.viewer:getBlock( self.GUID )
    local this  = self.viewer:getBlock( self.from )
    other       = { x = other.x, y = other.y, hidden = other.hidden }
    this        = { x = this.x, y = this.y, hidden = this.hidden }
    local diffx = other.x - this.x
    local diffy = other.y - this.y
    local len   = math.sqrt( diffx * diffx + diffy * diffy )
    local nx    = 10 * diffx / len
    local ny    = 10 * diffy / len
    
    this.x      = this.x - offset * ny
    this.y      = this.y + offset * nx
    other.x     = other.x - offset * ny
    other.y     = other.y + offset * nx
    self.this   = this
    self.other  = other
    
    local alocx = this.x + .5 * diffx
    local alocy = this.y + .5 * diffy
    
    local snx   = -.5*ny
    local sny   = .5*nx
    local x1    = this.x - snx
    local y1    = this.y - sny
    local x2    = this.x + snx
    local y2    = this.y + sny
    local x3    = other.x - snx
    local y3    = other.y - sny
    local x4    = other.x + snx
    local y4    = other.y + sny
        
    return { 
      { alocx + nx,           alocy + ny },
      { alocx - .5 * nx + ny, alocy - .5 * ny - nx },
      { alocx - .5 * nx - ny, alocy - .5 * ny + nx },
      { alocx - .5 * nx, alocy - .5 * ny }
    }, { 
      { x1, y1 },
      { x3, y3 },
      { x2, y2 }
    }, { 
      { x4, y4 },
      { x1, y1 },
      { x3, y3 }
    }
  end   
  
  self.getSourceGUID = function(self)
    return self.from
  end
  
  self.getTargetGUID = function(self)
    return self.GUID
  end
  
  self.update = function(self)
    self.indicatorPoly, self.linePoly1, self.linePoly2  = self:calcIndicatorPoly()
    self.polyCenter                                     = calcCenter(self.indicatorPoly)
  end
  
  self.arrowVisible = function(self)
    return hideWires == 0 or ( hideWires == 2 and self.accent )
  end
  
  self.draw = function(self)
    local cfg = machineView.config
    if ( hideWires == 1 ) then
      return
    end
  
    local wireColor = colors.wireColor
    gfx.set( table.unpack( wireColor ) )
    local other = self.other
    local this  = self.this
    
    local alpha = wireColor[4]
    if ( self.type == 1 ) then
       alpha = cfg.sendAlpha * wireColor[4]
    elseif ( self.type == 2 ) then
       alpha = cfg.parentAlpha * wireColor[4]    
    end
    
    if ( this.hidden == 0 and other.hidden == 0 or (showHidden == 1) ) then
      local indicatorPoly = self.indicatorPoly
      if ( self:arrowVisible() ) then
        gfx.a = alpha
        wgfx.line( indicatorPoly[1][1], indicatorPoly[1][2], indicatorPoly[2][1], indicatorPoly[2][2] )
        wgfx.line( indicatorPoly[2][1], indicatorPoly[2][2], indicatorPoly[3][1], indicatorPoly[3][2] )
        wgfx.line( indicatorPoly[1][1], indicatorPoly[1][2], indicatorPoly[3][1], indicatorPoly[3][2] )
      end

      if ( self.accent == 1 or self.ctrls ) then
        wgfx.thickline( this.x, this.y, other.x, other.y, machineView.config.thickWireWidth, 5, colors.selectionColor )
      else
        if ( hideWires == 0 or (hideWires == 2 and self.accent == 2) ) then
          gfx.a = alpha
          wgfx.line( this.x, this.y, self.indicatorPoly[4][1], self.indicatorPoly[4][2] )
          wgfx.line( indicatorPoly[1][1], indicatorPoly[1][2], other.x, other.y )
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
    if ( self:arrowVisible() ) then
      local hit = inTriangle( self.indicatorPoly, {x,y} ) or inTriangle( self.linePoly1, {x,y} ) or inTriangle( self.linePoly2, {x,y} )
      return hit
    end
  end
    
  self.checkMouse = function(self, x, y, lx, ly, lastcapture, lmb, rmb, mmb)
    if ( self:checkHit( x, y ) ) then
      if ( machineView.lastOver == nil ) then
        self.accent = 1
      end
      machineView.lastOver = self.GUID
      if ( inputs('openSinkControl') or inputs('openSinkControl2') ) then      
        if ( not self.ctrls ) then
          self.ctrls = sink_ctrls.create( self, self.viewer, gfx.mouse_x, gfx.mouse_y, self.loc )
          return true
        end
      end

      if ( inputs('deleteSink') ) then
        if ( not self.ctrls ) then
          --self.ctrls = sink_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.loc )
          self:kill(self.loc)
          return true
        end
      end
    end
    
    return false
  end  
  
  self.analyzeSignal = function( self )
    local loc = self.loc
    if ( loc.sendidx < 0 ) then
      machineView:showAnalyzer(loc.track)
    else
      machineView:showAnalyzer(loc.track, loc.sendidx)
    end
  end
 
  self.kill = function( self )
    local loc = self.loc
    
    reaper.Undo_BeginBlock()
    if ( loc.sendidx < 0 ) then
      reaper.SetMediaTrackInfo_Value(loc.track, "B_MAINSEND", 0)
    else
      reaper.RemoveTrackSend(loc.track, 0, loc.sendidx)
    end
    reaper.Undo_EndBlock("Hackey Machines: Remove signal cable", -1)
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
  self.lavg = 0
  self.ravg = 0  
  
  self.sinkCount = function(self)
    local N=0
    if ( self.sinks ) then
      for i,v in pairs( self.sinks ) do
        N = N + 1
      end
    end
    return N
  end
  
  self.getParents = function(self)
    return self.parents
  end
  
  self.clearParents = function(self)
    self.parents = {}
  end
  
  self.addParent = function(self, GUID, obj)
    self.parents[GUID] = obj
  end
  
  self.getParents = function(self)
    return self.parents
  end
  
  self.getColor = function(self)
    return reaper.GetTrackColor(self.track)
  end
  
  self.loadColors = function(self)
    local FG = { colors.textcolor[1],  colors.textcolor[2],  colors.textcolor[3],  colors.textcolor[4] }
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
      
      palette:addToPalette(col)
    end
    
    self.fg = FG
    self.bg = BG
    self.line = colors.linecolor
    self.selectionColor = colors.selectionColor
    self.mutedfg = {FG[1], FG[2], FG[3], .5*FG[4]}
    self.mutedbg = {BG[1], BG[2], BG[3], .7*BG[3]}    
  end
  
  self.updateData = function(self)
    self:loadColors()
    self:updateName()
  end
  
  self.setColor = function(self, color)
    reaper.SetTrackColor(self.track, color)
    self:loadColors()
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
    local name, ret, str
    ret, str = reaper.GetSetMediaTrackInfo_String(self.track, "P_NAME", "", 0 )
    if ( str == machineView.specname ) then
      self.hidden = 1
    end
    
    if ( showTrackName == 1 ) then
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
          --local w, h = gfx.measurestr(name)
          --i = #name
          --while ( w > self.w ) do
          --  name = name:sub(1,-2)
          --  w, h = gfx.measurestr("[("..name..")]")
          --end
        
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
      local peakleft = reaper.Track_GetPeakInfo(self.track, 0)
      local peakright = reaper.Track_GetPeakInfo(self.track, 1)
      local peak = 8.6562*math.log(.5 * (peakleft + peakright))
      
      local silent = muted == 1 or blockedBySolo
      if ( silent ) then
        peak = 0
      end
      
      peak = 1 - machineView:dbToDisplay(peak)
      self.playColor[4] = 1-peak
      
      -- Keep circular buffer of signal
      if ( showSignals > 0 ) then      
        self.data[self.dataloc] = peak
        self.dataloc = self.dataloc + 1
        if ( self.dataloc > self.dataN ) then
          self.dataloc = 1
        end
      end
      
      self.lavg = self.lavg * 0.5 + peakleft
      self.ravg = self.ravg * 0.5 + peakright
      local sum = (self.lavg + self.ravg)
      local center
      if ( sum > 0.01 and not silent ) then
        local isum = .5 / sum
        center = .5 - isum * self.lavg + isum * self.ravg
      else
        center = 0.5
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
        box( self.x, self.y, self.w, self.h, str, self.line, self.mutedfg, self.mutedbg, self.xo, self.yo, self.w2, self.h2, showSignals, colors.signalColor, self.data, self.dataloc, self.dataN, rnc, self.hidden, self.selectedOpacity, colors.muteColor, self.selectionColor, rec, center, not notSolo )
      else
        box( self.x, self.y, self.w, self.h, self.name, self.line, self.fg, self.bg, self.xo, self.yo, self.w2, self.h2, showSignals, colors.signalColor, self.data, self.dataloc, self.dataN, rnc, self.hidden, self.selectedOpacity, self.playColor, self.selectionColor, rec, center, not notSolo )
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
    local sinkMemory = {}
    for i=0,sends-1 do
      local sinkData, GUID = sink.sinkData(self.track, i)
      if ( sinkData.parentGUID ~= sinkData.GUID ) then
        local offset = 0
        local combinedGUID = sinkData.parentGUID .. sinkData.GUID
        if ( sinkMemory[combinedGUID] ) then
          sinkMemory[combinedGUID] = sinkMemory[combinedGUID] + 1
          offset = sinkMemory[combinedGUID]
        else
          sinkMemory[combinedGUID] = 0
        end
        if ( not self.sinks[GUID] ) then
          self.sinks[GUID] = sink.create(self.viewer, self.track, i, sinkData, offset)
        else
          self.sinks[GUID].removeMe = nil
        end
      end
    end
    local mainSend = reaper.GetMediaTrackInfo_Value(self.track, "B_MAINSEND")
    if ( mainSend == 1 ) then
      local sinkData, GUID = sink.sinkData(self.track, -1)
      if ( sinkData.parentGUID ~= sinkData.GUID ) then
        local offset = 0
        local combinedGUID = sinkData.parentGUID .. sinkData.GUID
        if ( sinkMemory[combinedGUID] ) then
          sinkMemory[combinedGUID] = sinkMemory[combinedGUID] + 1
          offset = sinkMemory[combinedGUID]
        else
          sinkMemory[combinedGUID] = 0
        end
        if ( not self.sinks[GUID] ) then
          self.sinks[GUID] = sink.create(self.viewer, self.track, -1, sinkData, offset)
        else
          self.sinks[GUID].removeMe = nil
        end
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
    if ( moveMixer == 1 ) then
      -- Try to see if it moves us left. If so, do it. Otherwise, leave it.
      if ( reaper.IsTrackVisible(self.track, 1) ) then
        reaper.SetMixerScroll(self.track)
      end
    end
    if ( moveTCP == 1 ) then
      if ( reaper.IsTrackVisible(self.track, 0) ) then     
        local ctrk = 0
        local me
        for i=0,reaper.CountTracks()-1 do
          if ( reaper.IsTrackVisible(reaper.GetTrack(0,i), 0) ) then
            if ( self.track == reaper.GetTrack(0,i) ) then
              me = ctrk
            end
            ctrk = ctrk + 1;
          end
        end
        if ( me ) then
          reaper.PreventUIRefresh(1)
           for i=0,reaper.CountTracks()-1 do
             reaper.CSurf_OnArrow(0, false)
           end
           for i=1,me do
             reaper.CSurf_OnArrow(1, false)
           end
           reaper.PreventUIRefresh(-1)
           reaper.UpdateArrange()
        end
      end
    end
    self.viewer:updateSelection()
  end
  
  -- Check if the block was clicked
  self.checkHit = function(self, x, y)
    if ( not x or not y ) then
      return false
    end
    
    if ( x > (self.x - .5*self.w) and x < ( self.x + .5*self.w ) ) then
      if ( y > (self.y - .5*self.h) and y < ( self.y + .5*self.h ) ) then
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
      self.viewer.moveStart = nil
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
          if ( self:checkMute( x, y ) ) then
            if ( not self.lastToggleSolo ) then
              self:toggleSolo()
              self.lastToggleSolo = 1
            end
            return true
          else
            if ( inputs('forcebig') ) then
              self.ctrls = box_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.track, self, 1 )
            else
              self.ctrls = box_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.track, self )
            end
            return true
          end
        end
      end
    else
      self.lastToggleSolo = nil
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
  
  self.setProperty = function(self, property, val)
    reaper.SetMediaTrackInfo_Value( self.track, property, val )
    if ( self[property] and #self[property] > 0 and not (self.blocks and self.blocks[property]) ) then
      self.blocks = {}
      self.blocks[property] = 1
      machineView:broadcastToGroup(self[property], property, val)
    end
  end
  
  self.enableMute = function(self)
    self:setProperty("B_MUTE", 1)
  end
  
  self.disableMute = function(self)
    self:setProperty("B_MUTE", 0)
  end
  
  self.enableSolo = function(self)
    self:setProperty("I_SOLO", 1)
  end
  
  self.disableSolo = function(self)
    self:setProperty("I_SOLO", 0)
  end
  
  self.toggleMute = function(self)
    local mute = isMute(self)
    if ( mute == 1 ) then
      if ( self.selected == 1 ) then
        machineView:disableMuteSelection()
      else
        self:disableMute()
      end
    else
      if ( self.selected == 1 ) then
        machineView:enableMuteSelection()
      else
        self:enableMute()
      end
      
      -- If it was solo, un-solo!
      if ( isSolo(self) ) then
        if ( self.selected == 1 ) then
          machineView:enableMuteSelection()
        else
          self:disableSolo()
        end
      end
    end
  end
  
  self.toggleSolo = function(self)
    local wasSolo = isSolo(self)
    if ( wasSolo ) then
      if ( self.selected == 1 ) then
        machineView:disableSoloSelection()
      else
        self:disableSolo()
      end
    else
      -- If solo'd, make sure it is not muted
      if ( self.selected == 1 ) then
        machineView:disableMuteSelection()
        machineView:enableSoloSelection()
      else
        self:disableMute()
        self:enableSolo()
      end
    end
  end
  
  function self.checkMute(self, x, y)
    local cfg = machineView.config
    
    if ( not x or not y ) then
      return false
    end

    local w2, h2
    if ( cfg.muteButtonSize == 0 ) then
      w2 = self.w2
      h2 = self.h2
    else
      w2 = 2*cfg.muteButtonSize / zoom
      h2 = cfg.muteButtonSize / zoom
    end
    local xmi = self.x - .5 * self.w + self.xo/zoom
    local xma = self.x - .5 * self.w + self.xo/zoom + w2
    local ymi = self.y - .5 * self.h + self.yo/zoom
    local yma = self.y - .5 * self.h + self.yo/zoom + h2
    
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

function machineView:hideMachines(force)
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      if ( force ) then
        v.hidden = force
      elseif ( v.hidden == 1 ) then
        v.hidden = 0
      else
        v.hidden = 1
        --v:deselect()
      end
    end
  end
  
  --self:updateGUI()
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
  if ( not self.moveStart ) then
    self:pushPositions()
    self.moveStart = 1
  end

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

function machineView:highlightRecursively(track, value)
  for i,v in pairs( track.sinks ) do
    if ( not v.accent ) then
      v.accent = value or 1
      self:highlightRecursively( self.tracks[v.GUID], value )
    end
  end
end

function machineView:buildReverseTree()
  -- Clear parents
  for i,v in pairs( self.tracks ) do
    v:clearParents()
  end
  for i,v in pairs( self.tracks ) do
    for j,w in pairs( v.sinks ) do
      self.tracks[w:getTargetGUID()]:addParent(j,w)
    end
  end
end

function machineView:highlightRecursivelyReverse(track, value)
  for i,v in pairs( track:getParents() ) do
    if ( not v.accent ) then
      v.accent = value or 1
      self:highlightRecursivelyReverse( self.tracks[v:getSourceGUID()], value )
    end
  end
end


function machineView:drawHighlightedSignal(mx, my, reverse)
  local over
  local signalCables
  local highlightFn
  local hoverMode
  
  if ( reverse == 1 ) then
    self:buildReverseTree()
    signalCables = 'parents'
    highlightFn = self.highlightRecursivelyReverse
    hoverMode = 1
  else
    signalCables = 'sinks';
    highlightFn = self.highlightRecursively
    hoverMode = 2
  end
  
  if ( hideWires == 0 ) then
    for i,v in pairs( self.tracks ) do
      if v:checkHit( mx, my ) then
        over = v
        break;
      end
    end
    if ( self.lastOver ~= over or self.lastHoverMode ~= hoverMode ) then
      for i,v in pairs(self.tracks) do
        if ( v.parents ) then
          for j,w in pairs(v.parents) do
            w.accent = nil
          end
        end
        for j,w in pairs(v.sinks) do
          w.accent = nil
        end
      end
      -- Trace the signal
      if ( over ) then
        highlightFn(self, over)
      end
    end
  else
    local found
    for i,v in pairs(self.tracks) do
      for j,w in pairs(v[signalCables]) do
        if ( w:checkHit(mx, my) and not over ) then
          found = w
        end
        w.accent = nil
      end
      
      if v:checkHit( mx, my ) then
        over = v
        found = nil
      end
    end
    
    if ( found ) then
      -- Trace the selected ones
      for i,v in pairs(self.tracks) do
        if v.selected == 1 then
          highlightFn(self, v, 2)
        end
      end
      found.accent = 1
    else
      -- Trace the selected ones
      for i,v in pairs(self.tracks) do
        if v.selected == 1 then
          highlightFn(self, v)
        end
      end
    end
  end
  
  if ( over ) then
    highlightFn(self,over)
  end
  
  self.lastOver = over
  self.lastHoverMode = hoverMode
end

local function findCommandID(name)
  local commandID
  local lines = {}
  local fn = reaper.GetResourcePath() .. "/reaper-kb.ini"
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


function machineView:pushPositions()
  if ( not stack ) then
    stack = {}
  end
  
  local copy = {}
  for i,v in pairs(self.tracks) do
    copy[i] = {x=v.x, y=v.y}
  end
  
  stack[#stack+1] = copy
end

function machineView:popPositions()
  if ( stack ) then
    local cstack = stack[#stack]
    if ( cstack ) then
      for i,v in pairs(self.tracks) do
        if ( cstack[i] ) then
          v.x = cstack[i].x
          v.y = cstack[i].y
        end
      end
      stack[#stack] = nil
    end
  end  
end

function machineView:undoMoves()
  self:popPositions()
  self:storePositions()
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
  if ( not pcall( function() self:loadTracks(1) end ) ) then
    -- Drop all tracks and try again
    self.tracks = {}
    self:initializeTracks()
    self:loadTracks(1)
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
  
  if ( self.analyzer and self.analyzer.update ) then
    if not self.analyzer:update() then
      self.analyzer = nil
    end
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
  
  local cfg = machineView.config
  if cfg["dropfocus"] == 1 then
    has_focus = gfx.getchar(65536) & 2 > 0
    if has_focus and (lmb==0) and (rmb==0) and (mmb==0) then
      local cmd = reaper.NamedCommandLookup("_BR_FOCUS_ARRANGE_WND")
      reaper.Main_OnCommand(cmd, 0)
    end
  end

    -- Some machine is being renamed (lock everything control related while this is occurring)
    local colorSelect = 0
    
    if ( useColorBar == 1 ) then
      colorSelect = palette:processMouse(gfx.mouse_x, gfx.mouse_y)
    end
    
    if ( colorSelect > 0 ) then
      if ( colorSelect > 1 ) then
        self.painting = palette.selectedColor
      end
      if ( lastChar ~= -1 ) then
        gfx.update()
        reaper.defer(updateLoop)
      else
        self:terminate()
      end
    elseif ( self.painting ) then
      gfx.setcursor(473, 473)

      if ( lmb > 0 ) then   
        local mx = ( gfx.mouse_x - origin[1]) / zoom
        local my = ( gfx.mouse_y - origin[2]) / zoom
        for i,v in pairs(self.tracks) do
          if ( v:checkHit( mx, my ) ) then
            v:setColor( self.painting )
          end
        end
      end
      
      if ( rmb == 1 or lastChar > 0 ) then
        self.painting = nil
        gfx.setcursor(32512, 'arrow')
      end
      
      if ( lastChar ~= -1 ) then
        gfx.update()
        reaper.defer(updateLoop)
      else
        self:terminate()
      end
    elseif ( self.help ) then
      local wcmax = 0
      local wcmax2 = 0
      gfx.setfont(9, "Verdana", 14)
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
      
      if ( lastChar ~= -1 ) then
        gfx.update()
        reaper.defer(updateLoop)
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
            
      if ( inputs('reverseMod') ) then
        self:drawHighlightedSignal(mx, my, 1)      
      else
        self:drawHighlightedSignal(mx, my, 0)
      end
          
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
    
      if ( not captured ) then
        self:handleZoom(mx, my)
      end
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
          machineView.config.nightMode = night
          saveCFG(filename, self.config, self.cfgInfo)
          self:printMessage( "Switching to keymap " .. self.config.keymap .. ": " .. keymapNames[self.config.keymap] )
          initializeKeys(self.config.keymap)        
        elseif ( inputs('selectAll') ) then
          for i,v in pairs( self.tracks ) do
            v:select()
          end
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
          self:pushPositions()
          self.iter = math.min( 35, (self.iter or 1)+10 )
          self:buildColorTable()
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
        elseif ( inputs('linear') ) then
          self:pushPositions()
          self:forceLinear()
        elseif ( inputs('undomoves') ) then
          self:undoMoves()
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
        elseif ( inputs('editConfig') ) then
          launchTextEditor( getConfigFn() )
        elseif ( inputs('fitMachines') ) then
          self:fitMachines()
        elseif ( inputs('movetcp') ) then
          moveTCP = 1 - moveTCP;
          if ( moveTCP == 1 ) then
            self:printMessage( "Move TCP upon selection change" )
          else
            self:printMessage( "Don't move TCP upon selection change" )
          end
        elseif ( inputs('movemixer') ) then
          moveMixer = 1 - moveMixer;
          if ( moveMixer == 1 ) then
            self:printMessage( "Move mixer upon selection change" )
          else
            self:printMessage( "Don't move mixer upon selection change" )
          end
        elseif ( inputs('colorbarToggle') ) then
          useColorBar = 1 - useColorBar;
          if ( useColorBar == 1 ) then
            self:printMessage( "Colorbar enabled" )
          else
            self:printMessage( "Colorbar disabled" )
          end
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
  
  local filename = getConfigFn()
  machineView.config.nightMode = night
  saveCFG(filename, self.config, self.cfgInfo)

  --if ( self.analyzer and self.analyzer.terminate ) then
  --  self.analyzer:terminate()  
  --end
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

function machineView:broadcastToGroup(groups, property, val)
  for i,v in pairs(groups) do
    if ( self[property][v] ) then
      for j,w in pairs(self[property][v]) do
        local trk = self.tracks[w]
        trk:setProperty(property, val)
      end
    end
  end
end

function machineView:updateGUI()
  self:updateGridSize()
  for i,v in pairs(self.tracks) do
    v.blocks = nil
  end

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
  
  if ( useColorBar == 1 ) then
    palette:draw()
  end
  
  self:drawMessages()
end

function machineView:enableMuteSelection()
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      v:enableMute()
    end
  end
end

function machineView:disableMuteSelection()
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      v:disableMute()
    end
  end
end

function machineView:enableSoloSelection()
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      v:enableSolo()
    end
  end
end

function machineView:disableSoloSelection()
  for i,v in pairs(self.tracks) do
    if ( v.selected == 1 ) then
      v:disableSolo()
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

local function unpackInt(val, offset, tin)
  local chk = 2147483648 --4294967296
  local idx = 32
  
  local t = tin or {}
  while( idx > 0 ) do
    if ( val >= chk ) then
      table.insert(t, idx+offset)
      val = val - chk
    end
    idx = idx - 1
    chk = chk * .5    
  end
  
  return t
end

local function fetchGroupProperty( track, property )
  local high = unpackInt( reaper.GetSetTrackGroupMembershipHigh(track, property, 0, 0), 32 )
  local complete = unpackInt( reaper.GetSetTrackGroupMembership(track, property, 0, 0), 0, high )  
  
  return complete
end

function machineView:loadTracks(updateNow)
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
  local muteSlaves = {}
  local soloSlaves = {}
  for i=0,reaper.GetNumTracks()-1 do
    local track = reaper.GetTrack(0, i)
    local GUID = reaper.GetTrackGUID(track)
    if ( GUID ) then
      -- Is this track indexed already?
      if ( self.tracks[GUID] ) then
        self.tracks[GUID].found = 1
        if ( updateNow ) then
          self.tracks[GUID]:updateData()
        end
      else
        local GUID = reaper.GetTrackGUID(track)
        local x, y = self:loadMachinePosition(GUID)
        
        self:addTrack(track, math.floor(x or (insX or 0) + .1*self.config.width*math.random()), y or (insY or 0) + math.floor(.1*self.config.height*math.random()))
      end
      
      -- Is it selected? Then add it to the selection list
      if ( reaper.GetMediaTrackInfo_Value(track, "I_SELECTED") == 1 ) then
        self.tracks[GUID].selected = 1
      end
      
      -- Assign group masters
      local muteMaster = fetchGroupProperty( track, "MUTE_MASTER" )
      local soloMaster = fetchGroupProperty( track, "SOLO_MASTER" )      
      self.tracks[GUID].B_MUTE = muteMaster
      self.tracks[GUID].I_SOLO = soloMaster
      
      -- Assign group slaves
      local muteSlave = fetchGroupProperty( track, "MUTE_SLAVE" )
      local soloSlave = fetchGroupProperty( track, "SOLO_SLAVE" )
      for j,w in pairs(muteSlave) do
        if not muteSlaves[w] then muteSlaves[w] = {} end
        table.insert( muteSlaves[w], GUID )
      end
      for j,w in pairs(soloSlave) do
        if not soloSlaves[w] then soloSlaves[w] = {} end
        table.insert( soloSlaves[w], GUID )
      end
    end
  end
  self.I_SOLO = soloSlaves
  self.B_MUTE = muteSlaves
  
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

function machineView:fitMachines()
  local minx =  1000000
  local maxx = -1000000
  local miny =  1000000
  local maxy = -1000000
  for i,v in pairs( self.tracks ) do
    local vx = v.x
    local vy = v.y
    minx = math.min(vx, minx)
    miny = math.min(vy, miny)
    maxx = math.max(vx, maxx)
    maxy = math.max(vy, maxy)
  end

  local w = machineView.config.blockWidth
  local h = machineView.config.blockHeight
  local ws = maxx - minx + 2*w
  local hs = maxy - miny + 2*h
  zoom = math.min( gfx.w / ws, gfx.h / hs );
  
  origin[1] = .5*gfx.w - 0.5 * (maxx+minx) * zoom
  origin[2] = .5*gfx.h - 0.5 * (maxy+miny) * zoom
end

function machineView:countDownward(order)
  local penalty = 0
  for i,v in pairs(order) do
    if ( v.sinks ) then
      for j,w in pairs(v.sinks) do
        local found = nil
        for k,x in pairs(order) do
          if ( x == self.tracks[w:getTargetGUID()] ) then
            found = 1
          end
        end
        if ( found ) then
          local y2 = self.tracks[w:getTargetGUID()].y
          local y1 = self.tracks[w:getSourceGUID()].y
          if y2 < y1 then
            penalty = penalty + 1
          end
          if ( math.abs(y2 - y1) > ( self.linearyspacing ) ) then
            penalty = penalty + 2
          end
          found = nil
        end
      end
    else
      print("Did not find sink")
    end
  end
  
  return penalty
end

local function swap(t, idx1, idx2)
  local tmp = t[idx1]
  t[idx1] = t[idx2]
  t[idx2] = tmp
  return t
end

local function copy1(t)
  local copy = {}
  for i,v in pairs(t) do
    copy[i] = v
  end
  
  return copy
end

function machineView:placeGroup(x, grp)
  local y = 0
  if ( grp.master ) then
    grp.master.x = x
    grp.master.y = y
    y = y + self.linearyspacingtop
  end    
  for j,trk in pairs( grp.tracks ) do
    if ( trk ~= grp.master ) then
      trk.x = x
      trk.y = y
      y = y + self.linearyspacing
    end
  end
end

function machineView:forceLinear()
  local cfg = machineView.config
  local groups = {}
  local master
  local nGroups = 0
  local maxLen = 0
  for i,v in pairs( self.tracks ) do
    if ( v.name ~= "MASTER" ) then
      local c = reaper.GetTrackColor(v.track)
      if ( not groups[c] ) then
        groups[c] = {}
        groups[c].tracks = {}
        nGroups = nGroups + 1
      end
      if ( string.match(v.name, "VCA") ) then
        groups[c].master = v
      end
      groups[c].tracks[#groups[c].tracks + 1] = v
      if #groups[c].tracks > maxLen then
        maxLen = #groups[c].tracks
      end
    else
      master = v
    end
  end

  -- Exhaustively list how many times the sinks change y direction (for sorting)
  local lastBest = 1000000
  if ( cfg.rowSortMethod == 1 ) then
    local opt
    for i,grp in pairs( groups ) do
      local c = {}
      local n = #grp.tracks+1

      for j=1,n do
          c[j] = 1
      end
  
      self:placeGroup(1000, grp)  
      lastBest = self:countDownward(grp.tracks)
      opt = copy1(grp.tracks)
      
      local j = 1
      local iter = 0
      local maxiter = 1000
      while (j < n) and (iter < maxiter) do
        if c[j] < j then
          if math.floor(j*.5) == j*.5 then
            grp.tracks = swap(grp.tracks, 1, j)
          else
            grp.tracks = swap(grp.tracks, c[j], j)
          end
          
          self:placeGroup(1000, grp)
          local penalty = self:countDownward(grp.tracks)
          if ( penalty < lastBest ) then
            opt = copy1(grp.tracks)
            lastBest = penalty
          end
          
          c[j] = c[j] + 1
          j = 1
        else
          c[j] = 1
          j = j + 1
        end
        iter = iter + 1
      end
      grp.tracks = opt
    end
  end

  local x = - math.floor(nGroups*0.5) * 150
  for i,grp in pairs( groups ) do
    self:placeGroup(x, grp)
    x = x + self.linearxspacing
  end
  master.x = x-self.linearxspacing
  master.y = maxLen * self.linearyspacing + self.linearyspacing
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

function machineView:colorSimilarity(a, b)
  local acc = 0
  for i,v in pairs(a.colorScore) do
    local res = v - b.colorScore[i]
    acc = acc + res*res
  end
  
  return 1-.5*acc
end

-- Build a color index to determine similarities between nodes
-- Every node has a color, which goes in with weight W
-- Then every signal cable contributes color from other nodes.
-- This allows data to be sorted in a more clustered fashion later.
function machineView:buildColorTable()
  -- Build color structure
  for i,v in pairs(self.tracks) do
    v.colorScore = {}
    for j,w in pairs(palette.colors) do
      v.colorScore[j] = 0
    end
    v.colorScore[v:getColor()] = 5
  end
  for i,v in pairs(self.tracks) do
    myColor = v:getColor()
    for j,w in pairs(v.sinks) do
      local targetTrack = self.tracks[w:getTargetGUID()]
      
      if ( targetTrack.colorScore[myColor] ) then
        targetTrack.colorScore[myColor] = targetTrack.colorScore[myColor] + 1
      else
        targetTrack.colorScore[myColor] = 1
      end
    end
  end
  
  -- Normalize color scores
  for i,v in pairs(self.tracks) do
    local sum = 0
    for j,w in pairs(v.colorScore) do
      sum = sum + w
    end
    for j,w in pairs(v.colorScore) do
      v.colorScore[j] = w / sum
    end
  end
  
  local cSim = {}
  for i,v in pairs(self.tracks) do
    cSim[v] = {}
    for j,w in pairs(self.tracks) do
      cSim[v][w] = self:colorSimilarity(v, w)
    end
  end
  
  self.cSim = cSim
end


function machineView:calcForces()
  local cDiffs = self.cDiffs
  local bw = .5*self.config.blockWidth
  local bh = .5*self.config.blockHeight
  local bwsq = bw*bw

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
  local N = 0
  for i,v in pairs( self.tracks ) do
    N = N + 1
    xx = v.x
    xy = v.y
    
    local nSinks = #v.sinks
    local kc = k/(nSinks+1)
    for j,w in pairs( v.sinks ) do
      sx = self.tracks[w.GUID].x
      sy = self.tracks[w.GUID].y
      
      rx = sx - xx
      ry = sy - xy
      
      -- Spring
      fx[i] = fx[i] + kc*rx
      fy[i] = fy[i] + kc*ry
      fx[w.GUID] = fx[w.GUID] - kc*rx
      fy[w.GUID] = fy[w.GUID] - kc*ry
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
  local nt = #self.tracks
  local qk = k / (N*N)
  local cSim = self.cSim
  for i,v in pairs( self.tracks ) do
    for j,w in pairs( self.tracks ) do
      if ( v ~= w ) then
        xx = v.x
        xy = v.y
        sx = w.x
        sy = w.y
                        
        rx = sx - xx
        ry = sy - xy
        
        local dist = ( rx*rx + ry*ry )
        
        if ( dist < 2*bwsq ) then
          dist = dist*4
        end

        local F = 2*Q / dist
        local similarity = 0
        
        if cSim and cSim[v] then
          similarity = self.cSim[v][w] or 0
        end
        fx[i] = fx[i] + qk * rx * similarity * 75
        fy[i] = fy[i] + qk * ry * similarity * 75
        
        fx[i] = fx[i] - F * rx
        fy[i] = fy[i] - F * ry
      end
    end
    fx[i] = fx[i] + 3*(math.random()-.5)*math.min(20, (self.iter or 1))
    fy[i] = fy[i] + 3*(math.random()-.5)*math.min(20, (self.iter or 1))
    
    if v.x > (gfx.w-bw) then
      fx[i] = fx[i] - QQ
    end
    if v.x < bw then
      fx[i] = fx[i] + QQ
    end
    if v.y > (gfx.h-bh) then
      fy[i] = fy[i] - QQ
    end
    if v.y < bh then
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
        for k, v in string.gmatch(str, "(%w+)=([%+%-]*%w*% *%w+%.*%w*)") do
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

function saveCFG(fn, cfg, descriptions)
  local file = io.open(fn, "w+")
  
  local info = descriptions or {}
  if ( file ) then
    io.output(file)

    local keys = {}
    for i,v in pairs(cfg) do
      table.insert(keys, i)
    end
    table.sort( keys )

    for i,v in pairs(keys) do
      io.write( string.format('%s=%s ; %s\n', v, cfg[v], info[v] or '' ) )
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
  night = machineView.config.nightMode
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
  
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "moveTCP")
  if ( ok ) then move = tonumber( v ) end
  
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "moveMixer")
  if ( ok ) then move2 = tonumber( v ) end
  
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "useColorBar")
  if ( ok ) then cb = tonumber( v ) end
  
  
  origin[1]     = ox or origin[1]
  origin[2]     = oy or origin[2]
  zoom          = z or zoom
  showSignals   = showS or showSignals
  showTrackName = showT or showTrackName
  showHidden    = showH or showHidden  
  moveTCP       = move or moveTCP
  moveMixer     = move2 or moveMixer
  useColorBar   = cb or useColorBar
  
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
  
  reaper.SetProjExtState(0, "MVJV001", "moveTCP", tostring(moveTCP))  
  reaper.SetProjExtState(0, "MVJV001", "moveMixer", tostring(moveMixer))    
  reaper.SetProjExtState(0, "MVJV001", "showSignals", tostring(showSignals))
  reaper.SetProjExtState(0, "MVJV001", "showTrackName", tostring(showTrackName))
  reaper.SetProjExtState(0, "MVJV001", "showHidden", tostring(showHidden))  
  reaper.SetProjExtState(0, "MVJV001", "night", tostring(night))
  reaper.SetProjExtState(0, "MVJV001", "grid", tostring(grid))  
  reaper.SetProjExtState(0, "MVJV001", "useColors", tostring(useColors))
  reaper.SetProjExtState(0, "MVJV001", "hideWires", tostring(hideWires))
  reaper.SetProjExtState(0, "MVJV001", "useColorBar", tostring(useColorBar))
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
  self:buildColorTable()
end

palette:init()
Main()

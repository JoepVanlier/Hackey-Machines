# Hackey-Machines
A LUA modular interface plugin for REAPER 5.9x and up. Designed to mimick the machine editor in Jeskola Buzz.

![Importing templates](https://i.imgur.com/WaQWCRC.gif)
Importing templates.

![Manipulate channels](https://i.imgur.com/jKxfOnN.gif)
Manipulation of volume, panning, name, solo/mute status, to/from channel.

![Deleting machines](https://i.imgur.com/bUEdAUR.gif)
Deleting machines

## Installation
### With Reapack
Add it in your Reapack repository list: `https://raw.githubusercontent.com/joepvanlier/Hackey-Machines/master/index.xml`.

### Without
- Press `?` or select `Actions > Action List`
- click the ReaScript: `Load` button

### Install SWS extensions
Hackey Machines require the SWS extensions for REAPER, which can be found here: `http://www.sws-extension.org/`

### Configure which machines to see in the "Insert machine" window.
On Windows F10 opens the config file, where you can set which machines you would like to see in the insert machine dropdown window.
On other OS-es, look for the file FX_list.lua in your %APPDATA%/REAPER/Scripts/Routing tools/MachineView. Edit the file according to the same format.

## Usage
Hackey Machines provides an alternative way for visualizing and manipulating the routing in REAPER.

![Control Surfaces](https://i.imgur.com/VXhQdzy.png)

Clicking a machine with the outer mouse button or a signal cable with the inner mouse button opens context dependent options.


![Insert Machine](https://i.imgur.com/lQ5DTvu.png)

Clicking anywhere with the outer mouse button opens a window to insert new machines.


Connecting two machines can be done by holding shift, clicking the source machine and then dragging the line over to the target machine. Scrolling with the mousewheel zooms, while clicking with the middle mouse button and dragging pans the field of view. Middle mouse on a connection disconnects the two machines. Doubleclicking a machine opens its GUI (if it has one).


If the wiring turns messy, hit ENTER to simulate the force-based rearranger for a few more steps. It combines spring forces between connected machines and repelling forces between all machines to try and optimally layout the machine graph.

  | Key                                   | Action                                                                |
  |:--------------------------------------|:----------------------------------------------------------------------|
  | F1                                    | Help                                                                  |
  | F2                                    | Enables and disables visualization of signals                         |
  | F3                                    | Toggles between track and machine names                               |
  | F4                                    | Toggle showing all machines versus hiding some                        |
  | F5                                    | Switch to night mode                                                  |
  | F8 									  | ??? 																  |
  | F10 								  | Open file with machine (VST/FX) list 								  |
  | 									  | 																	  |
  | Shift + Drag to other machine         | Connect machines                                                      |
  | Left mouse button on connection arrow | Open subwindow to manipulate volume, panning or disconnect machines   |
  | Right mouse button on machine         | Open window to solo, mute, rename, duplicate or remove the machine    |
  | Middle mouse button                   | Disconnect machine                                                    |
  | Middle mouse button + Drag            | Shift field of view                                                   |
  | Scrollwheel                           | Adjust zoom level                                                     |
  | Doubleclick machine                   | Opens machine GUI (if present)                                        |
  | Enter                                 | Simulate forces                                                       |
  | Delete 								  | Delete selected machine 											  |
  | H 	 								  | Hide selected machine 												  |
  | 									  | 																	  |
  | CTRL + S 							  | Save Project 														  |
  | CTRL + Z 							  | Undo 																  |
  | CTRL + Shift + Z 					  | Redo 																  |
 

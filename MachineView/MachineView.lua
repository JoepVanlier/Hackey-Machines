--[[
@description Hackey-Machines: An interface plugin for REAPER 5.x and up designed to mimick the machine editor in Jeskola Buzz.
@author: Joep Vanlier
@provides
  [main] .
@links
  https://github.com/JoepVanlier/Hackey-Machines
@license MIT
@version 0.01
@screenshot 
@about 
  ### Hackey-Machines
  #### What is it?
  A lightweight machine plugin for REAPER 5.x and up.
  
  If you use this plugin and enjoy it let me/others know. If you run into any bugs
  and figure out a way to reproduce them, please open an issue on the plugin's
  github page [here](https://github.com/JoepVanlier/Hackey-Trackey/issues). I would
  greatly appreciate it!
  
  Happy trackin' :)
--]]

--[[
 * Changelog:
 * v0.01 (2018-08-03)
   + First upload. Basic functionality works, but cannot add new machines from the GUI yet.
--]]

machineView = {}
machineView.tracks = {}
machineView.config = {}
machineView.config.blockWidth = 100
machineView.config.blockHeight = 45
machineView.config.width = 500
machineView.config.height = 500
machineView.config.x = 100
machineView.config.y = 100

machineView.config.muteOrigX = 4
machineView.config.muteOrigY = 4
machineView.config.muteWidth = 14
machineView.config.muteHeight = 7

doubleClickInterval = 0.2
origin = { 0, 0 }
zoom = 0.8

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
--          elseif (type(v) == 'userdata') and ( v.y ) then
--            print(formatting .. " " .. tostring(v) .. ": ".. "x: "..v.x..", y: "..v.y)
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

colors = {}
function machineView:loadColors(colorScheme)
  -- If you come up with a cool alternative color scheme, let me know
  if colorScheme == "default" then
    -- Buzz
    colors.textcolor        = {1/256*48, 1/256*48, 1/256*33, 1}
    colors.linecolor        = {1/256*218, 1/256*214, 1/256*201, 1}
    colors.linecolor2       = {1/256*218, 1/256*214, 1/256*201, 1}
    colors.windowbackground = {1/256*218, 1/256*214, 1/256*201, 1}
    colors.buttonbg         = { 0.1, 0.1, 0.1, .7 }
    colors.buttonfg         = { 0.3, 0.9, 0.4, 1.0 }
    colors.connector        = { .2, .2, .2, 0.8 }    
  elseif colorScheme == "renoiseB" then
    colors.textcolor        = {148/256, 148/256, 148/256, 1}
    colors.linecolor        = {18/256,18/256,18/256, 0.6}
    colors.linecolor2       = {18/256,18/256,18/256, 0.6}
    colors.windowbackground = {18/256, 18/256, 18/256, 1}
    colors.buttonbg         = { 0.1, 0.1, 0.1, .7 }
    colors.buttonfg         = { 0.3, 0.9, 0.4, 1.0 }
    colors.connector        = { .8, .8, .8, 0.8 }
  end
  -- clear colour is in a different format
  gfx.clear = colors.windowbackground[1]*256+(colors.windowbackground[2]*256*256)+(colors.windowbackground[3]*256*256*256)
end

local function box( x, y, w, h, name, fg, bg, xo, yo, w2, h2 )
  local gfx = gfx
  
  xmi = xtrafo( x - 0.5*w )
  xma = xtrafo( x + 0.5*w )
  ymi = ytrafo( y - 0.5*h )
  yma = ytrafo( y + 0.5*h )
  w = zoom * w
  h = zoom * h

  gfx.set( 0.0, 0.0, 0.0, 0.8 )
  gfx.rect(xmi, ymi, w, h )
    
  gfx.set( table.unpack(bg) )
  gfx.rect(xmi, ymi, w, h )
  gfx.set( table.unpack(fg) )  
  gfx.line(xmi, ymi, xma, ymi)
  gfx.line(xmi, yma, xma, yma)
  gfx.line(xmi, ymi, xmi, yma)
  gfx.line(xma, ymi, xma, yma)
  
  gfx.line(xmi+2, ymi+2, xma, ymi)
  gfx.line(xmi+2, yma+2, xma, yma)
  gfx.line(xmi+2, ymi+2, xmi, yma)
  gfx.line(xma+2, ymi+2, xma, yma)  
  
  gfx.setfont(1, "Lucida Grande", math.floor(20*zoom))
  local w, h = gfx.measurestr(name)
  gfx.x = xtrafo(x)-0.5*w
  gfx.y = ytrafo(y)-0.5*h
  
  gfx.drawstr( name, 1, 1 )
  
  local xmi2 = xmi + xo
  local xma2 = xmi + xo + w2
  local ymi2 = ymi + yo
  local yma2 = ymi + yo + h2
  gfx.line(xmi2, ymi2, xma2, ymi2)
  gfx.line(xmi2, yma2, xma2, yma2)
  gfx.line(xmi2, ymi2, xmi2, yma2)
  gfx.line(xma2, ymi2, xma2, yma2)  
end

-- World space drawing routines
wgfx = {
  line = function(x1, y1, x2, y2)
    gfx.line( xtrafo(x1), ytrafo(y1), xtrafo(x2), ytrafo(y2) )
  end,
  rect = function(x, y, w, h)
    gfx.rect( xtrafo(x), ytrafo(y), zoom*w, zoom*h )
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
function button.create(parent, x, y, c, c2, callback)
  local self    = {}
  self.parent   = parent
  self.x        = x
  self.y        = y
  self.c        = c
  self.c2       = c2
  self.bg       = colors.buttonbg
  self.fg       = colors.buttonfg
  self.callback = callback
  
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
    gfx.circle(x,y,c,0,1)
    --gfx.circle(x,y,c2,0,1)
    
    if ( self.label ) then
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
   
  self.checkMouse = function(self, x, y, lx, ly, lastcapture, lmb, rmb, mmb)
    -- Override x and y to work in screen spcae
    local x = gfx.mouse_x
    local y = gfx.mouse_y
    local lmb = gfx.mouse_cap & 1
    if ( lmb > 0 ) then lmb = true else lmb = false end
    local shift = gfx.mouse_cap & 8
    if ( shift > 0 ) then shift = true else shift = false end

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
function dial.create(parent, x, y, c, c2, getval, setval, disp, lb, ub)
  local self  = {}
  self.parent = parent
  self.x      = x
  self.y      = y
  self.c      = c
  self.c2     = c2
  self.val    = .5
  self.bg     = colors.buttonbg
  self.fg     = colors.buttonfg
  self.getval = getval
  self.setval = setval
  self.disp   = disp
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
    -- Override x and y to work in screen spcae
    local x = gfx.mouse_x
    local y = gfx.mouse_y
    local lmb = gfx.mouse_cap & 1
    if ( lmb > 0 ) then lmb = true else lmb = false end
    local shift = gfx.mouse_cap & 8
    if ( shift > 0 ) then shift = true else shift = false end

    -- LMB
    if ( lmb ) then  
      if ( self == lastcapture ) then
        if ( self.getval ) then
          self.val = self.getval()
        end
      
        -- Were we trying to connect something?
        self.val = self.val - .015*(y-self.ly)
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
        self.lx = x
        self.ly = y        
        return true
      end
    end
  
    return false
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
  
  self.offsetX  = -20
  self.offsetY  = -20
  self.vW       = 80
  self.vH       = 80
  
  local vW = self.vW
  local vH = self.vH
  self.ctrls = {}
    
  -- Setter and getter lambdas
  local setVol, getVol, setPan, getPan
  if ( loc.sendidx < 0 ) then
    -- Main send
    getVol = function()     return reaper.GetMediaTrackInfo_Value(loc.track, "D_VOL")/2 end
    getPan = function()     return (reaper.GetMediaTrackInfo_Value(loc.track, "D_PAN")+1)*.5 end
    setVol = function(val)  return reaper.SetMediaTrackInfo_Value(loc.track, "D_VOL", val*2) end
    setPan = function(val)  return reaper.SetMediaTrackInfo_Value(loc.track, "D_PAN", val*2-1) end    
  else
    getVol = function()     return reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_VOL")/2 end
    getPan = function()     return (reaper.GetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_PAN")+1)*.5 end
    setVol = function(val)  return reaper.SetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_VOL", val*2) end
    setPan = function(val)  return reaper.SetTrackSendInfo_Value(loc.track, 0, loc.sendidx, "D_PAN", val*2-1) end
  end
  
  dispVol = function(val) return string.format("%.1f",20*math.log(val*2)/math.log(10)) end
  dispPan = function(val) 
    if ( val > 0.5 ) then
      return string.format("%2dR",math.ceil(200*(val-0.5)))
    else
      return string.format("%2dL",math.floor(200*(0.5-val)))
    end
  end
  
  killCallback = function() self.kill(self) end
  
  self.ctrls[1] = dial.create(self, .25*vW + self.offsetX, .25*vH + self.offsetY, .14*vW, .2*vW, getVol, setVol, dispVol)
  self.ctrls[1].label = "V"
  self.ctrls[2] = dial.create(self, .75*vW + self.offsetX, .25*vH + self.offsetY, .14*vW, .2*vW, getPan, setPan, dispPan)
  self.ctrls[2].label = "P"
  self.ctrls[2].drawFromCenter = 1  
  self.ctrls[3] = button.create(self, .75*vW + self.offsetX, .75*vH + self.offsetY, .14*vW, .2*vW, killCallback)
  self.ctrls[3].label = "REM"
  
  self.kill = function( self )
    if ( loc.sendidx < 0 ) then
      reaper.SetMediaTrackInfo_Value(loc.track, "B_MAINSEND", 0)
    else
      reaper.RemoveTrackSend(loc.track, 0, loc.sendidx)
    end
    self.viewer:loadTracks()
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

-- getTrackTargetIdx
-- This function requires the SWS extensions
local function getSendTargetTrack(track, idx)
  -- local retval, buf = reaper.GetTrackSendName(track, idx, "                                                                                       ")
  -- reaper.GetTrack(0, target)

  -- Requires SWS
  return reaper.BR_GetMediaTrackSendInfo_Track( track, 0, idx, 1 )
end

---------------------------------------
-- SINK
---------------------------------------
sink = {}
function sink.create(viewer, track, idx)
  local GUID
  local self          = {}
  self.viewer         = viewer

  -- It's a specific send
  local parentGUID = reaper.GetTrackGUID(track)
  if ( idx > - 1 ) then
    --local target      = reaper.GetTrackSendInfo_Value(track, 0, idx, "I_DSTCHAN")
    local targetTrack = getSendTargetTrack( track, idx )
    GUID              = reaper.GetTrackGUID(targetTrack)
    sinkType          = SINKTYPES.SEND
  else
    -- It's a main send of some sort
    local targetTrack = reaper.GetParentTrack(track)
    if ( targetTrack ) then
      GUID            = reaper.GetTrackGUID(targetTrack)
      sinkType        = SINKTYPES.PARENT
    else
      local depth = reaper.GetTrackDepth(track)
      if ( depth == 0 ) then
        GUID          = reaper.GetTrackGUID( reaper.GetMasterTrack(0) )
        sinkType      = SINKTYPES.MASTER
      end
    end
  end 
  
  self.loc            = {track=track, sendidx=idx}
  self.from           = parentGUID
  self.GUID           = GUID
  self.type           = sinkType
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
    gfx.set( table.unpack( self.color ) )
    local other = self.viewer:getBlock( self.GUID )
    local this  = self.viewer:getBlock( self.from )
    
    local indicatorPoly = self.indicatorPoly
    wgfx.line( this.x, this.y, other.x, other.y )
    wgfx.line( indicatorPoly[1][1], indicatorPoly[1][2], indicatorPoly[2][1], indicatorPoly[2][2] )
    wgfx.line( indicatorPoly[2][1], indicatorPoly[2][2], indicatorPoly[3][1], indicatorPoly[3][2] )
    wgfx.line( indicatorPoly[1][1], indicatorPoly[1][2], indicatorPoly[3][1], indicatorPoly[3][2] )        
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
    local lmb = gfx.mouse_cap & 1
    if ( lmb > 0 ) then lmb = true else lmb = false end
    local mmb = ( gfx.mouse_cap & 64 )
    if ( mmb > 0 ) then mmb = true else mmb = false end    
    local shift = gfx.mouse_cap & 8
    if ( shift > 0 ) then shift = true else shift = false end
  
    if ( lmb ) then      
      if ( self:checkHit( x, y ) ) then
        if ( not self.ctrls ) then
          self.ctrls = sink_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.loc )
          return false
        end
      end
    end

    if ( mmb ) then      
      if ( self:checkHit( x, y ) ) then
        if ( not self.ctrls ) then
          self.ctrls = sink_ctrls.create( self.viewer, gfx.mouse_x, gfx.mouse_y, self.loc )
          self.ctrls:kill()
          return false
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
function block.create(track, x, y, FG, BG, config, viewer)
  local self = {}

  self.viewer = viewer
  self.found = 1
  self.track = track
  self.x = x
  self.y = y
  self.fg = FG
  self.bg = BG
  self.mutedfg = {FG[1], FG[2], FG[3], .5*FG[4]}
  self.mutedbg = {BG[1], BG[2], BG[3], .7*BG[3]}
  self.w = config.blockWidth
  self.h = config.blockHeight
  self.xo = config.muteOrigX
  self.yo = config.muteOrigY
  self.w2 = config.muteWidth
  self.h2 = config.muteHeight
  self.checkMute = block.checkMute
  self.toggleMute = block.toggleMute
  self.move = block.move
  
  local ret, name = reaper.TrackFX_GetFXName(track, 0, "                                                                                          ")
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
      w, h = gfx.measurestr("("..name..")")
    end
  
    self.name = name
  else
    self.name = "NO FX"  
  end
  
  self.drawCtrls = function()
    if ( self.sinks ) then
      for i,v in pairs( self.sinks ) do
        v:drawCtrl()
      end
    end
  end
  
  self.drawConnections = function()
    if ( self.arrow ) then
      wgfx.line( self.x, self.y, self.arrow.X, self.arrow.Y )
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
  
  -- Draw me
  self.draw = function()
    local muted = reaper.GetMediaTrackInfo_Value( self.track, "B_MUTE" )
    if ( muted == 1 ) then
      box( self.x, self.y, self.w, self.h, "(" .. self.name .. ")", self.mutedfg, self.mutedbg, self.xo, self.yo, self.w2, self.h2 )    
    else
      box( self.x, self.y, self.w, self.h, self.name, self.fg, self.bg, self.xo, self.yo, self.w2, self.h2 )
    end  
  end
  
  -- Update all the sinks from the REAPER data
  self.updateSinks = function()
    local sends = reaper.GetTrackNumSends(self.track, 0)
    
    self.sinks = {}
    for i=0,sends-1 do
      self.sinks[#self.sinks+1] = sink.create(self.viewer, self.track, i)
    end
    local mainSend = reaper.GetMediaTrackInfo_Value(self.track, "B_MAINSEND")
    if ( mainSend == 1 ) then
      self.sinks[#self.sinks+1] = sink.create(self.viewer, self.track, -1)
    end
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
    local lmb = gfx.mouse_cap & 1
    if ( lmb > 0 ) then lmb = true else lmb = false end
    local shift = gfx.mouse_cap & 8
    if ( shift > 0 ) then shift = true else shift = false end
  
    -- LMB
    if ( lmb ) then
      -- Were we the last capture?
      if ( self == lastcapture ) then
        if ( shift ) then
          if ( not self.isMaster ) then
            -- Arrow towards somewhere
            self.arrow = {}
            self.arrow.X = x
            self.arrow.Y = y
            return true
          end
        end
      
        -- Move the object
        self.arrow = nil
        self.x = self.x + (x - lx)
        self.y = self.y + (y - ly)
        self.viewer:invalidate()
        return true
      end
      
      if ( self:checkHit( x, y ) ) then
        if ( self:checkMute( x, y ) ) then
          self:toggleMute()
        else
          if ( self.lastTime and (reaper.time_precise() - self.lastTime) < doubleClickInterval ) then
            reaper.TrackFX_SetOpen(self.track, 0, true)
            reaper.TrackFX_Show(self.track, 0, 0)            
            reaper.TrackFX_Show(self.track, 0, 3)
          end
          self.lastTime = reaper.time_precise()
        end
        
        return true
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
            
            -- Check if we are connecting to the master track (mainsend)
            local depth = reaper.GetTrackDepth(self.track)
            if ( otherTrack == reaper.GetMasterTrack(0) and depth == 0 ) then
              --print( "Attempt to connect to master" )
              reaper.SetMediaTrackInfo_Value(self.track, "B_MAINSEND", 1)
            elseif ( otherTrack == reaper.GetParentTrack(self.track) ) then
              -- Check if we are connecting to the parent (mainsend)
              reaper.SetMediaTrackInfo_Value(self.track, "B_MAINSEND", 1)
            else
              -- Other
              reaper.CreateTrackSend(self.track, otherTrack)
            end
            
            self.viewer:loadTracks()
          else
            -- Did not find block to connect to
          end
          return false
        end
      end
    end
   
    -- No capture, release the handle
    self.arrow = nil
    return false
  end  
  
  self.toggleMute = function(self)
    local mute = reaper.GetMediaTrackInfo_Value(self.track, "B_MUTE")
    if ( mute == 1 ) then
      reaper.SetMediaTrackInfo_Value( self.track, "B_MUTE", 0 )
    else
      reaper.SetMediaTrackInfo_Value( self.track, "B_MUTE", 1 )
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
  self.tracks[GUID] = block.create(track, x, y, colors.textcolor, colors.linecolor2, self.config, self)
  return self.tracks[GUID]
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

------------------------------
-- Main update loop
-----------------------------
local function updateLoop()
  local self = machineView    
  
  self:updateGUI()
  
  --gfx.x = 0
  --gfx.y = 0
  --gfx.drawstr( string.format( "%d, %d", origin[1], origin[2] ) )
  
  if ( not self.valid ) then
    self.valid = true
  end
  
  local mx = ( gfx.mouse_x - origin[1]) / zoom
  local my = ( gfx.mouse_y - origin[2]) / zoom
  
  -- Prefer last object that was captured
  if ( self.lastCapture ) then
    local captured = self.lastCapture:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb )
    self:updateMouseState(mx, my)
    if ( captured == false ) then
      self.lastCapture = nil
    end
  else
    local captured = false    
    for i,v in pairs(self.tracks) do     
      -- Check if there is a sink control panel open
      for j,w in pairs(v.sinks) do
        -- First check if there is a sink control panel open. This has highest capture priority.
        if ( w.ctrls ) then
          inrange = w.ctrls:inRange( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb)
          if ( not inrange ) then
            w.ctrls = nil
          else
            self.lastCapture = w.ctrls:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb )
            captured = true
            break;
          end
        end
      end
    end
      
    -- Check if a block is clicked
    if ( not captured ) then
      for i,v in pairs(self.tracks) do
        local captured = v:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb)
        if ( captured == true ) then
          self:updateMouseState(mx, my)
          self.lastCapture = v
          break;
        else      
          -- Nothing clicked yet, then consider the arrows/sinks?
          for j,w in pairs(v.sinks) do         
            -- Check if any of the sinks are clicked.
            if ( not captured ) then        
              captured = w:checkMouse( mx, my, self.lx, self.ly, self.lastCapture, self.lmb, self.rmb, self.mmb)
            end
            if ( captured == true ) then
              self.lastCapture = w
              break;
            end
          end
        end
      end      
    end    
  end

  zoom = zoom + ( gfx.mouse_wheel / 2000 )
  if ( zoom > 2 ) then
    zoom = 2
  elseif ( zoom < 0.5 ) then
    zoom = 0.5
  end

  if ( ( gfx.mouse_cap & 64 ) > 0 ) then
    if ( self.ldragx ) then
      local dx = gfx.mouse_x - self.ldragx
      local dy = gfx.mouse_y - self.ldragy
      origin[1] = origin[1] + dx
      origin[2] = origin[2] + dy      
    end
    self.ldragx = gfx.mouse_x
    self.ldragy = gfx.mouse_y
  else
    self.ldragx = nil
  end 

  if ( self.iter and self.iter > 0 ) then
    machineView:distribute()
    self.iter = self.iter - 1
  end
  
  if ( self.iterFree and self.iterFree > 0 ) then
    machineView:distribute(1)
    self.iterFree = self.iterFree - 1
  end

  gfx.update()
  gfx.mouse_wheel = 0
  
  -- Maintain the loop until the window is closed or escape is pressed
  prevChar = lastChar
  lastChar = gfx.getchar()
  
  if ( lastChar ~= -1 ) then
    reaper.defer(updateLoop)
    
    if ( lastChar == 13 ) then
      self.iter = 10
    end
  else
    self:storePositions()
  end
end

function machineView:updateGUI()
  local colors = self.colors

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
    if ( v.sinks ) then
      v:drawCtrls()
    end
  end
end

function machineView:loadTracks()
  local self = machineView
  
  -- Flag tracks as not being found yet
  for i,v in pairs( self.tracks ) do
    if ( v.isMaster ) then
    else
      v.found = 0
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
        self:addTrack(track, math.floor(math.random()*gfx.w), math.floor(math.random()*gfx.h))
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
    v:updateSinks()
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
  for c = 1,5 do
    local fx, fy = self:calcForces()
    for i,v in pairs( self.tracks ) do
      if ( not onlyFree or (not v.fromSave) ) then
        v.x = 2 * v.x - xl[i] + fx[i] * dt
        v.y = 2 * v.y - yl[i] + fy[i] * dt
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
  
  local xx, xy, sx, sy, rx, ry
  local k = 1e-2
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

  return fx, fy
end

local function Main()
  local self = machineView
  local reaper = reaper
  
  self:loadColors("default")  
  local v = self:addTrack(reaper.GetMasterTrack(0), math.floor(.5*gfx.w), math.floor(.5*gfx.h))
  v.isMaster = 1
  v.name = "MASTER"  
  self:loadTracks()
  self:loadPositions()  
  
  gfx.init("Hackey Machines", self.config.width, self.config.height, 0, self.config.x, self.config.y)

  reaper.defer(updateLoop)
end

function machineView:storePositions()
  for i,v in pairs(self.tracks) do
    reaper.SetProjExtState(0, "MVJV001", i.."x", tostring(v.x))
    reaper.SetProjExtState(0, "MVJV001", i.."y", tostring(v.y))
  end
  
  reaper.SetProjExtState(0, "MVJV001", "ox", tostring(origin[1]))
  reaper.SetProjExtState(0, "MVJV001", "oy", tostring(origin[2]))
  reaper.SetProjExtState(0, "MVJV001", "zoom", tostring(zoom))  
  
  reaper.SetProjExtState(0, "MVJV001", "gfxw", tostring(gfx.w))
  reaper.SetProjExtState(0, "MVJV001", "gfxh", tostring(gfx.h))
end

function machineView:loadPositions()
  for i,v in pairs(self.tracks) do
    local ok, x = reaper.GetProjExtState(0, "MVJV001", i.."x")
    local ok, y = reaper.GetProjExtState(0, "MVJV001", i.."y")
    if ( ok and tonumber(x) ) then
      v.x = tonumber(x)
      v.y = tonumber(y)
      v.fromSave = 1
    end
    
    self.iterFree = 50
  end
  
  local ox, oy, z
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "ox")
  if ( ok ) then ox = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "oy")
  if ( ok ) then oy = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "zoom")  
  if ( ok ) then z = tonumber( v ) end
  
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "gfxw")  
  if ( ok ) then gfxw = tonumber( v ) end
  local ok, v = reaper.GetProjExtState(0, "MVJV001", "gfxh")  
  if ( ok ) then gfxh = tonumber( v ) end
    
  origin[1] = ox or origin[1]
  origin[2] = oy or origin[2]
  zoom      = z or zoom
  
  self.config.width = gfxw or self.config.width
  self.config.height = gfxh or self.config.height
end

Main()

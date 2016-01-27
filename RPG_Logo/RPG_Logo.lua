--[[
RPG Logo animation (based on 1280x720)
Load with the time for each animation and an optional callback:
 - t1: logo fadeIn time
 - t2: logo wait time
 - t3: logo fadeOut
 - callback: a function to be called when logo presentation is over
 
 This script calls the callback when the animation ends or when the ENTER key is pressed
 To know when it is finished from other script you can access RPG_Logo.finish
 ]]
 
RPG_Logo={}
local logoDist = 0.9
local letterDist = 0.03
local fadeMax = 240
local endLogo

local getScale, fadeIn, wait, fadeOut, step

function RPG_Logo.load(t1,t2,t3,callback)
  RPG_Logo.logo=love.graphics.newImage("/logo.png")
  RPG_Logo.width=RPG_Logo.logo:getWidth()
  RPG_Logo.height=RPG_Logo.logo:getHeight()
  RPG_Logo.scale = getScale(RPG_Logo.width,RPG_Logo.height)
  RPG_Logo.width = RPG_Logo.scale*RPG_Logo.width
  RPG_Logo.height = RPG_Logo.scale*RPG_Logo.height
  
  RPG_Logo.pos={
    x=(love.graphics.getWidth()-RPG_Logo.width)/2,
    y=(love.graphics.getHeight()-RPG_Logo.height)/2
  }
  
  RPG_Logo.a1=t1
  RPG_Logo.a2=t2
  RPG_Logo.a3=t3
  RPG_Logo.a4=t4
  RPG_Logo.fadeOut = fadeMax
  RPG_Logo.finish=false
  RPG_Logo.callback = callback

  RPG_Logo.vel1 = fadeMax/t1
  RPG_Logo.vel2 = fadeMax/t3
  RPG_Logo.fade = 0
  step = fadeIn
end

function getScale(width,height)
  local w = love.graphics.getWidth()*0.6
  local h = love.graphics.getHeight()*0.6
  local sw,sh = w/width, h/height
  local s = sw < sh and sw or sh
  return s
end

function RPG_Logo.start()
end

function RPG_Logo.update(dt)
  
  step(dt)
  
end

function fadeIn(dt)
  RPG_Logo.a1 = RPG_Logo.a1-dt
  if RPG_Logo.a1<0 then
    RPG_Logo.fade = fadeMax
    step = wait
  else
    RPG_Logo.fade = RPG_Logo.fade + dt*RPG_Logo.vel1
  end
end
function wait(dt)
  RPG_Logo.a2 = RPG_Logo.a2-dt
  if RPG_Logo.a2<0 then
    step = fadeOut
  end
end
function fadeOut(dt)
  RPG_Logo.a3 = RPG_Logo.a3-dt
  if RPG_Logo.a3<0 then
    RPG_Logo.fade = 0
    RPG_Logo.callback()
  else
    RPG_Logo.fade = RPG_Logo.fade - dt*RPG_Logo.vel1
  end
end

function RPG_Logo.draw()
  love.graphics.setColor(255,255,255,RPG_Logo.fade)
  love.graphics.draw(RPG_Logo.logo,RPG_Logo.pos.x,RPG_Logo.pos.y,0,RPG_Logo.scale,RPG_Logo.scale)
end

function RPG_Logo.keypressed(key)
  if key=="return" then
    endLogo()
  end
end

function endLogo()
  RPG_Logo.finish = true
  if RPG_Logo.callback ~= nil then
	RPG_Logo.callback()
	end
end
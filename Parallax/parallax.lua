--  The MIT License (MIT)
--  Copyright © 2016 Pietro Ribeiro Pepe.

--  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-- Script to help implementing Parallax background
-- Version 2.0 - 2016/04/22

Parallax = {}

function Parallax.new(listOfMaps)
  local self = {}
  setmetatable(self,{__index=Parallax})
  for i,v in ipairs(listOfMaps) do
    local t = {position=0,scale={x = v.width / v.image:getWidth(),
      y = v.height / v.image:getHeight()}}
    for j,w in pairs(v) do t[j] = w end
    table.insert(self,t)
  end
  return self
end

function Parallax:update(dt, mov)
  if mov == nil then mov = 1 end
  for i,v in ipairs(self) do
    v.position = v.position + v.speed*mov*dt
    if v.position > v.width then
      v.position = v.position%v.width
    end
  end
end

function Parallax:draw()
  for i,v in ipairs(self) do
    local pos = v.position
    love.graphics.draw(v.image, -pos, 0, 0, v.scale.x, v.scale.y)
    love.graphics.draw(v.image, v.width-pos, 0, 0, v.scale.x, v.scale.y)
  end
end
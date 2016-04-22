--  The MIT License (MIT)
--  Copyright © 2016 Pietro Ribeiro Pepe.

--  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-- Script to help managing animation
-- Version 2.0 - 2016/04/22

AnimationManager = {}

function AnimationManager.new(qFrames, animTime, doRepeat)
  local self = {}
  setmetatable(self,{__index=animationManager})
  self.time = animTime
  self.capTime = animTime / qFrames
  self.qFrames = qFrames
  self.canRepeat = (doRepeat==nil or doRepeat==true)
  self:restart()
  return self;
end

function AnimationManager:update(dt)
  self.curr_time = self.curr_time + dt
  if self.curr_time > self.capTime then
    self.curr_time = self.curr_time - self.capTime
    self.curr_frame = self.curr_frame+1
    if self.curr_frame > self.qFrames then
      if not self.canRepeat then
        self.curr_frame = self.qFrames
        self.finished = true
        return -1
      else
        self.curr_frame = 1
      end
    end
  end
  return self.curr_frame
end

function AnimationManager:restart()
  self.curr_frame = 1
  self.curr_time = 0
  self.finished = false
end
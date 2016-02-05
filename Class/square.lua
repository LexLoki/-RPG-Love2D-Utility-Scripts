require "rectangle"

Square = class_extends(Rectangle)

function Square.new(x,y,size)
  local self = Square.newObject(x,y,size,size)
  self.size = size
  return self
end

function Square:name()
  return "Square"
end

function Square:print()
  print(self:name() .. "{")
  print("\tx = " .. self.x)
  print("\ty = " .. self.y)
  print("\tsize = " .. self.size .."\n}")
end
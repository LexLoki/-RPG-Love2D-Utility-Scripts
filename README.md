# -RPG-Love2D-Utility-Scripts
This is a collection of Lua scripts made for LÖVE game development, used by the RPG - Rio PUC Games game development group
* Class
* AnimationManager
* Parallax
* Scripts to show our logo

## Class
Script to simulate class and inheritance in Lua
#### How to use:
Load the library:
```Lua
  class = require 'class'
```
Initialize a base class using:
```Lua
  myClass = class.new("myClassName")
```
When creating a new instance, you need to first initialize it with:
```Lua
  local self = myClass.newObject()
  -- Set properties and return self
```
If you pretend to subClass the class, implement the instance creation method as .new

Initialize a subclass (of myClass):
```Lua
  subClass = class.extends(myClass,"subClassName")
```
When creating a new instance for the subClass, you need to first initialize it:
```Lua
  local self = subClass.newObject(PASS HERE THE PARAMETERS OF THE SUPERCLASS.NEW) --The script calls myClass.new with these
```
####Availables methods of an instance of a class created with this script
*  :class() - Returns the class of the instance
*  :name() - Returns the name of the instance's class, or "unknown" if no name was given
*  :superClass() - Returns the superClass of the instance's class, or NIL if it doesn't have one
*  :superClasses() - Returns an array with all the superClassses
*  :is_a(class) - Checks if the instance is of the given class, or a subclass of it

####Availables properties of an instance of a class created with this script
*  .super - Reference to the superClass instance "part" of the instance (used as self.super:someMethod() to call a method defined in the superClass)
  
####Example
Below there is a simple example using a base class, a sub class and overriding a method, there are more examples in the `Class` folder
```Lua
local class = require "class"
myClass = class.new("myClassName")
function myClass.new(a,b,c)
  local self = myClass.newObject()
  self.a = a
  self.b = b
  self.c = c
end
function myClass:getPower()
  return self.a + self.b + self.c
end
 
subClass = class.extends(myClass,"myClassName")
function subClass.new(a,multiplier)
  local self = subClass.newObject(a,a*2,a*3) --Initializes a new object using the .new from the superClass (myClass)
  self.multiplier = multiplier
  return self
end
function subClass:getPower() --overrides the function from the superClass (myClass)
  return self.multiplier * self.super:getPower()
end
```

##AnimationManager
To manage sprite animation (know what frame of the animation you want to reproduce each time), you need to provide to the `AnimationManager.new` function:
* qFrames: number of frames of the animation
* animTime: the duration time desired for the animation
* doRepeat: a boolean to state if the animation should loop, when not given, the default is TRUE
  
Run the `:update(dt)` function to update the manager.
  
To know the actual frame of an animationManager just access the curr_frame property.
  
If you stop updating the animation and then need to run again, call the `:restart` function (to put the curr_frame back to 1).
  
###Code example:
```Lua
  require "AnimationManager"
  local runSpriteSheet
  local runQuads
  local myManager
  
  function love.load()
    runSpriteSheet = love.graphics.newImage("runSheet.png")
    runQuads = {
      love.graphics.newQuad(0,0,20,20),
      love.graphics.newQuad(20,0,20,20),
      love.graphics.newQuad(40,0,20,20),
      love.graphics.newQuad(60,0,20,20)
    }
    myManager = animationManager_new(4,0.6)
    -- manager loaded ready for loop
  end
  
  function love.update(dt)
    myManager:update(dt)
  end
  
  function love.draw()
    local actualFrame = myManager.curr_frame
    love.graphics.draw(runSpriteSheet,runQuads[actualFrame])
  end
```

##Parallax
Script to help implementing horizontal Parallax effect

####How to use:
`Parallax.new` requires an array of maps V with each map having:
  - image: The image of the plane
  - speed: Speed of the moving map (tiles per second)
  - width: Width desirable for the map, in points
  - height: Width desirable for the map, in points

Call `:update(dt,mov)` to update the Parallax movement, where mov is a factor that alters the speed (mov=2 will double the speed, mov=0.25 will divide it by 4). When not given, the default is 1.

The order is important, the deepest map goes first in the array
####Code example:
```Lua
  require "Parallax"
  local parallaxBackground
  
  function love.load()
    local screenWidth,screenHeight = love.graphics.getDimensions()
    local planeDeep = {
     image = love.graphics.newImage("planoDeep.png"),
      speed = screenWidth/5,
      width = screenWidth,
      height = screenHeight
    }
    local planeBackground = {
      image = love.graphics.newImage("planoBackground.png"),
      speed = screenWidth/2,
      width = screenWidth,
      height = screenHeight
    }
    local mapsVector = {planeDeep, planeBackground}
    parallaxBackground = Parallax.new(mapsVector)
  
  function love.update(dt)
    -- IF YOU WANT TO MOVE WITH THE DEFAULT SPEED, DOES NOT NEED THE PARAMETER mov
    parallaxBackground:update(dt)
    -- MOV parameter, again, is to change somehow the SPEED, for example, make the parallax move 50% slower -> mov = 0.5
    --parallaxBackground:update(dt,0.5)
  end
  
  function love.draw()
    parallaxBackground:draw()
  end
  ```

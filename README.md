# -RPG-Love2D-Utility-Scripts
This is a collection of Lua scripts made for LÖVE game development, used by the RPG - Rio PUC Games game development group
* Class
* Parallax
* Scripts to show our logo

## Class
Script to simulate class and inheritance in Lua
#### How to use:

Initialize a base class using:
```Lua
  myClass = class_new("myClassName")
```
When creating a new instance, you need to first initialize it with:
```Lua
  local self = myClass.newObject()
  -- Set properties and return self
```
If you pretend to subClass the class, implement the instance creation method as .new
Initialize a subclass (of myClass):
```Lua
  subClass = class_extends(myClass,"subClassName")
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
myClass = class_new("myClassName")
function myClass.new(a,b,c)
  local self = myClass.newObject()
  self.a = a
  self.b = b
  self.c = c
end
function myClass:getPower()
  return self.a + self.b + self.c
end
 
subClass = class_extends(myClass,"myClassName")
function subClass.new(a,multiplier)
  local self = subClass.newObject(a,a*2,a*3)
  self.multiplier = multiplier
  return self
end
function subClass:getPower()
  return self.multiplier * self.super:getPower()
end
```

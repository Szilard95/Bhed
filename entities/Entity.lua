require 'lib.middleclass'

local bump = require 'lib.bump'

local entities = {}

local Entity = class('Entity')

local entityCounter = 0

local function copy(t)
  local c = {}
  for k,v in pairs(t) do c[k] = v end
  return c
end

function Entity:initialize(x,y,i,hp)
  self.img = love.graphics.newImage(i)
  if not self.dir then self.dir = 0 end
  self.w = self.img:getWidth()
  self.h = self.img:getHeight()
  
  self.x, self.y = x,y

  self.hp = hp
  
  entities[self] = true
  self.id = entityCounter
  entityCounter = entityCounter + 1
  bump.add(self)
end

function Entity:destroy()
  bump.remove(self)
  entities[self] = nil
end

function Entity:update(dt)
end

function Entity:damage(d)
  if not self.hp then return end
  self.hp = self.hp - d
  if self.hp <= 0 then self:destroy() end
end

function Entity:collision(other, dx, dy)
    if instanceOf(Block, other)or instanceOf(Player, other) or instanceOf(Entity,other) then
    --if dx ~= 0 or dy~=0 then
    --    if self.speed > 0+love.timer.getDelta()*50 then self.speed = self.speed - love.timer.getDelta()*50 end
    --end 
    self.x = self.x + dx
    self.y = self.y + dy
  end
end

function Entity:endCollision(other)
end

function Entity:shouldCollide(other)
  return true
end

function Entity:draw()
  love.graphics.draw(self.img,self.x,self.y,math.rad(self.dir*45),1,1,self.dim/2,self.dim/2)
end

function Entity:getBBox()
  return self.x-self.dim/2, self.y-self.dim/2, self.w, self.h
end

function Entity:getCenter()
  return self.x + self.w/2, self.y + self.h/2
end

function Entity:getX()
  return self.x
end
function Entity:getY()
  return self.y
end
function Entity:getHP()
  return self.hp
end
function Entity:getImg()
  return self.img
end
function Entity:notDead()
  return entities[self]
end

function Entity:outOfScreen()
  if self.x<0 or self.x > screen.width or self.y<0 or self.y > screen.height then return true end
end


function Entity.static:destroyAll()
  for entity,_ in pairs(entities) do
    entity:destroy()
  end
end
function Entity.static:updateAll(dt)
  for entity,_ in pairs (entities) do
    entity:update(dt)
  end
end
function Entity.static:drawAll()
  for entity,_ in pairs(entities) do
    entity:draw()
  end
end

return Entity
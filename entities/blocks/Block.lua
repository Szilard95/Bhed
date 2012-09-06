--[[

]]--

local bump = require 'lib.bump'
local entity = require 'entities.Entity'

Block = class('Block', entity)

function Block:initialize(x,y,img,hp)
	self.dim = 0
	entity.initialize(self,x,y,img,hp)
	bump.addStatic(self)
end

function Block:shouldCollide(other)
	return false
end
function Block:collision(other, dx, dy)
	return
end
return Block
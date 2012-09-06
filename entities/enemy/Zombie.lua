--[[

	]]--

local Enemy = require 'entities.enemy.Enemy'

Zombie = class('Zombie', Enemy)

local hp = 75
local img = "/res/Zombie.png"

function Zombie:initialize(x,y)
	self.dim = dims['enemy']
	self.dmg = 10
	self.speed = 75
	self.rate = 2
	self.val = 100
	self.mul = 1
	Enemy.initialize(self,x,y,img,hp)
end

return Zombie
--[[

	]]--

local Enemy = require 'entities.enemy.Enemy'

 Zombie = class('Zombie', Enemy)

local sHP = 75
local img = "/res/Zombie.png"

function Zombie:initialize(x,y,cHP)
	self.dim = dims['enemy']
	self.dmg = 10
	self.speed = 50
	self.rate = 2
	self.val = 100
	self.mul = 1
	Enemy.initialize(self,x,y,img,sHP)
	if cHP ~= nil then self.hp = cHP end
end

return Zombie
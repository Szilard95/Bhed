--[[

]]--

local Block = require 'entities.blocks.Block'

local img = "/res/Barrel.png"

Barrel = class('Barrel', Block )

function Barrel:initialize(x,y,...)
	self.scale = 0.5
	self.explosionRadius = 25
	self.explosionDamage = 30
	if #arg == 2 then Block.initialize(self,x,y,arg[1],arg[2])
	else
		Block.initialize(self,x,y,"/res/Barrel.png",1)
	end
	THIS = self.w
end

function Barrel:damage(d,owner)
  if not self.hp then return end
  self.hp = self.hp - d
  self.owner = owner
  if self.hp <= 0 then self:explode(self.explosionRadius,self.explosionDamage) end
end


return Barrel
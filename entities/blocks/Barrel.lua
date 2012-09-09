--[[

]]--

local Block = require 'entities.blocks.Block'

local img = "/res/Barrel.png"

Barrel = class('Barrel', Block )

function Barrel:initialize(x,y,...)
	--self.scale = 0.5
	self.explosionRadius = 40
	self.explosionDamage = 30
	if #arg == 2 then Block.initialize(self,x,y,arg[1],arg[2])
	else
		Block.initialize(self,x,y,"/res/Barrel.png",1)
	end
end

function Barrel:damage(d,owner)
  self.owner = owner
  self:explode(self.explosionRadius,self.explosionDamage)
end


return Barrel
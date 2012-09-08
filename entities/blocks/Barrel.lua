--[[

]]--

local Block = require 'entities.blocks.Block'

local img = "/res/Barrel.png"

Barrel = class('Barrel', Block )

function Barrel:initialize(x,y,...)
	self.scale = 0.5
	if #arg == 2 then Block.initialize(self,x,y,arg[1],arg[2])
	else
		Block.initialize(self,x,y,"/res/Barrel.png",100)
	end
	THIS = self.w
end



return Barrel
--[[

]]--

local Block = require 'entities.blocks.Block'

local img = "/res/Barrel.png"

Barrel = class('Barrel', Block )

function Barrel:initialize(x,y,...)
	if #arg == 2 then Block.initialize(self,x,y,arg[1],arg[2])
	else
		Block.initialize(self,x,y,"/res/Barrel.png",100)
	end
end



return Barrel
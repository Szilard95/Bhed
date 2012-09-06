--[[

]]--

local Block = require 'entities.blocks.Block'

Wall = class('Wall', Block )

function Wall:initialize(x,y,...)
	if #arg == 2 then Block.initialize(self,x,y,arg[1],arg[2])
	else
		Block.initialize(self,x,y,"/res/Wall.png",nil)
	end
end

return Wall
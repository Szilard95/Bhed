--[[

]]--

local Block = require 'entities.Blocks.Block'

local img = "/res/Barrier.png"

Barrier = class('Barrier', Block )

function Barrier:initialze(x,y,...)
	if #arg == 2 then Block.initialize(self,x,y,arg[1],arg[2])
	else
		Block.initialize(self,x,y,"/res/Barrier.png",1000)
	end
end

return Barrier
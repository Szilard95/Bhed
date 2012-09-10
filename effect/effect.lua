require 'lib.middleclass'

local Effect = class('Effect')
local effects = {}
local effectCounter =  0

function Effect:initialize(ptype)
	effects[self]=true
	self.id = effectCounter
	self.name = ptype
  effectCounter = effectCounter + 1
end


function Effect:destroy()
	effects[self]=nil
end

function Effect:update(dt)	
end

function Effect:draw()
end

function Effect.static:drawAll()
  for eff,_ in pairs(effects) do
    eff:draw()
  end
end

function Effect.static:updateAll(dt)
  for eff,_ in pairs (effects) do
    eff:update(dt)
  end
end
return Effect
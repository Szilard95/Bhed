--[[
	particle system
--]]

local tEffect = require 'effect.effect'

 PSys = class('PSys',tEffect)

function PSys:initialize(x,y,ptype)
	self.x = x
	self.y = y
	--if ptype == 'explosion' then
		tEffect.initialize(self,ptype)
		self.sprite = love.graphics.newImage('/res/frag.png')
		self.p = love.graphics.newParticleSystem( self.sprite, 1000 )
		self.p:setEmissionRate(500)
		self.p:setSpeed(300,300)
		self.p:setGravity(0)
		self.p:setSizes(1, 1)
		--self.p:setColors(255, 255, 255, 255, 58, 128, 255, 0)
		self.p:setPosition(self.x, self.y)
		self.p:setLifetime(0.1)
		self.p:setParticleLife(0.18)
		self.p:setDirection(0)
		self.p:setSpread(360)
		self.p:setRadialAcceleration(100)
		self.p:setTangentialAcceleration(0)
		self.p:start()
	--end
end

function PSys:update(dt)
	self.p:update(dt)
	--if self.p:isEmpty() then self.p:stop() self:destroy() end
end

function PSys:draw()
	love.graphics.draw(self.p,0,0)
end

function PSys:start()
	self.p:start()
end
return PSys
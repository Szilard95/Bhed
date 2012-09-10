require 'lib.middleclass'

 Timer = class('Timer')
local timers = {}
local timerCounter = 0
function Timer:initialize(rate)
	timers[self] = true
	timerCounter = timerCounter + 1
	self.id = timerCounter
	self.t = nil
	self.rate = rate
end

function Timer:trigger()
	if self.t >= unit/self.rate then return true end
	return false
end

function Timer:start()
	self.t = 0
end

function Timer:stopped()
	if self.t == nil then return true end
	return false
end

function Timer:stop()
	self.t = nil
end

function Timer:update(dt)
	if self.t ~= nil then self.t = self.t+dt end
end

function Timer:getT()
	return self.t
end

function Timer:reset()
	self.t = 0
end

function Timer.static:updateAll( dt )
	for timer,_ in pairs(timers) do
		timer:update(dt)
	end
end

return Timer
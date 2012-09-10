local entity = require 'entities.Entity'

 PickUp = class('PickUp',entity)

function PickUp:initialize(x,y)
	self.dim = dims['pickup']
	entity.initialize(self,x,y,'/res/PickUp.png',nil)
	self.ammo = math.floor(math.random(10,50))
end

function PickUp:shouldCollide(other)
	return false
end

function PickUp:collision(other, dx, dy)
return
end

return PickUp
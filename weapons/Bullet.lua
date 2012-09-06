local entity = require 'entities.Entity'

--local img = "/res/Bullet.png"
local bSpeed = 700

Bullet = class ('Bullet', entity)

function Bullet:initialize(x,y,dir,dmg,owner)
	self.dim = dims['bullet']
	entity.initialize(self,x,y,"/res/Bullet.png", nil)
	self.dmg = dmg
	self.dir = dir
	self.owner = owner
end

function Bullet:shouldCollide(other)
if instanceOf(Bullet,other)or instanceOf(PickUp,other) then return false end
return true 
end

function Bullet:update(dt)	
	if self:outOfScreen() then self:destroy() end
	if self.dir == 0 then 
		self.y = self.y-bSpeed*dt
	elseif self.dir == 1 then
		self.x = self.x+bSpeed*dt
		self.y = self.y-bSpeed*dt
	elseif self.dir == 2 then
		self.x = self.x+bSpeed*dt
	elseif self.dir == 3 then
		self.x = self.x+bSpeed*dt
		self.y = self.y+bSpeed*dt
	elseif self.dir == 4 then
		self.y = self.y+bSpeed*dt
	elseif self.dir == 5 then
		self.x = self.x-bSpeed*dt
		self.y = self.y+bSpeed*dt
	elseif self.dir == 6 then
		self.x = self.x-bSpeed*dt	
	elseif self.dir == 7 then
		self.x = self.x-bSpeed*dt
		self.y = self.y-bSpeed*dt
	end
end

function Bullet:collision( other,dx,dy )
	if other ~= self.owner then
	other:damage(self.dmg)
	if not other:notDead() and other.val ~= nil then
		self.owner:setScore(other.val)
		self.owner:setMul(other.mul)
	end
	self:destroy()
	end
end

return Bullet
--[[

]]--

require 'lib.middleclass'
local Bullet = require 'weapons.Bullet'
local Timer = require 'lib.timer'

Weapon = class('Weapon')

function Weapon:initialize(rate,dmg,ammo,range,maxAmmo)
	self.range = range
	self.rate = rate
	self.dmg = dmg
	self.ammo = ammo
	self.maxAmmo = maxAmmo
	self.timer = Timer:new(self.rate)
	self.timer:start()
end

function Weapon:fire(x,y,dir,owner)
	if self.timer:trigger() then
	if self.ammo == nil then
	Bullet:new(x,y,dir,self.dmg,owner,self.range)
	elseif self.ammo > 0 then
	self.ammo = self.ammo -1
	Bullet:new(x,y,dir,self.dmg,owner,self.range)
	end
	self.timer:reset()
	end
end

function Weapon:getRate()
	return self.rate
end

function Weapon:getDmg()
	return self.dmg
end

function Weapon:setAmmo(value)
	if self.maxAmmo-self.ammo <= value then self.ammo = self.maxAmmo
		else self.ammo = self.ammo + value
	end
end

function Weapon:getAmmo()
	if self.ammo == nil then return 'infinite' end
	return self.ammo
end

return Weapon
--[[ Gyureee spread előkészítés
function Weapon:fire(x,y,dir,owner)
	if self.timer:trigger() then
	if self.ammo == nil then
	Bullet:new(x,y,dir,self.dmg,owner,self.range)
	elseif self.ammo > 0 then
	self.ammo = self.ammo -1
	Bullet:new(x,y,dir,self.dmg,owner,self.range)
	end
	self.timer:reset()
	end
end

]]--
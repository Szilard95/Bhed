
--[[

]]--
local Weapon = require "weapons.Weapon"
local dmg = 37
local rate = 0.8
local ammo = 7
local maxAmmo = 14
local range = 310
 Deagle = class('Deagle', Weapon)

function Deagle:initialize()
	Weapon.initialize(self,rate,dmg,ammo,range,maxAmmo)
	self.name = "Deagle"
end

return Deagle
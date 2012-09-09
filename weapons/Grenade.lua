
--[[

local  Weapon = require "weapons.Weapon"
local dmg = 5
local rate = 15
local ammo = 35
local range = 300
Grenade = class('Grenade', Weapon)

function Grenade:initialize()
	Weapon.initialize(self,rate,dmg,ammo,range)
	self.name = "Grenade"
end

return Grenade

]]--
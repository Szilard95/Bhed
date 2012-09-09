
--[[

]]--
local  Weapon = require "weapons.Weapon"
local dmg = 5
local rate = 15
local ammo = 35
local range = 300
Smg = class('Smg', Weapon)

function Smg:initialize()
	Weapon.initialize(self,rate,dmg,ammo,range)
	self.name = "smg"
end

return Smg
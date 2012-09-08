
--[[

]]--
local  Weapon = require "weapons.Weapon"
local dmg = 5
local rate = 15
local ammo = 35
Smg = class('Smg', Weapon)

function Smg:initialize()
	Weapon.initialize(self,rate,dmg,ammo)
	self.name = "smg"
end

return Smg
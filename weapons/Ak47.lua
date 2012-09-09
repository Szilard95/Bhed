
--[[

]]--
local  Weapon = require "weapons.Weapon"
local dmg = 9
local rate = 10
local ammo = 25
local range = 370
Ak47 = class('Ak47', Weapon)

function Ak47:initialize()
	Weapon.initialize(self,rate,dmg,ammo,range)
	self.name = 'ak47'
end

return Ak47
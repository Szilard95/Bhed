
--[[

]]--
local  Weapon = require "weapons.Weapon"
local dmg = 9
local rate = 10
local ammo = 30
local maxAmmo = ammo*2
local range = 370
 Ak47 = class('Ak47', Weapon)

function Ak47:initialize()
	Weapon.initialize(self,rate,dmg,ammo,range,maxAmmo)
	self.name = 'ak47'
end

return Ak47
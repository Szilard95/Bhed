
--[[

]]--
local Weapon = require "weapons.Weapon"
local dmg = 20
local rate = 2
local ammo = nil

Pistol = class('Pistol', Weapon)

function Pistol:initialize()
	Weapon.initialize(self,rate,dmg,ammo)
	self.name = "pistol"
end

function Pistol:setAmmo(value)
	return
end

return Pistol
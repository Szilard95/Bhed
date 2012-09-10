--[[
	Gyureee
]]--
local  Weapon = require "weapons.Weapon"
local dmg = 9
local rate = 2
local ammo = 6
local maxAmmo = ammo*5
local range = 370
--[[
local spread = 45
local bps = 10
]]--
local pShotgun = class('pShotgun', Weapon)

function pShotgun:initialize()
	Weapon.initialize(self,rate,dmg,ammo,range,maxAmmo)
	self.name = 'pShotgun'
end

return pShotgun

--[[ Gyureee (Spread előkészítés)
function pShotgun:initialize()
	Weapon.initialize(self,rate,dmg,ammo,range,maxAmmo,spread,bps)
	self.name = 'pShotgun'
end

return pShotgun

]]--
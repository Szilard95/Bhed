local entity = require 'entities.Entity'
local timer = require 'lib.timer'
local pistol = require 'weapons.Pistol'
local smg = require 'weapons.Smg'
local ak47 = require 'weapons.Ak47'

require 'entities.blocks.Block'


Player = class('Player', entity)

local p1_cont = {up='w', right='d', down='s', left='a', fire=' '}
local p2_cont = {up='up', right='right', down='down', left='left', fire='rctrl'}
local isDown = love.keyboard.isDown
local accVelo = 450
local breakVelo = 600
local minSpeed = 5
local maxSpeed = 165
local maxHP = 100
local regenRate = 0.28 --3.5s
local regenHP = 5

function Player:initialize(x,y,n,...)
	self.dim = dims['player']
	self.regenTimer = timer:new(regenRate)
	self.mulTimer = timer:new(0.4)
	self.wPistol = pistol:new()
	self.wSmg = smg:new()
	self.wAk47 = ak47:new()
	self.weapons = {self.wPistol, self.wSmg, self.wAk47}
	self.number = n
	self.speed = 0
	self.dir = 0
	self.score = 0
	self.mul = 1
	self.weapon = self.weapons[1]
	self.weaponNum = 1
	if #arg == 2  then Entity.initialize(self,x,y,arg[1],arg[2])
	else
		entity.initialize(self,x,y,"/res/Player.png",100)
	end
	if n == 1 then self.act = p1_cont else self.act = p2_cont end
	self.regenTimer:start()
end

function Player:update(dt)

	if self.regenTimer:trigger() and self.hp<maxHP then
		if maxHP-self.hp <= regenHP then self.hp = maxHP
		else self.hp = self.hp + regenHP
		end
		self.regenTimer:reset()
	end

	if self.mul > 1 and self.mulTimer:stopped() then
		self.mulTimer:start()
	end

	if self.mul == 1 then self.mulTimer:stop() end

	if not self.mulTimer:stopped() and self.mulTimer:trigger() then
		self:setMul(-1)
	end

	if isDown(self.act['up'])or isDown(self.act['right'])or isDown(self.act['down'])or isDown(self.act['left']) then
	self.speed = self.speed + accVelo * dt
	if self.speed > maxSpeed then self.speed = maxSpeed end
	else
		self.speed = self.speed - breakVelo * dt
		if self.speed < minSpeed then self.speed = 0 end
		if not self.speed then Player:moveToDir(dt) end
	end
	if isDown(self.act['up']) then
		self.dir = 0
	end
	if isDown(self.act['right']) then
		self.dir = 2
	end
	if isDown(self.act['up'])and isDown(self.act['right']) then 
		self.dir = 1 
	end
	if isDown(self.act['down']) then
		self.dir = 4
	end
	if isDown(self.act['right'])and isDown(self.act['down']) then
		self.dir = 3
	end
	if isDown(self.act['left']) then
		self.dir = 6
	end
	if isDown(self.act['down'])and isDown(self.act['left']) then 
		self.dir = 5 
	end	
	if isDown(self.act['up'])and isDown(self.act['left']) then 
		self.dir = 7 
	end
	if isDown(self.act['fire']) then
		self:fire(self.x + self.w/2,self.y + self.h/2, self.dir)
	end
	--if -> benn kell tartani a képernyön?
	if self.dir == 0 then
		self.y = self.y - dt * self.speed
	elseif self.dir == 1 then
		self.y = self.y - dt * self.speed
		self.x = self.x + dt * self.speed
	elseif self.dir == 2 then
		self.x = self.x + dt * self.speed
	elseif self.dir == 3 then
		self.x = self.x + dt * self.speed
		self.y = self.y + dt * self.speed
	elseif self.dir == 4 then
		self.y = self.y + dt * self.speed
	elseif self.dir == 5 then
		self.y = self.y + dt * self.speed
		self.x = self.x - dt * self.speed
	elseif self.dir == 6 then
		self.x = self.x - dt * self.speed
	elseif self.dir == 7 then
		self.y = self.y - dt * self.speed
		self.x = self.x - dt * self.speed
	end
end

function Player:fire(x,y,dir)
	self.weapon:fire(self.x,self.y,dir,self)
end

function Player:getDirection()
	return self.dir
end

function Player:getSpeed()
	return self.speed
end

function Player:getCurrWeapon()
	return self.weapon.name
end

function Player:getAmmo()
	return self.weapon:getAmmo()
end

function Player:getScore()
	return self.score
end

function Player:getMul()
	return self.mul
end

function Player:nextWeapon()
	if self.weaponNum >= #self.weapons then
		self.weaponNum = 1
	else
		self.weaponNum = self.weaponNum + 1
	end
		self.weapon = self.weapons[self.weaponNum]
end

function Player:keypressed(key)
	if self.number == 1 then
		if key == 'q' then
			self:nextWeapon()
		end
	else
		if key == 'rshift' then
			self:nextWeapon()
		end
	end
end

function Player:shouldCollide(other)
	if instanceOf(Block, other) or instanceOf(Player, other) or instanceOf(PickUp, other) then return true end
end

function Player:collision(other, dx, dy)
    if instanceOf(Block, other)or instanceOf(Player, other) then
    if dx ~= 0 or dy~=0 then
        if self.speed > 0+love.timer.getDelta()*50 then self.speed = self.speed - love.timer.getDelta()*50 end
    end 
    self.x = self.x + dx
    self.y = self.y + dy
  end
  if instanceOf(PickUp, other) then
  	self.weapon:setAmmo(other.ammo)
  	other:destroy()
  end
  if instanceOf(Enemy,other) then self.regenTimer:reset() end
end

function Player:setMul(val)
	self.mulTimer:reset()
	if val > 0 then
	self.mul = self.mul + val
	elseif self.mul > 0 then
	self.mul = self.mul + val
	end
end

function Player:setScore(val)
	self.score = self.score + self.mul * val
end


return Player
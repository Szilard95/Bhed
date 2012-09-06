local entity = require 'entities.Entity'
local timer = require 'lib.timer'
Enemy = class('Enemy', entity)

local function sign(x)
  return x < 0 and -1 or (x > 0 and 1 or 0)
end

local function eq(a,b)
	if #a ~= #b then return false end
	for x=1,#a do
		if a[x] ~= b[x] then return false end
	end
	return true
end

function Enemy:initialize(x,y,img,hp,speed)
	self.timer = timer:new(self.rate)
	self.timer:start()
	self.target = Enemy:chooseTarget()
	self.dim = dims['enemy']
	entity.initialize(self,x,y,img,hp)
end

function Enemy:update(dt)
	if not self.target:notDead() then
  		table.remove(livingPlayers, #self.target)
  		self.target = Enemy:chooseTarget()
  	end
	self:setDir(self.target:getX(),self.target:getY())
	self:goToDir(dt)
end

function Enemy:setDir(x,y)
	local tx = sign(math.floor(x)-math.floor(self.x))
	local ty = sign(math.floor(y)-math.floor(self.y))
	if eq({tx,ty},{0,-1}) then self.dir = 0
	elseif eq({tx,ty},{1,-1}) then self.dir = 1
	elseif eq({tx,ty},{1,0}) then self.dir = 2
	elseif eq({tx,ty},{1,1}) then self.dir = 3
	elseif eq({tx,ty},{0,1}) then self.dir = 4
	elseif eq({tx,ty},{-1,1}) then self.dir = 5
	elseif eq({tx,ty},{-1,0}) then self.dir = 6
	elseif eq({tx,ty},{-1,-1}) then self.dir = 7
		else self.dir = self.dir end

end

function Enemy:goToDir(dt)
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

function Enemy.static:chooseTarget()
	if #livingPlayers > 1 then 
		return livingPlayers[math.floor(math.random(1,#livingPlayers))]
	elseif	#livingPlayers > 0 then return livingPlayers[1] end
end

function Enemy:collision(other, dx, dy)
    if instanceOf(Block, other)or instanceOf(Player, other) or instanceOf(Enemy,other) then
    --if dx ~= 0 or dy~=0 then
    --    if self.speed > 0+love.timer.getDelta()*50 then self.speed = self.speed - love.timer.getDelta()*50 end
    --end 
    self.x = self.x + dx
    self.y = self.y + dy
  end
  	if instanceOf(Player, other) then
  		if self.timer:trigger() then
  			other:damage(self.dmg)
  			self.timer:reset()
  		end
  	end
end

return Enemy
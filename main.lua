--[[
	Bhed game
	2012.09.01
	Top-down zombie shooter

	Programming: Földvári András, Dömötör Szilárd
	Art, Music: Tóth György
--]]
THIS = ''
require 'lib.middleclass'

local bump = require 'lib.bump'
local entity = require 'entities.Entity'
local timer = require 'lib.timer'
local effect = require 'effect.effect'

unit = 1  --firing rate's unit --sec

livingPlayers = {}
livingEnemies = 0

screen={}
screen.width = love.graphics.getWidth()
screen.height = love.graphics.getHeight()
dims = {}
dims.bullet = 3
dims.player = 25
dims.block = 32
dims.enemy = 25
dims.pickup = 16
local map = require 'map'
---bump callbacks---
function bump.collision(obj1, obj2, dx, dy)
  obj1:collision(obj2,  dx,  dy)
  obj2:collision(obj1, -dx, -dy)
end

function bump.endCollision(obj1, obj2)
  obj1:endCollision(obj2)
  obj2:endCollision(obj1)
end

function bump.shouldCollide(obj1, obj2)
  return obj1:shouldCollide(obj2) or
         obj2:shouldCollide(obj1)
end

function bump.getBBox(obj)
  return obj:getBBox()
end

---löve callbacks---:)
function love.load()
bump.initialize(32)

  map.load1()
end

function love.update(dt)
  effect:updateAll(dt)
  entity:updateAll(dt)
  timer:updateAll(dt)
  bump.collide()
  map.updateLevel()
  THIS = livingEnemies
end

function love.draw()
  if 211 ~= love.graphics.getBackgroundColor() then love.graphics.setBackgroundColor(211,211,211) end
  effect:drawAll()
  entity:drawAll()
  drawDebug()
  --if EXPx then love.graphics.rectangle('line', EXPx,EXPy,EXPw,EXPh) end
end

function love.keypressed(key)
  if player1:notDead() then player1:keypressed(key) end
  if player2~= nil and player2:notDead() then player2:keypressed(key) end
  if key == "p" then map.load1() end
  if key=="escape" then love.event.push('quit') end
end
---"px"..player1.getX().."py"..player1.getY()

function drawDebug()
  local r,g,b = love.graphics.getColor()
  love.graphics.setColor(0,0,0)
  love.graphics.print('fps:'..love.timer.getFPS()..'      '..THIS..'  P1: '..player1:getCurrWeapon()..':'..player1:getAmmo()..' hp:'..player1:getHP()..' score: '..player1.score..'-'..player1.mul..'  P2: '..player2:getCurrWeapon()..':'..player2:getAmmo()..' hp: '..player2:getHP()..' score: '..player2.score..'-'..player2.mul,40,40)
  love.graphics.setColor(r,g,b)
end
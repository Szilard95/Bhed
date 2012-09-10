local map = {}
local timer = require 'lib.timer'
local entity = require 'entities.Entity'
local wall = require 'entities.blocks.Wall'
local Barrel = require 'entities.blocks.Barrel'
--local enemy = require 'entities.enemy.Enemy'
local zombie = require 'entities.enemy.Zombie'
--local boss = require 'entities.enemy.Boss'
local PickUp = require 'entities.Pickup'
local player = require 'entities.Player'
local width = screen.width
local height = screen.height
local blocksW = width/32  --40
local blocksH = height/32  --18
local bRes = 32
local enemies = 10
local bosses = 1
local toSpawn = 0
local spawns = {}
spawns[1] = {{x=width/2,y=1},{x=width/2,y=height-dims.enemy}}
actLevel = 1
actMap = 1
local choosenSpawn = 1

local spawnTimer = timer:new(5)
function map.reset()
	livingEnemies = 0
	enemies = 10
	entity:destroyAll()
end

function map.spawnEnemy(x,y,type)
		livingEnemies = livingEnemies + 1
		toSpawn = toSpawn - 1
		type:new(x,y)
end

function map.nextLevel()
	actLevel = actLevel + 1
	enemies = enemies + 5
	---if acrLevel .. inc bosses
	toSpawn = enemies--+bosses
end

function nextSpawn()
	if choosenSpawn >= #spawns[actMap] then
		return 1
	else
		return choosenSpawn + 1
	end
end

function map.updateLevel()
	if toSpawn ~= 0 and spawnTimer:trigger() then
		choosenSpawn = nextSpawn()
		map.spawnEnemy(spawns[actMap][choosenSpawn].x,spawns[actMap][choosenSpawn].y,zombie)
		--if actLevel...spawn bosses
		spawnTimer:reset()
	end
	if livingEnemies <= 0 and toSpawn == 0 then map.nextLevel() end
end

function map.load1()
	spawnTimer:start()
	map.reset()
	actLevel = 1
	actMap = 1
	player1 = player:new(500,220,1)
  	player2 = player:new(500,250,2)
	livingPlayers = {player1,player2}
	livingEnemies = 0
	toSpawn = enemies
	--walls--
	for x = 0, blocksW/2-2 do wall:new(x*bRes,0) end--top walls
	for x = blocksW/2+2,blocksW-1 do wall:new(x*bRes,0) end
	for x = 0, blocksW/2-2 do wall:new(x*bRes,height-32) end
	for x = blocksW/2+2,blocksW-1 do wall:new(x*bRes,height-32) end
	for x = 1,blocksH-2 do wall:new(0,x*bRes) end--down walls
	for x = 1,blocksH-2 do wall:new(width-bRes,x*bRes) end

	for x = blocksW/2-1, blocksW/2+1 do wall:new(x*bRes,-bRes) end--invis walls @ spawns
	for x = blocksW/2-1, blocksW/2+1 do wall:new(x*bRes,height) end
	--barrels--
	for x = 1, 4 do Barrel:new((blocksW/2-2)*bRes,x*bRes) end
	for x = 1, 4 do Barrel:new((blocksW/2+2)*bRes,x*bRes) end
	for x = blocksH-5, blocksH-2 do Barrel:new((blocksW/2-2)*bRes,x*bRes) end
	for x = blocksH-5, blocksH-2 do Barrel:new((blocksW/2+2)*bRes,x*bRes) end
	--level1

end

function map.load2()
	spawnTimer:start()
	map.reset()
	actLevel = 1
	actMap = 1
	player1 = player:new(500,220,1)
  	player2 = player:new(500,250,2)
	livingPlayers = {player1,player2}
	livingEnemies = 0
	toSpawn = enemies
	Barrel:new(width/2,height/2)
	Barrel:new(600,500)
	Barrel:new(650,500)
	--Barrel:new(500,700)

end

return map
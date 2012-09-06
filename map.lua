local map = {}

local entity = require 'entities.Entity'
local wall = require 'entities.blocks.Wall'
local Barrel = require 'entities.blocks.Barrel'
--local enemy = require 'entities.enemy.Enemy'
local zombie = require 'entities.enemy.Zombie'
--local boss = require 'entities.enemy.Boss'
local PickUp = require 'entities.pickup'
local player = require 'entities.Player'
local width = screen.width
local height = screen.height
local blocksV = width/32  --40
local blocksH = height/32  --18
local bRes = 32

function map.reset()
	entity:destroyAll()

end

function map.load1()
	map.reset()

	player1 = player:new(500,220,1)
  	player2 = player:new(500,250,2)
	livingPlayers = {player1,player2}
	for x = 0, blocksV-1 do wall:new(x*bRes,0) end
	for x = 0, blocksV-1 do wall:new(x*bRes,height-bRes) end
	for x = 0, blocksH-1 do wall:new(0,x*bRes) end
	for x = 0, blocksH-1 do wall:new(width-bRes,x*bRes) end
	for x = 0, blocksH-1 do Barrel:new(width/3,x*bRes) end
	PickUp:new(200,200)
	PickUp:new(350,400)
	zombie:new(50,50)
	zombie:new(100,100)
	zombie:new(150,150)
	zombie:new(200,200)
	zombie:new(250,250)
	zombie:new(300,300)

end

function map.load2()

end

return map
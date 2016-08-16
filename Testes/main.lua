require "gameobject"
require "player"
require "enemy"

objects = {}

function love.load()
	table.insert(objects, player:new{x=90})
	table.insert(objects, enemy:new{x=500})
end

function love.update(dt)
	for i,obj in ipairs(objects) do
		obj:update(dt)
		print(obj.teste)
	end
end

function love.draw()
	for i,obj in ipairs(objects) do
		obj:draw()
	end
end
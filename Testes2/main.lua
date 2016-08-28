require "map"
require "gameobject"
require "player"
require "enemy"

objects = {}
global={}
global.map = map:new()

function love.load()
	table.insert(objects, player:new{x=90})
	table.insert(objects, enemy:new{x=500})
	canvas = love.graphics.newCanvas(640,480)
	canvas:setFilter("nearest","nearest")
	global.map:loadMap("Assets/testemenor.lua")

end

function love.update(dt)
	for i,obj in ipairs(objects) do
		obj:update(dt)
		print(obj.teste)
	end
end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear()
	global.map:draw()
	for i,obj in ipairs(objects) do
		obj:draw()
	end
	love.graphics.setCanvas()
	love.graphics.draw(canvas,0,0,0,1,1)
end

function love.keypressed(key)
	objects[1].dy = -5
end
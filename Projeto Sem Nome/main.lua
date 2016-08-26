gameobject = require "gameobject"
map = require "map"

player = gameobject:new({image=love.graphics.newImage("assets/knight.png")})

function love.load()
	canvas = love.graphics.newCanvas(128,128)
	canvas:setFilter("nearest","nearest")

	player:createAnim("idle",0,0,8,8,7)
	map:loadMap("assets/level1.lua")

end

function love.update(dt)
	player:update(dt)

end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear()
	map:draw()
	player:draw()

	love.graphics.setCanvas()

	love.graphics.draw(canvas,0,0,0,4,4)
end
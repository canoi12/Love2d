require "gameobject"
require "player"
require "gamescreen"

gravity=0.3

function love.load()
	love.window.setMode(512,512)
	gamescreen:init()
	player:init()
end

function love.update(dt)
	player:update(dt)
end

function love.draw()
	love.graphics.scale(4,4)
	
	gamescreen:draw()
	player:draw()
end
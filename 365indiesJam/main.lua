require "gameobject"
require "player"
require "utils"
require "map"
require "gamescreen"
require "enemy"
require "dolphin"
require "coelho"
require "swordcol"
require "sword"
require "screenmanager"
require "Screens/menuscreen"
require "Screens/level1screen"
require "Screens/level2screen"


camera={}
camera.x=0
camera.y=0

objects={}

function love.load()
	screenmanager:addScreen("menu",menu:new())
	screenmanager:addScreen("level1",level1:new())
	screenmanager:addScreen("level2",level2:new())
end

function love.update(dt)

	screenmanager:update(dt)
	if screenmanager.currentScreen.map.test ~= nil then
		camera.x = math.min(0,math.max(camera.x,-(screenmanager.currentScreen.map.test.width*16)+128))
		camera.y = math.min(0,math.max(camera.y,-(screenmanager.currentScreen.map.test.height*16)+128))
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(4,4)
	screenmanager:draw()
	love.graphics.pop()
end
require "gameobject"
require "player"
require "utils"
require "map"
require "gamescreen"
require "enemy"
require "dolphin"
require "bullet"
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

global = {}

global.width = 128
global.height = 128

scaleX = 4
scaleY = 4

objects={}

function love.load()
	screenmanager:addScreen("menu",menu:new())
	screenmanager:addScreen("level1",level1:new())

	love.window.setMode(scaleX*global.width, scaleY*global.height,{resizable = true})

	canvas = love.graphics.newCanvas(global.width, global.height)
	canvas:setFilter("nearest","nearest")
	--screenmanager:addScreen("level2",level2:new())
end

function love.update(dt)

	screenmanager:update(dt)
	if screenmanager.currentScreen.map.test ~= nil then
		--camera.x = math.min(0,math.max(camera.x,-(screenmanager.currentScreen.map.test.width*16)+global.width))
		--camera.y = math.min(0,math.max(camera.y,-(screenmanager.currentScreen.map.test.height*16)+global.height))
	end

	scaleX = math.floor(love.graphics:getWidth()/global.width)
	scaleY = math.floor(love.graphics:getHeight()/global.height)

	if scaleX < scaleY then
		scaleY = scaleX
	else
		scaleX = scaleY
	end
end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.push()
	--love.graphics.scale(2,2)
	screenmanager:draw()
	love.graphics.pop()
	love.graphics.setCanvas()
	love.graphics.draw(canvas,0,0,0,scaleX, scaleY)
end

function love.keypressed(key)
	screenmanager:keypressed(key)
end
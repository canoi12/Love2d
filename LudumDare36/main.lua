screenmanager = require("screenmanager")
gameobject = require("gameobject")
require "gamescreen"
require "levelscreen"
require "menuscreen"
require "player"
require "enemy"
require "foot"
require "camel"
require "lion"
require "utils"

Joystick = love.joystick.getJoysticks()

camerax = 0
cameray = 0

global = {}

global.width = 320
global.height = 240

global.roomWidth = 2560
global.roomHeight = 1920

scaleX = 2
scaleY = 2

function love.load()
	screenmanager:addScreen("menu",menu)
	screenmanager:addScreen("level",level)

	canvas = love.graphics.newCanvas(320,240)
	canvas:setFilter("nearest","nearest")
end

function love.update(dt)
	screenmanager:update(dt)
	--print(Joystick[1]:getAxis(1))
end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.setBackgroundColor(255, 204, 170, 255)
	love.graphics.clear()
	screenmanager:draw()

	love.graphics.setCanvas()
	love.graphics.draw(canvas,0,0,0,2,2)
end
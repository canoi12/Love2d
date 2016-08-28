gameobject = require "gameobject"
map = require "map"
require "utils"

player = gameobject:new({image=love.graphics.newImage("assets/emily coque-duplo.png")})

camerax = 0
cameray = 0

function love.load()
	canvas = love.graphics.newCanvas(128,128)
	canvas:setFilter("nearest","nearest")

	player:createAnim("idle",0,0,8,8,5)
	player:createAnim("walk",0,8,8,8,7)
	player:createAnim("jump",0,16,8,8,1)
	player:createAnim("fall",8,16,8,8,1)
	map:loadMap("assets/level1.lua")

	bg_image = love.graphics.newImage("assets/bg.png")
	bg_image:setFilter("nearest","nearest")
	bg_image:setWrap("repeat","repeat")
	bg_quad = love.graphics.newQuad(0,0,192,192,8,8)

	sound = love.audio.newSource("assets/blah.wav","static")
	sound:setLooping(true)

	sound:play()

end

function love.update(dt)
	player:update(dt)

	camerax = -player.x + 64
	cameray = -player.y + 64

	camerax = math.min(0,math.max(camerax,-192+128))
	cameray = math.min(0,math.max(cameray,-192+128))
end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.push()
	love.graphics.translate(camerax,cameray)
	love.graphics.clear()
	love.graphics.draw(bg_image,bg_quad,0,0)
	map:draw()
	player:draw()

	love.graphics.pop()
	love.graphics.setCanvas()

	love.graphics.draw(canvas,0,0,0,4,4)
end
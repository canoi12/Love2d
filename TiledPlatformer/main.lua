require "gameobject"
require "player"
require "block"
require "camera"
require "assets/mapa"
require "menuscreen"
require "gamescreen"
require "enemy"
require "editorscreen"
funcs = require "essential"
require "slime"

game = {}

game.roomwidth = 2840
game.roomheight = 480

game.state = {
}

function love.load()
	funcs:addScreen("menu",menuscreen)
	funcs:addScreen("game",gamescreen)
	funcs:addScreen("editor",editorscreen)
	funcs:setScreen("editor")
end

function love.update(dt)
	game.state[game.screenstate]:update(dt)
end

function love.draw()
	game.state[game.screenstate]:draw()
end

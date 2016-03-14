require "player"

game = {}

function love.load()
    player.load()
    
    game.background = love.graphics.newImage("assets/background.png")
    game.background:setWrap("repeat","repeat")
    
    game.bgquad = love.graphics.newQuad(0,0,love.graphics:getWidth(),love.graphics:getHeight(),game.background:getDimensions())
end

function love.update(dt)
    player.update(dt)
end

function love.draw()
    love.graphics.draw(game.background,game.bgquad,0,0)
    player.draw()
end
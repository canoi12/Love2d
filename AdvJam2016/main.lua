require "gameobject"
require "player"

function love.load()
    player:load()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(52,54,53,255)
    player:draw()
end
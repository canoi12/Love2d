require "screenmanager"
require "gameobject"

function love.load()
    teste = screenmanager:new()
    love.graphics.setDefaultFilter("nearest", "nearest")
end

function love.update(dt)
    teste:update(dt)
end

function love.draw()
    teste:draw()
end
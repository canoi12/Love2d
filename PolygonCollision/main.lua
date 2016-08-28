require "vector2"
require "utils"
require "triangle"

player = {}
player.x = 0
player.y = 0

function love.load()
    tri = triang:new(300, 300, 500, 300, 600, 400, 400, 400)
    isIns = false
end

function love.update(dt)
    local previousX = player.x
    local previousY = player.y
    if love.keyboard.isDown("left") then
        player.x = player.x - 4
    elseif love.keyboard.isDown("right") then
        player.x = player.x + 4
    end

    if love.keyboard.isDown("up") then
        player.y = player.y - 4
    elseif love.keyboard.isDown("down") then
        player.y = player.y + 4
    end

    isIns = false
    if tri:isInside(player.x, player.y) or tri:isInside(player.x + 32, player.y) or tri:isInside(player.x, player.y + 32) or tri:isInside(player.x + 32, player.y + 32) then
        isIns = true
        player.x = player.x - (player.x - previousX)
        player.y = player.y - (player.y - previousY)
    end
end

function love.draw()
    tri:draw()
    love.graphics.rectangle("line", player.x, player.y, 32, 32)
    if isIns then
        love.graphics.print("true", 0, 0)
    else
        love.graphics.print("false", 0, 0)
    end
end
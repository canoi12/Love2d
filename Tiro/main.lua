require "player"
require "bullet"
require "enemy"

game = {}
game.roomWidth = 1024
game.roomHeight = 768

function Clamp(v1,v2,v3)
    return math.max(v2,math.min(v1,v3))
end

function math.toInteger(v1)
    if v1 then
        return 1
    end
    return 0
end

function distance(x1,y1,x2,y2)
    local dx = x1-x2
    local dy = y1-y2
    return math.sqrt((dx*dx)+(dy*dy))
end

function math.toRadian(v1)
    return v1*math.pi/180
end

function love.load()
    game.background = love.graphics.newImage("assets/background.png")
    game.background:setWrap("repeat","repeat")
    
    game.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,game.background:getDimensions())
    player.load()
    bullet.load()
    enemy.load()
end

function love.update(dt)
    player.update(dt)
    bullet.update(dt)
    enemy.update(dt)
end

function love.draw()
    love.graphics.draw(game.background,game.bgquad,0,0)
    player.draw()
    bullet.draw()
    enemy.draw()
end
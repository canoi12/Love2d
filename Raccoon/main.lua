require "player"
require "camera"
require "bullet"
require "enemy"

game = {}
game.roomWidth = 1280
game.roomHeight = 960
game.windowWidth = 640
game.windowHeight = 480

function math.clamp(v1,v2,v3)
    if v1 < v2 then
        return v2
    elseif v1 > v3 then
        return v3
    end
    return v1
end

function math.lerp(v1,v2,v3)
    return v1 + v3*(v2-v1)
end

function distance(x1,y1,x2,y2)
    return math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)))
end


function love.load()
    player.load()
    
    game.background = love.graphics.newImage("assets/background.png")
    game.background:setWrap("repeat","repeat")
    
    game.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,game.background:getDimensions())
    
    bullet.load()
    enemy.load()
end

function love.update(dt)
    player.update(dt)
    camera.x = math.lerp(camera.x,math.clamp(player.x - (game.windowWidth/2),0,game.roomWidth-game.windowWidth),0.1)
    camera.y = math.lerp(camera.y,math.clamp(player.y - (game.windowHeight/2),0,game.roomHeight-game.windowHeight),0.1)
    bullet.update(dt)
    enemy.update(dt)
end

function love.draw()
    camera.set()
    love.graphics.draw(game.background,game.bgquad,0,0)
    player.draw()
    love.graphics.print(player.x,0,0)
    bullet.draw()
    enemy.draw()
    camera.unset()
end

function love.keypressed(key)
    bullet.keypressed(key)
end
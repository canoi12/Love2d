require "player"
require "camera"

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


function love.load()
    player.load()
    
    game.background = love.graphics.newImage("assets/background.png")
    game.background:setWrap("repeat","repeat")
    
    game.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,game.background:getDimensions())
end

function love.update(dt)
    player.update(dt)
    camera.x = math.clamp(player.x - (game.windowWidth/2),0,game.roomWidth-game.windowWidth)
    camera.y = math.clamp(player.y - (game.windowHeight/2),0,game.roomHeight-game.windowHeight)
end

function love.draw()
    camera.set()
    love.graphics.draw(game.background,game.bgquad,0,0)
    player.draw()
    love.graphics.print(player.x,0,0)
    camera.unset()
end
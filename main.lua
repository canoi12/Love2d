require("player")
require("block")
require("camera")

game = {}
game.windowWidth = 640
game.windowHeight = 480
game.roomWidth = 1280
game.roomHeight = 480

function math.clamp(v1,v2,v3)
    if v1 < v2 then
        return v2
    end
    if v1 > v3 then
        return v3
    end
    
    return v1
end

function love.load()
    player.load()
    bloco.load()
    gravity = 2000
end

function checkCol(x1,y1,w1,h1,x2,y2,w2,h2)
    if x1 < x2 + w2 and
       x1 + w1 > x2 and
       y1 < y2 + h2 and
       y1 + h1 > y2 then
        return true
    end
end

function love.update(dt)
    camera.x = math.clamp(player.x-(game.windowWidth/2),0,game.roomWidth/2)
    player.update(dt)
end

function love.draw()
    camera.set()
    player.draw()
    bloco.draw()
    camera.unset()
end

function love.keypressed(k)
    if k == "escape" then
        love.event.quit()
    end
    player.keypress(k)
end
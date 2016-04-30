require("player")
require("block")
require("camera")
require("enemy")
require("gamescreen")
require("menuscreen")

game = {}
game.windowWidth = 640
game.windowHeight = 480
game.roomWidth = 5120
game.roomHeight = 480
game.currentScreen = "menu"

function math.clamp(v1,v2,v3)
    if v1 < v2 then
        return v2
    end
    if v1 > v3 then
        return v3
    end
    
    return v1
end

function bool_to_int(valor)
    if valor == true then
        return 1
    end
    return 0
end

function love.load()
    menuscreen.load()
    gamescreen.load()
    gravity = 2000
    game.background = love.graphics.newImage("assets/background.png")
    game.background:setWrap("repeat","repeat")
    
    game.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,game.background:getDimensions())
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
    if game.currentScreen == "menu" then
        menuscreen.update()
    else
        gamescreen.update(dt)
    end
end

function love.draw(dt)
    if game.currentScreen == "menu" then
        menuscreen.draw()
    else
        gamescreen.draw()
    end
end

function love.keypressed(k)
    if k == "escape" then
        love.event.quit()
    end
    player.keypress(k)
end
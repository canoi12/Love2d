require "menu"
require "canhao"
require "player"
require "jogo"
require "background"

game = {}
game.roomWidth = 720
game.roomHeight = 400

game.windowWidth = love.graphics:getWidth()
game.windowHeight = love.graphics:getHeight()

game.currentScreen = "menu"

function math.clamp(v1,v2,v3)
    return math.max(v2,math.min(v1,v3))
end

function toint(v1)
    if v1 then
        return 1
    end
    return 0
end

function love.load()
    game.font = love.graphics.newFont("assets/font/Early GameBoy.ttf",12)
    menu.load()
    canhao.load()
    jogo.load()
    nave.load()
end

function love.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if game.currentScreen == "menu" then
        menu.update(dt)
    elseif game.currentScreen == "canhao" then
        canhao.update(dt)
        nave.update(dt)
    elseif game.currentScreen == "jogo" then
        jogo.update(dt)
        nave.update(dt)
    end
end

function love.draw()
    love.graphics.setFont(game.font)
    if game.currentScreen == "menu" then
        menu.draw()
    elseif game.currentScreen == "canhao" then
        canhao.draw()
        nave.draw()
    elseif game.currentScreen == "jogo" then
        jogo.draw()
        nave.draw()
    end
end
require "menu"

game = {}
game.roomWidth = 720
game.roomHeight = 400

game.windowWidth = love.graphics:getWidth()
game.windowHeight = love.graphics:getHeight()

game.currentScreen = "menu"

function love.load()
    game.font = love.graphics.newFont("assets/font/Early GameBoy.ttf",12)
    menu.load()
end

function love.update(dt)
    if game.currentScreen == "menu" then
       menu.update(dt)
    elseif game.currentScreen == "canhao" then
    
    elseif game.currentScreen == "jogo" then
     
    end
end

function love.draw()
    love.graphics.setFont(game.font)
    if game.currentScreen == "menu" then
       menu.draw()
    elseif game.currentScreen == "canhao" then
    
    elseif game.currentScreen == "jogo" then
     
    end
end
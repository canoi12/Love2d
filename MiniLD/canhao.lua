canhao = {}

function canhao.load()
    canhao.bkg1 = love.graphics.newImage("assets/cenarios/background/bkg1.png")
    canhao.bkg2 = love.graphics.newImage("assets/cenarios/background/bkg3.png")
    
    canhao.gun = {
        image = love.graphics.newImage("assets/cenarios/background/gun1.png"),
        x = 0,
        y = 0
    }
    
    background.load()
end

function canhao.update(dt)
    background.update(dt)
    if love.keyboard.isDown("space") then
        game.currentScreen = "jogo"
    end
    nave.update(dt)
end

function canhao.draw()
    background.draw()
    
    love.graphics.draw(canhao.bkg1,0,0)
    love.graphics.draw(canhao.gun.image,canhao.gun.x,canhao.gun.y)
    love.graphics.draw(canhao.bkg2,0,0)
    nave.draw()
end
menuscreen = {}

function menuscreen.load()
    x = 0
end

function menuscreen.update(dt)
    if love.keyboard.isDown("space") then
        game.currentScreen = "playing"
    end
    x = x + 0.1
    if math.mod(x,math.pi*2) == 0 then
        x = 0
    end
end

function menuscreen.draw()
    love.graphics.print("Fears",240,150+(math.sin(x)*32),0,5,5)
end
player = {}

function bool2int(valor)
    if valor then
        return 1
    end
    return 0
end

function player.load()
    player.x = 320
    player.y = 240
    player.speed = 250
    player.width = 32
    player.height = 32

end

function player.update(dt)
    player.x = player.x + ((bool2int(love.keyboard.isDown("right"))-bool2int(love.keyboard.isDown("left")))*(player.speed*dt))
    player.y = player.y + ((bool2int(love.keyboard.isDown("down"))-bool2int(love.keyboard.isDown("up")))*(player.speed*dt))
end

function player.draw()
    love.graphics.rectangle("line",player.x,player.y,player.width,player.height)
end
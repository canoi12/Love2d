player = {}

function player.load()
    player.x = 0
    player.y = 240
    player.width = 32
    player.height = 32
    player.speed = 200
    player.yvel = 600
    player.alpha = 100
end

function player.limits()
    player.x = math.clamp(player.x,0,love.graphics.getWidth()-player.width)
    player.y = math.clamp(player.y,0,love.graphics.getHeight()-player.height)
end

function player.update(dt)
    if love.keyboard.isDown("a","left") then
        player.x = player.x - (player.speed*dt)
    end
    if love.keyboard.isDown("d", "right") then
        player.x = player.x + (player.speed*dt)
    end
    player.y = player.y + (player.yvel*dt)
    player.yvel = player.yvel + (gravity*dt)
    if player.y+player.height + (player.yvel*dt) > love.graphics:getHeight() then
        player.yvel = 0
    end
    player.limits()
end

function player.draw()
    love.graphics.rectangle("line",player.x,player.y,player.width,player.height)
end

function player.keypress(k)
    if k == "up" and player.yvel == 0 then
        player.yvel = -300
    end
end
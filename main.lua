player = {}

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
    player.x = 0
    player.y = 240
    player.width = 32
    player.height = 32
    player.speed = 200
    player.yvel = 50
    player.alpha = 100
    gravity = 150
end

function player.checkCol(x1,y1,w1,h1,x2,y2,w2,h2)
    if x1 < x2 + w2 and
       x1 + w1 > x2 and
       y1 < y2 + h2 and
       y1 + h1 > y2 then
        return true
    end
end

function player.limits()
    player.x = math.clamp(player.x,0,love.graphics.getWidth()-player.width)
    player.y = math.clamp(player.y,0,love.graphics.getHeight()-player.height)
end

function love.update(dt)
    if love.keyboard.isDown("a","left") then
        player.x = player.x - (player.speed*dt)
    end
    if love.keyboard.isDown("d", "right") then
        player.x = player.x + (player.speed*dt)
    end
    --if love.keyboard.isDown("w","up") then
    --    player.y = player.y - (player.speed*dt)
    --end
    --if love.keyboard.isDown("s","down") then
    --    player.y = player.y + (player.speed*dt)
    --end
    player.y = player.y + (player.yvel*dt)
    player.yvel = player.yvel + (gravity*dt)
    if player.y+player.height + (player.yvel*dt) > love.graphics:getHeight() then
        player.yvel = 0
        if love.keyboard.isDown("up") then
        player.yvel = -100
    end
    end
    player.limits()
end

function love.draw()
    love.graphics.rectangle("line",player.x,player.y,player.width,player.height)
end
player = {}

function player.load()
    player.x = 0
    player.y = 240
    player.width = 32
    player.height = 32
    player.speed = 400
    player.xvel = 200
    player.yvel = 600
    player.alpha = 100
end

function player.limits()
    player.x = math.clamp(player.x,0,game.roomWidth-player.width)
    player.y = math.clamp(player.y,0,love.graphics.getHeight()-player.height)
end

function player.update(dt)
    if love.keyboard.isDown("left") then
        if player.xvel < player.speed then player.xvel = player.xvel + 10 end
        player.x = player.x - (player.xvel*dt)
    elseif love.keyboard.isDown("right") then
        if player.xvel < player.speed then player.xvel = player.xvel + 10 end
        player.x = player.x + (player.xvel*dt)
    else
        player.height = 32
        player.xvel = 0
    end
    if player.height > 24 then player.height = player.height-(player.xvel*dt/10) end
    player.yvel = player.yvel + (gravity*dt)
    player.y = player.y + (player.yvel*dt)
    for i,block in ipairs(blocks) do
        if checkCol(player.x,player.y,player.width,player.height,block.x,block.y,block.width,block.height) then
            player.yvel = 0
            player.y = block.y - player.height
            break
        end
        if player.y + player.height > love.graphics:getHeight() then
            player.yvel = 0
        end
    end
    for i,en in ipairs(enemies) do
        if checkCol(player.x,player.y+(player.yvel*dt),player.width,player.height,en.x,en.y,en.width,en.height) then
            if player.y + player.height <= en.y then
                table.remove(enemies,i)
                player.yvel = -200
            end
        end
    end
    player.limits()
end

function player.draw(dt)
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line",player.x,player.y,player.width,player.height)
    love.graphics.print(player.x,player.x,0)
end

function player.keypress(k)
    if k == "up" and player.yvel == 0 then
        player.yvel = -600
        
    end
end
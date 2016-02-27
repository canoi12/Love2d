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
    player.x = math.clamp(player.x,0,game.roomWidth-player.width)
    player.y = math.clamp(player.y,0,love.graphics.getHeight()-player.height)
end

function player.update(dt)
    if love.keyboard.isDown("a","left") then
        player.x = player.x - (player.speed*dt)
    end
    if love.keyboard.isDown("d", "right") then
        player.x = player.x + (player.speed*dt)
    end
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
        if checkCol(player.x,player.y,player.width,player.height,en.x,en.y,en.width,en.height) then
            if player.y + player.height <= en.y+16 then
                table.remove(enemies,i)
            end
        end
    end
    player.limits()
    enemy.update(dt)
end

function player.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line",player.x,player.y,player.width,player.height)
end

function player.keypress(k)
    if k == "up" and player.yvel == 0 then
        player.yvel = -600
        
    end
end
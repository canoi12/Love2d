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
    player.vertices = {x0 = player.x,y0 = player.y,x1 = player.x+player.width,y1 = player.y,x2 = player.x+player.width,y2 = player.y+player.height,x3 = player.x,y3 = player.y+player.height}
end



function player.limits()
    player.x = math.clamp(player.x,0,game.roomWidth-player.width)
    player.y = math.clamp(player.y,0,love.graphics.getHeight()-player.height)
end

function player.update(dt)
    player.vertices = {x0 = player.x,y0 = player.y,x1 = player.x+player.width,y1 = player.y,x2 = player.x+player.width,y2 = player.y+player.height,x3 = player.x,y3 = player.y+player.height}
    
    move = bool_to_int(love.keyboard.isDown("right")) - bool_to_int(love.keyboard.isDown("left"))
    player.xvel = (player.speed)*move
    player.x = player.x + (player.xvel*dt)
    
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
                player.yvel = -300
            end
        end
    end
    player.limits()
end

function player.draw(dt)
    love.graphics.setColor(255,255,255)
    love.graphics.polygon("line",player.vertices.x0,player.vertices.y0,player.vertices.x1,player.vertices.y1,player.vertices.x2,player.vertices.y2,player.vertices.x3,player.vertices.y3)
    love.graphics.print(player.xvel,player.x,0)
end

function player.keypress(k)
    if k == "up" and player.yvel == 0 then
        player.yvel = -600
        
    end
end